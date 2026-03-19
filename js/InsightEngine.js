/**
 * InsightEngine.js — v2.0
 * Unified brain: insights + destination database
 * 
 * What's new in v2.0:
 * - Loads both /data/insights/ entries AND destination files
 * - Smart extractor: pulls only fields relevant to user query
 * - AI fallback flag: honest "not in our database" signal
 * - buildPromptContext(matches, userQuery) — single method for Groq prompt
 */

class InsightEngine {
  constructor(basePath = '/data/insights') {
    this.basePath = basePath;
    this.insights = [];
    this.loaded = false;
  }

  // ── LOAD ────────────────────────────────────────────────────
  async load() {
    try {
      const indexRes = await fetch(`${this.basePath}/index.json`);
      const index = await indexRes.json();

      const promises = index.entries.map(async (entry) => {
        try {
          const res = await fetch(`${this.basePath}/${entry.file}`);
          const data = await res.json();
          // Tag with index metadata in case file doesn't have it
          if (!data.id) data.id = entry.id;
          if (!data.type) data.type = entry.type;
          if (!data.state && entry.state) data.state = entry.state;
          return data;
        } catch (err) {
          console.warn(`InsightEngine: failed to load ${entry.file}`, err);
          return null;
        }
      });

      const results = await Promise.all(promises);
      this.insights = results.filter(Boolean);
      this.loaded = true;
      console.log(`InsightEngine v2.0: loaded ${this.insights.length} entries (insights + destinations)`);
    } catch (err) {
      console.error('InsightEngine: failed to load index', err);
    }
  }

  // ── GEOGRAPHIC SCOPE MATCH ──────────────────────────────────
  // Core matching method — checks user text against geographic_scope[]
  // Returns matched entries, sorted by hidden_score desc
  scopeMatch(text, destination = '') {
    if (!this.loaded) return [];
    const combined = `${text} ${destination}`.toLowerCase();

    const matches = this.insights.filter(entry => {
      const scope = entry.geographic_scope || [];
      // Sort scope keywords longest first (multi-word matches win)
      const sorted = [...scope].sort((a, b) => b.length - a.length);
      return sorted.some(k => combined.includes(k.toLowerCase()));
    });

    return matches.sort((a, b) => (b.hidden_score || 0) - (a.hidden_score || 0));
  }

  // ── SMART EXTRACTOR ─────────────────────────────────────────
  // Pulls only the fields relevant to this specific query
  // Keeps prompt lean — no dumping entire JSON into Groq
  smartExtract(entry, userQuery = '') {
    const q = userQuery.toLowerCase();
    const extracted = {};

    // Always include these
    extracted.id = entry.id;
    extracted.type = entry.type;
    extracted.title = entry.title || entry.district || entry.name;
    extracted.region = entry.region || entry.state;
    extracted.hidden_score = entry.hidden_score;
    extracted.incitetales_angle = entry.incitetales_angle;
    extracted.permit = entry.permit || (entry.local_intel?.permit_needed !== undefined ? {
      required: entry.local_intel.permit_needed,
      notes: entry.local_intel.permit_notes || entry.permit_notes
    } : null);
    extracted.connectivity = entry.connectivity;
    extracted.season = entry.season;

    // ── For DESTINATION type entries ──
    if (entry.type === 'destination') {
      const dests = entry.destinations || [];

      // Figure out which specific destination(s) the query is about
      const relevantDests = dests.filter(d => {
        const name = (d.name || d.id || '').toLowerCase();
        const tags = (d.tags || []).join(' ').toLowerCase();
        return q.includes(name) || name.split(' ').some(w => w.length > 3 && q.includes(w));
      });

      // If specific destination matched, use that; otherwise use all
      const targetDests = relevantDests.length > 0 ? relevantDests : dests;

      extracted.destinations = targetDests.map(d => ({
        name: d.name,
        tagline: d.tagline,
        what_is_there: d.what_is_there,
        stays: d.stays,
        local_food: d.local_food,
        local_tips: d.local_tips,
        hidden_score: d.hidden_score,
        altitude_m: d.altitude_m
      }));

      // Route — always extract if asking about travel
      if (entry.routes) {
        const routeKey = q.includes('dibrugarh') ? 'from_dibrugarh' : 'from_guwahati';
        const route = entry.routes[routeKey] || entry.routes.from_guwahati;
        if (route) {
          extracted.route = {
            from: routeKey.replace('from_', '').replace('_', ' '),
            total_distance_km: route.total_distance_km,
            travel_days: route.travel_days,
            drive_hours: route.drive_hours,
            day_splits: route.day_splits,
            nearest_airport: route.nearest_airport,
            nearest_railhead: route.nearest_railhead
          };
        }
      }
    }

    // ── For INSIGHT type entries ──
    else {
      extracted.description = entry.description;
      extracted.what_most_people_miss = entry.what_most_people_miss;
      extracted.stays = entry.stays;
      extracted.local_intel = entry.local_intel;

      // Cultural entries — include dos/donts
      if (entry.type === 'cultural') {
        extracted.cultural_dos = entry.cultural_dos;
        extracted.cultural_donts = entry.cultural_donts;
        extracted.language_tips = entry.language_tips;
      }
    }

    return extracted;
  }

  // ── BUILD PROMPT CONTEXT ─────────────────────────────────────
  // Main method called by the itinerary builder
  // Returns: { contextBlock, matchedEntries, hasVerifiedData, isAIOnly }
  buildPromptContext(userText, destination = '', selectedIds = null) {
    if (!this.loaded) {
      return { contextBlock: '', matchedEntries: [], hasVerifiedData: false, isAIOnly: true };
    }

    // Get scope matches
    let matches = this.scopeMatch(userText, destination);

    // If user selected specific entries (from selector panel), filter to those
    if (selectedIds && selectedIds.size > 0) {
      matches = matches.filter(m => selectedIds.has(m.id));
    }

    // No matches — AI generates freely
    if (matches.length === 0) {
      return {
        contextBlock: '',
        matchedEntries: [],
        hasVerifiedData: false,
        isAIOnly: true,
        aiOnlyNote: 'This destination is not yet in the Incitetales verified database. This itinerary is generated by AI from general knowledge.'
      };
    }

    // Extract relevant fields for each match
    const extracted = matches.map(m => this.smartExtract(m, userText));

    // Build the context block string for Groq
    const contextBlock = this._buildContextString(extracted);

    return {
      contextBlock,
      matchedEntries: matches,
      hasVerifiedData: true,
      isAIOnly: false
    };
  }

  // ── CONTEXT STRING BUILDER ───────────────────────────────────
  // Formats extracted data as clear instructions for Groq
  _buildContextString(extractedEntries) {
    const lines = [
      'VERIFIED LOCAL KNOWLEDGE FROM INCITETALES DATABASE:',
      'The following has been verified on the ground by the Incitetales team.',
      'Use this data exactly. Do not substitute with generic information.',
      'If a location is listed here, include it in the itinerary by name.',
      ''
    ];

    extractedEntries.forEach((e, i) => {
      lines.push(`[${ i + 1 }] ${ e.title } (${ e.type.toUpperCase() }${ e.hidden_score ? ' · Hidden Score: ' + e.hidden_score + '/10' : '' })`);
      lines.push(`Region: ${ e.region }`);

      if (e.incitetales_angle) {
        lines.push(`Local angle: "${ e.incitetales_angle }"`);
      }

      if (e.season?.best) {
        lines.push(`Best months: ${ e.season.best.join(', ') }`);
      }

      // Destination-specific
      if (e.destinations?.length) {
        e.destinations.forEach(d => {
          lines.push(`\nDestination: ${ d.name }${ d.altitude_m ? ' (' + d.altitude_m + 'm)' : '' }`);
          if (d.tagline) lines.push(`  → ${ d.tagline }`);
          if (d.what_is_there?.length) {
            lines.push(`  What's there: ${ d.what_is_there.slice(0, 4).join(' | ') }`);
          }
          if (d.stays?.length) {
            lines.push(`  Stays: ${ d.stays.map(s => `${ s.name } (${ s.type }${ s.price_range ? ', ' + s.price_range : '' })`).join(', ') }`);
          }
          if (d.local_food?.length) {
            lines.push(`  Local food: ${ d.local_food.slice(0, 4).join(', ') }`);
          }
          if (d.local_tips?.length) {
            lines.push(`  Local tips: ${ d.local_tips.slice(0, 3).join(' | ') }`);
          }
        });
      }

      // Route day splits
      if (e.route?.day_splits?.length) {
        lines.push(`\nROUTE from ${ e.route.from } (${ e.route.travel_days } travel days, ${ e.route.total_distance_km }km):`);
        e.route.day_splits.forEach(day => {
          lines.push(`  Day ${ day.day }: ${ day.start } → ${ day.end } (${ day.drive_hours })`);
          if (day.stops?.length) {
            lines.push(`    Stops: ${ day.stops.join(', ') }`);
          }
          if (day.notes) lines.push(`    Note: ${ day.notes }`);
        });
        if (e.route.nearest_airport) lines.push(`  Nearest airport: ${ e.route.nearest_airport }`);
      }

      // Insight-specific
      if (e.what_most_people_miss) {
        lines.push(`\nWhat most people miss: ${ e.what_most_people_miss }`);
      }
      if (e.local_intel?.how_to_get) {
        lines.push(`How to get there: ${ e.local_intel.how_to_get }`);
      }

      // Permit
      if (e.permit?.required === true) {
        lines.push(`\n⚠ PERMIT REQUIRED: ${ e.permit.type?.join(', ') || 'ILP' }`);
        if (e.permit.how_to_apply) lines.push(`  Apply: ${ e.permit.how_to_apply }`);
        if (e.permit.cost) lines.push(`  Cost: ${ e.permit.cost }`);
        if (e.permit.notes) lines.push(`  Note: ${ e.permit.notes }`);
      }
      if (e.permit?.required === false) {
        lines.push(`✓ No permit needed`);
      }

      // Connectivity
      if (e.connectivity) {
        const sig = e.connectivity.mobile_signal || e.connectivity.mobile;
        if (sig === 'none') lines.push(`📵 NO mobile signal. Warn traveller to inform someone before entering.`);
        else if (sig === 'limited') lines.push(`📶 Limited signal. ${ e.connectivity.notes || 'BSNL most reliable.' }`);
        else if (sig) lines.push(`📶 Connectivity: ${ e.connectivity.notes || sig }`);
        if (e.connectivity.atm) lines.push(`💰 ATM: ${ e.connectivity.atm }`);
      }

      // Cultural
      if (e.cultural_dos?.length) {
        lines.push(`\nCultural dos: ${ e.cultural_dos.slice(0, 3).join(' | ') }`);
      }
      if (e.language_tips) {
        const tips = Object.entries(e.language_tips).slice(0, 3).map(([k, v]) => `${ k }: "${ v }"`).join(', ');
        lines.push(`Language: ${ tips }`);
      }

      lines.push('\n---');
    });

    lines.push('');
    lines.push('INSTRUCTIONS:');
    lines.push('- Include verified locations by name in the itinerary');
    lines.push('- Use route day_splits for travel days — these are actual times, not estimates');
    lines.push('- Use recommended stays — do not replace with generic hotel names');
    lines.push('- Use "what most people miss" as the local tip for that day');
    lines.push('- Mention permits explicitly in the permits section');
    lines.push('- Warn about no-signal areas — tell traveller to inform someone');

    return lines.join('\n');
  }

  // ── STANDARD QUERY (unchanged from v1) ──────────────────────
  query(filters = {}) {
    if (!this.loaded) return [];
    let results = [...this.insights];

    if (filters.type)               results = results.filter(i => i.type === filters.type);
    if (filters.state)              results = results.filter(i => i.state?.toLowerCase() === filters.state.toLowerCase());
    if (filters.month) {
      const m = filters.month.toLowerCase();
      results = results.filter(i => i.season?.best?.includes(m) || i.season?.also_good?.includes(m) || i.season?.shoulder?.includes(m));
    }
    if (filters.minHiddenScore !== undefined) results = results.filter(i => (i.hidden_score || 0) >= filters.minHiddenScore);
    if (filters.permitNeeded !== undefined) {
      results = results.filter(i => {
        const p = i.permit?.required ?? i.local_intel?.permit_needed ?? i.permit_needed;
        return p === filters.permitNeeded;
      });
    }
    if (filters.physicalLevel)      results = results.filter(i => i.local_intel?.physical_level === filters.physicalLevel);
    if (filters.hasStay)            results = results.filter(i => (i.stays?.length > 0) || i.destinations?.some(d => d.stays?.length > 0));
    if (filters.stayType)           results = results.filter(i => i.stays?.some(s => s.type === filters.stayType) || i.destinations?.some(d => d.stays?.some(s => s.type === filters.stayType)));
    if (filters.noSignal)           results = results.filter(i => i.connectivity?.mobile_signal === 'none' || i.connectivity?.mobile === 'none');
    if (filters.tags?.length)       results = results.filter(i => filters.tags.some(t => i.tags?.map(x => x.toLowerCase()).includes(t.toLowerCase())));

    results.sort((a, b) => (b.hidden_score || 0) - (a.hidden_score || 0));
    if (filters.limit) results = results.slice(0, filters.limit);
    return results;
  }

  // ── SHORTHAND METHODS ────────────────────────────────────────
  hiddenGems(minScore = 7)  { return this.query({ minHiddenScore: minScore }); }
  goodInMonth(month)        { return this.query({ month }); }
  byState(state)            { return this.query({ state }); }
  homestays()               { return this.query({ stayType: 'homestay' }); }
  campStays()               { return this.query({ stayType: 'camp' }); }
  digitalDetox()            { return this.query({ noSignal: true }); }
  getById(id)               { return this.insights.find(i => i.id === id) || null; }
  getBySlug(slug)           { return this.insights.find(i => i.slug === slug) || null; }

  search(term) {
    const t = term.toLowerCase();
    return this.insights.filter(i =>
      i.title?.toLowerCase().includes(t) ||
      i.description?.toLowerCase().includes(t) ||
      i.incitetales_angle?.toLowerCase().includes(t) ||
      i.tags?.some(tag => tag.toLowerCase().includes(t)) ||
      i.region?.toLowerCase().includes(t) ||
      i.state?.toLowerCase().includes(t) ||
      i.destinations?.some(d => d.name?.toLowerCase().includes(t))
    );
  }

  stats() {
    const types = {}, states = {};
    this.insights.forEach(i => {
      types[i.type] = (types[i.type] || 0) + 1;
      if (i.state) states[i.state] = (states[i.state] || 0) + 1;
    });
    return {
      total: this.insights.length,
      byType: types,
      byState: states,
      verified: this.insights.filter(i => i.verified).length,
      avgHiddenScore: (this.insights.reduce((s, i) => s + (i.hidden_score || 0), 0) / this.insights.length).toFixed(1)
    };
  }
}

if (typeof module !== 'undefined') module.exports = InsightEngine;

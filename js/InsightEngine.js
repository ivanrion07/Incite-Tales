/**
 * InsightEngine.js
 * The Local Insight Engine for Incitetales
 * Reads the /data/insights/ flat file brain and returns filtered, ranked results.
 * 
 * Usage:
 *   const engine = new InsightEngine();
 *   await engine.load();
 *   const results = engine.query({ type: 'route', month: 'december', state: 'Meghalaya' });
 */

class InsightEngine {
  constructor(basePath = '/data/insights') {
    this.basePath = basePath;
    this.insights = [];
    this.loaded = false;
  }

  // ─────────────────────────────────────────────
  // LOAD — reads index.json, then loads every file
  // ─────────────────────────────────────────────
  async load() {
    try {
      const indexRes = await fetch(`${this.basePath}/index.json`);
      const index = await indexRes.json();

      const promises = index.entries.map(async (entry) => {
        try {
          const res = await fetch(`${this.basePath}/${entry.file}`);
          const data = await res.json();
          return data;
        } catch (err) {
          console.warn(`InsightEngine: failed to load ${entry.file}`, err);
          return null;
        }
      });

      const results = await Promise.all(promises);
      this.insights = results.filter(Boolean);
      this.loaded = true;
      console.log(`InsightEngine: loaded ${this.insights.length} insights`);
    } catch (err) {
      console.error('InsightEngine: failed to load index', err);
    }
  }

  // ─────────────────────────────────────────────
  // QUERY — main filter + rank method
  //
  // Supported filters:
  //   type       — 'hidden-spot' | 'seasonal' | 'cultural' | 'offbeat' | 'experience' | 'route'
  //   state      — e.g. 'Meghalaya', 'Assam', 'Arunachal Pradesh', 'Nagaland'
  //   region     — partial match on region string
  //   month      — e.g. 'december' — returns only entries where that month is best/also_good
  //   tags       — array of tags, e.g. ['camping', 'river'] — any match
  //   minHiddenScore — number 1–10
  //   permitNeeded   — true | false
  //   physicalLevel  — 'easy' | 'moderate' | 'challenging'
  //   hasStay        — true — only entries with stays[] array
  //   stayType       — 'homestay' | 'camp' | 'hotel' | 'resort'
  //   noSignal       — true — only entries where connectivity is none
  //   verified       — true | false
  //   limit          — max results to return (default: all)
  //   sortBy         — 'hidden_score' | 'last_updated' (default: hidden_score desc)
  // ─────────────────────────────────────────────
  query(filters = {}) {
    if (!this.loaded) {
      console.warn('InsightEngine: call load() before query()');
      return [];
    }

    let results = [...this.insights];

    // Filter: type
    if (filters.type) {
      results = results.filter(i => i.type === filters.type);
    }

    // Filter: state
    if (filters.state) {
      results = results.filter(i =>
        i.state?.toLowerCase() === filters.state.toLowerCase() ||
        i.districts?.some(d => d.toLowerCase().includes(filters.state.toLowerCase()))
      );
    }

    // Filter: region (partial match)
    if (filters.region) {
      const r = filters.region.toLowerCase();
      results = results.filter(i =>
        i.region?.toLowerCase().includes(r)
      );
    }

    // Filter: month — check season.best and season.also_good
    if (filters.month) {
      const m = filters.month.toLowerCase();
      results = results.filter(i => {
        const s = i.season;
        if (!s) return false;
        return (
          s.best?.includes(m) ||
          s.also_good?.includes(m) ||
          s.shoulder?.includes(m)
        );
      });
    }

    // Filter: avoid month — exclude entries where this month is in season.avoid
    if (filters.avoidMonth) {
      const m = filters.avoidMonth.toLowerCase();
      results = results.filter(i => {
        const avoid = i.season?.avoid || [];
        return !avoid.includes(m);
      });
    }

    // Filter: tags (any match)
    if (filters.tags && filters.tags.length > 0) {
      results = results.filter(i =>
        filters.tags.some(tag =>
          i.tags?.map(t => t.toLowerCase()).includes(tag.toLowerCase())
        )
      );
    }

    // Filter: minimum hidden score
    if (filters.minHiddenScore !== undefined) {
      results = results.filter(i => (i.hidden_score || 0) >= filters.minHiddenScore);
    }

    // Filter: permit needed
    if (filters.permitNeeded !== undefined) {
      results = results.filter(i => {
        const permit = i.permit_needed ?? i.local_intel?.permit_needed;
        return permit === filters.permitNeeded;
      });
    }

    // Filter: physical level
    if (filters.physicalLevel) {
      results = results.filter(i =>
        i.local_intel?.physical_level === filters.physicalLevel
      );
    }

    // Filter: has stays
    if (filters.hasStay === true) {
      results = results.filter(i => i.stays && i.stays.length > 0);
    }

    // Filter: stay type
    if (filters.stayType) {
      results = results.filter(i =>
        i.stays?.some(s => s.type === filters.stayType)
      );
    }

    // Filter: no mobile signal only
    if (filters.noSignal === true) {
      results = results.filter(i =>
        i.connectivity?.mobile_signal === 'none' ||
        i.local_intel?.connectivity?.mobile_signal === 'none'
      );
    }

    // Filter: verified
    if (filters.verified !== undefined) {
      results = results.filter(i => i.verified === filters.verified);
    }

    // Sort
    const sortBy = filters.sortBy || 'hidden_score';
    if (sortBy === 'hidden_score') {
      results.sort((a, b) => (b.hidden_score || 0) - (a.hidden_score || 0));
    } else if (sortBy === 'last_updated') {
      results.sort((a, b) => (b.last_updated || '').localeCompare(a.last_updated || ''));
    }

    // Limit
    if (filters.limit) {
      results = results.slice(0, filters.limit);
    }

    return results;
  }

  // ─────────────────────────────────────────────
  // SHORTHAND METHODS — common queries pre-built
  // ─────────────────────────────────────────────

  // Best time to visit a specific entry by id
  bestMonths(id) {
    const entry = this.insights.find(i => i.id === id);
    if (!entry) return null;
    return {
      best: entry.season?.best || [],
      also_good: entry.season?.also_good || [],
      avoid: entry.season?.avoid || [],
      notes: entry.season?.notes || ''
    };
  }

  // Get all entries for a given state
  byState(state) {
    return this.query({ state });
  }

  // Get all hidden gems above a score threshold
  hiddenGems(minScore = 7) {
    return this.query({ minHiddenScore: minScore, sortBy: 'hidden_score' });
  }

  // Get all entries good for a specific month
  goodInMonth(month) {
    return this.query({ month });
  }

  // Get all entries with homestay options
  homestays() {
    return this.query({ stayType: 'homestay' });
  }

  // Get all entries with riverside/camp stay options
  campStays() {
    return this.query({ stayType: 'camp' });
  }

  // Get all no-signal locations (digital detox)
  digitalDetox() {
    return this.query({ noSignal: true });
  }

  // Get a single entry by id
  getById(id) {
    return this.insights.find(i => i.id === id) || null;
  }

  // Get a single entry by slug
  getBySlug(slug) {
    return this.insights.find(i => i.slug === slug) || null;
  }

  // Full text search across title, description, tags, incitetales_angle
  search(term) {
    const t = term.toLowerCase();
    return this.insights.filter(i => {
      return (
        i.title?.toLowerCase().includes(t) ||
        i.description?.toLowerCase().includes(t) ||
        i.incitetales_angle?.toLowerCase().includes(t) ||
        i.tags?.some(tag => tag.toLowerCase().includes(t)) ||
        i.region?.toLowerCase().includes(t) ||
        i.district?.toLowerCase().includes(t) ||
        i.state?.toLowerCase().includes(t)
      );
    });
  }

  // Summary stats — useful for admin/debug
  stats() {
    const types = {};
    const states = {};
    this.insights.forEach(i => {
      types[i.type] = (types[i.type] || 0) + 1;
      if (i.state) states[i.state] = (states[i.state] || 0) + 1;
    });
    return {
      total: this.insights.length,
      byType: types,
      byState: states,
      verified: this.insights.filter(i => i.verified).length,
      withStory: this.insights.filter(i => i.story_published).length,
      avgHiddenScore: (
        this.insights.reduce((sum, i) => sum + (i.hidden_score || 0), 0) /
        this.insights.length
      ).toFixed(1)
    };
  }
}

// Export for use in Cloudflare Worker, Node, or browser
if (typeof module !== 'undefined') module.exports = InsightEngine;

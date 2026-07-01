const InsightEngine = require('../js/InsightEngine');

// ── Fixtures ──────────────────────────────────────────────────
function makeEngine(entries = []) {
  const engine = new InsightEngine('/data/insights');
  engine.insights = entries;
  engine.loaded = true;
  return engine;
}

const HIDDEN_SPOT = {
  id: 'maguri-beel-hidden',
  slug: 'maguri-beel',
  type: 'hidden-spot',
  title: 'Maguri Beel',
  state: 'Assam',
  region: 'Upper Assam',
  hidden_score: 8,
  verified: true,
  incitetales_angle: 'Where the Dibru meets the Brahmaputra',
  description: 'A wetland birding paradise near Tinsukia',
  what_most_people_miss: 'Sunrise boat ride through the beel',
  geographic_scope: ['maguri', 'tinsukia', 'assam'],
  tags: ['birding', 'wetland', 'river', 'offbeat'],
  season: { best: ['november', 'december', 'january'], avoid: ['june', 'july'] },
  connectivity: { mobile_signal: 'limited', notes: 'BSNL most reliable.', atm: 'Tinsukia — 30 min' },
  permit: { required: false },
  stays: [
    { name: 'Banashree Eco Camp', type: 'camp', price_range: '₹800-1500' }
  ],
  local_intel: {
    how_to_get: 'Drive from Tinsukia (45 min)',
    physical_level: 'easy',
    permit_needed: false,
  },
};

const CULTURAL = {
  id: 'mising-tribe',
  type: 'cultural',
  title: 'Mising Tribe Culture',
  state: 'Assam',
  region: 'Majuli',
  hidden_score: 7,
  incitetales_angle: 'River island traditions',
  geographic_scope: ['majuli', 'assam'],
  tags: ['culture', 'tribe'],
  season: { best: ['october', 'november'] },
  cultural_dos: ['Remove shoes before entering a Chang Ghar', 'Ask before photographing'],
  cultural_donts: ['Do not point at sacred objects'],
  language_tips: { hello: 'Nohkkhow', thanks: 'Dhanyabad' },
};

const DESTINATION = {
  id: 'dibang-valley',
  type: 'destination',
  title: 'Dibang Valley',
  state: 'Arunachal Pradesh',
  region: 'Eastern Arunachal',
  hidden_score: 9,
  incitetales_angle: 'India\'s last frontier',
  geographic_scope: ['dibang', 'roing', 'anini', 'arunachal'],
  tags: ['frontier', 'mountains'],
  season: { best: ['october', 'november', 'march'], also_good: ['february'] },
  permit: { required: true, type: ['ILP'], how_to_apply: 'Online at arunachalilp.com', cost: '₹100' },
  connectivity: { mobile_signal: 'none' },
  routes: {
    from_dibrugarh: {
      total_distance_km: 210,
      travel_days: 2,
      drive_hours: 8,
      nearest_airport: 'Dibrugarh',
      nearest_railhead: 'Tinsukia',
      day_splits: [
        { day: 1, start: 'Dibrugarh', end: 'Roing', drive_hours: '5h', stops: ['Dhola-Sadiya Bridge'], notes: 'Start early' },
        { day: 2, start: 'Roing', end: 'Anini', drive_hours: '6h', stops: ['Mayodia Pass'] },
      ],
    },
    from_guwahati: {
      total_distance_km: 650,
      travel_days: 3,
      drive_hours: 18,
      nearest_airport: 'Guwahati',
      nearest_railhead: 'Guwahati',
      day_splits: [],
    },
  },
  destinations: [
    {
      id: 'roing',
      name: 'Roing',
      type: 'town',
      altitude_m: 350,
      tagline: 'Gateway to Dibang',
      what_is_there: ['Mehao Lake', 'Bhismaknagar Fort', 'Sally Lake'],
      stays: [{ name: 'Hotel Doying', type: 'hotel', price_range: '₹1200' }],
      local_food: ['Pika Pila', 'Smoked pork'],
      local_tips: ['Carry cash', 'Hire local guide'],
      hidden_score: 6,
      tags: ['gateway', 'lake'],
    },
    {
      id: 'anini',
      name: 'Anini',
      type: 'town',
      altitude_m: 1968,
      tagline: 'Edge of the map',
      what_is_there: ['Anini Viewpoint', 'Idu Mishmi culture'],
      stays: [{ name: 'Circuit House', type: 'guesthouse', price_range: '₹500' }],
      local_food: ['Idi rice', 'Dried fish'],
      local_tips: ['No ATM', 'Inform someone before entering'],
      hidden_score: 9,
      tags: ['remote', 'frontier'],
    },
  ],
};

const SEASONAL = {
  id: 'dzukou-valley-seasonal',
  type: 'seasonal',
  title: 'Dzukou Valley',
  state: 'Nagaland',
  region: 'Kohima',
  hidden_score: 6,
  geographic_scope: ['dzukou', 'nagaland', 'kohima'],
  tags: ['trekking', 'flowers'],
  season: { best: ['june', 'july', 'august'], shoulder: ['september'] },
  connectivity: { mobile_signal: 'none', mobile: 'none' },
  permit: { required: false },
};

const OFFBEAT = {
  id: 'shillong-dawki-route',
  type: 'offbeat',
  title: 'Shillong–Dawki–Shnongpedeng',
  state: 'Meghalaya',
  region: 'East Khasi Hills',
  hidden_score: 7,
  geographic_scope: ['shillong', 'dawki', 'shnongpedeng', 'meghalaya'],
  tags: ['offbeat', 'river', 'camping'],
  season: { best: ['november', 'december'] },
  stays: [{ name: 'Pioneer Adventures Camp', type: 'camp', price_range: '₹1000-2000' }],
};

const ALL_ENTRIES = [HIDDEN_SPOT, CULTURAL, DESTINATION, SEASONAL, OFFBEAT];

// ── Constructor ───────────────────────────────────────────────
describe('InsightEngine constructor', () => {
  test('uses default basePath', () => {
    const engine = new InsightEngine();
    expect(engine.basePath).toBe('/data/insights');
    expect(engine.insights).toEqual([]);
    expect(engine.loaded).toBe(false);
  });

  test('accepts custom basePath', () => {
    const engine = new InsightEngine('/custom/path');
    expect(engine.basePath).toBe('/custom/path');
  });
});

// ── scopeMatch ────────────────────────────────────────────────
describe('scopeMatch', () => {
  test('returns empty when engine not loaded', () => {
    const engine = new InsightEngine();
    expect(engine.scopeMatch('maguri')).toEqual([]);
  });

  test('matches by text against geographic_scope', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const results = engine.scopeMatch('maguri beel');
    expect(results.length).toBeGreaterThanOrEqual(1);
    expect(results[0].id).toBe('maguri-beel-hidden');
  });

  test('matches by destination param', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const results = engine.scopeMatch('', 'dawki');
    expect(results.some(r => r.id === 'shillong-dawki-route')).toBe(true);
  });

  test('combines text and destination for matching', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const results = engine.scopeMatch('travel', 'anini');
    expect(results.some(r => r.id === 'dibang-valley')).toBe(true);
  });

  test('is case-insensitive', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const results = engine.scopeMatch('MAGURI');
    expect(results.some(r => r.id === 'maguri-beel-hidden')).toBe(true);
  });

  test('sorts by hidden_score descending', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const results = engine.scopeMatch('assam');
    for (let i = 1; i < results.length; i++) {
      expect(results[i - 1].hidden_score).toBeGreaterThanOrEqual(results[i].hidden_score || 0);
    }
  });

  test('returns empty for unrecognized text', () => {
    const engine = makeEngine(ALL_ENTRIES);
    expect(engine.scopeMatch('xyznonexistent')).toEqual([]);
  });

  test('matches multiple entries when scope overlaps', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const results = engine.scopeMatch('assam trip');
    expect(results.length).toBe(2); // maguri + mising (both have 'assam')
  });
});

// ── smartExtract ──────────────────────────────────────────────
describe('smartExtract', () => {
  test('always includes common fields', () => {
    const engine = makeEngine([HIDDEN_SPOT]);
    const ext = engine.smartExtract(HIDDEN_SPOT, 'maguri');
    expect(ext.id).toBe('maguri-beel-hidden');
    expect(ext.type).toBe('hidden-spot');
    expect(ext.title).toBe('Maguri Beel');
    expect(ext.region).toBe('Upper Assam');
    expect(ext.hidden_score).toBe(8);
    expect(ext.incitetales_angle).toBe('Where the Dibru meets the Brahmaputra');
  });

  test('extracts permit info from entry.permit', () => {
    const engine = makeEngine([DESTINATION]);
    const ext = engine.smartExtract(DESTINATION, 'dibang');
    expect(ext.permit.required).toBe(true);
  });

  test('extracts permit from local_intel fallback', () => {
    const engine = makeEngine([HIDDEN_SPOT]);
    const entry = { ...HIDDEN_SPOT, permit: undefined };
    const ext = engine.smartExtract(entry, '');
    expect(ext.permit.required).toBe(false);
  });

  test('extracts insight-specific fields for non-destination type', () => {
    const engine = makeEngine([HIDDEN_SPOT]);
    const ext = engine.smartExtract(HIDDEN_SPOT, '');
    expect(ext.description).toBe('A wetland birding paradise near Tinsukia');
    expect(ext.what_most_people_miss).toBe('Sunrise boat ride through the beel');
    expect(ext.stays).toEqual(HIDDEN_SPOT.stays);
    expect(ext.local_intel).toEqual(HIDDEN_SPOT.local_intel);
  });

  test('extracts cultural fields for cultural type', () => {
    const engine = makeEngine([CULTURAL]);
    const ext = engine.smartExtract(CULTURAL, '');
    expect(ext.cultural_dos).toEqual(CULTURAL.cultural_dos);
    expect(ext.cultural_donts).toEqual(CULTURAL.cultural_donts);
    expect(ext.language_tips).toEqual(CULTURAL.language_tips);
  });

  test('extracts destination-specific fields', () => {
    const engine = makeEngine([DESTINATION]);
    const ext = engine.smartExtract(DESTINATION, 'roing');
    expect(ext.destinations).toBeDefined();
    expect(ext.destinations.length).toBeGreaterThanOrEqual(1);
    // When query matches 'roing', only that destination should be extracted
    expect(ext.destinations[0].name).toBe('Roing');
  });

  test('extracts all destinations when no specific query match', () => {
    const engine = makeEngine([DESTINATION]);
    const ext = engine.smartExtract(DESTINATION, '');
    expect(ext.destinations.length).toBe(2);
  });

  test('extracts route from_dibrugarh when query mentions dibrugarh', () => {
    const engine = makeEngine([DESTINATION]);
    const ext = engine.smartExtract(DESTINATION, 'travel from dibrugarh to roing');
    expect(ext.route.from).toBe('dibrugarh');
    expect(ext.route.total_distance_km).toBe(210);
    expect(ext.route.day_splits.length).toBe(2);
  });

  test('defaults to from_guwahati route', () => {
    const engine = makeEngine([DESTINATION]);
    const ext = engine.smartExtract(DESTINATION, 'trip to dibang');
    expect(ext.route.from).toBe('guwahati');
  });

  test('destination extract includes expected sub-fields', () => {
    const engine = makeEngine([DESTINATION]);
    const ext = engine.smartExtract(DESTINATION, '');
    const d = ext.destinations[0];
    expect(d).toHaveProperty('name');
    expect(d).toHaveProperty('tagline');
    expect(d).toHaveProperty('what_is_there');
    expect(d).toHaveProperty('stays');
    expect(d).toHaveProperty('local_food');
    expect(d).toHaveProperty('local_tips');
    expect(d).toHaveProperty('hidden_score');
    expect(d).toHaveProperty('altitude_m');
  });
});

// ── buildPromptContext ────────────────────────────────────────
describe('buildPromptContext', () => {
  test('returns isAIOnly when engine not loaded', () => {
    const engine = new InsightEngine();
    const ctx = engine.buildPromptContext('maguri');
    expect(ctx.isAIOnly).toBe(true);
    expect(ctx.hasVerifiedData).toBe(false);
    expect(ctx.contextBlock).toBe('');
  });

  test('returns isAIOnly when no matches found', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const ctx = engine.buildPromptContext('nonexistent place');
    expect(ctx.isAIOnly).toBe(true);
    expect(ctx.aiOnlyNote).toContain('not yet in the Incitetales verified database');
  });

  test('returns verified context when matches found', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const ctx = engine.buildPromptContext('maguri beel trip');
    expect(ctx.isAIOnly).toBe(false);
    expect(ctx.hasVerifiedData).toBe(true);
    expect(ctx.matchedEntries.length).toBeGreaterThan(0);
    expect(ctx.contextBlock).toContain('VERIFIED LOCAL KNOWLEDGE');
  });

  test('filters by selectedIds when provided', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const ctx = engine.buildPromptContext('assam trip', '', new Set(['mising-tribe']));
    expect(ctx.matchedEntries.length).toBe(1);
    expect(ctx.matchedEntries[0].id).toBe('mising-tribe');
  });

  test('selectedIds with no intersection returns isAIOnly', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const ctx = engine.buildPromptContext('assam', '', new Set(['nonexistent-id']));
    expect(ctx.isAIOnly).toBe(true);
  });

  test('uses destination param for matching', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const ctx = engine.buildPromptContext('plan a trip', 'meghalaya');
    expect(ctx.hasVerifiedData).toBe(true);
    expect(ctx.matchedEntries.some(m => m.state === 'Meghalaya')).toBe(true);
  });
});

// ── _buildContextString ───────────────────────────────────────
describe('_buildContextString', () => {
  test('includes header and instructions', () => {
    const engine = makeEngine([HIDDEN_SPOT]);
    const ext = engine.smartExtract(HIDDEN_SPOT, '');
    const str = engine._buildContextString([ext]);
    expect(str).toContain('VERIFIED LOCAL KNOWLEDGE FROM INCITETALES DATABASE');
    expect(str).toContain('INSTRUCTIONS:');
    expect(str).toContain('Include verified locations by name');
  });

  test('formats entry title and type', () => {
    const engine = makeEngine([HIDDEN_SPOT]);
    const ext = engine.smartExtract(HIDDEN_SPOT, '');
    const str = engine._buildContextString([ext]);
    expect(str).toContain('Maguri Beel (HIDDEN-SPOT');
    expect(str).toContain('Hidden Score: 8/10');
  });

  test('includes season info', () => {
    const engine = makeEngine([HIDDEN_SPOT]);
    const ext = engine.smartExtract(HIDDEN_SPOT, '');
    const str = engine._buildContextString([ext]);
    expect(str).toContain('Best months: november, december, january');
  });

  test('includes permit warning for required permits', () => {
    const engine = makeEngine([DESTINATION]);
    const ext = engine.smartExtract(DESTINATION, 'dibang trip');
    const str = engine._buildContextString([ext]);
    expect(str).toContain('PERMIT REQUIRED');
  });

  test('includes no-signal warning', () => {
    const engine = makeEngine([DESTINATION]);
    const ext = engine.smartExtract(DESTINATION, '');
    const str = engine._buildContextString([ext]);
    expect(str).toContain('NO mobile signal');
  });

  test('includes limited signal info', () => {
    const engine = makeEngine([HIDDEN_SPOT]);
    const ext = engine.smartExtract(HIDDEN_SPOT, '');
    const str = engine._buildContextString([ext]);
    expect(str).toContain('Limited signal');
    expect(str).toContain('BSNL most reliable');
  });

  test('includes destination details', () => {
    const engine = makeEngine([DESTINATION]);
    const ext = engine.smartExtract(DESTINATION, '');
    const str = engine._buildContextString([ext]);
    expect(str).toContain('Destination: Roing (350m)');
    expect(str).toContain('Destination: Anini (1968m)');
  });

  test('includes route day splits', () => {
    const engine = makeEngine([DESTINATION]);
    const ext = engine.smartExtract(DESTINATION, 'from dibrugarh');
    const str = engine._buildContextString([ext]);
    expect(str).toContain('ROUTE from dibrugarh');
    expect(str).toContain('Day 1: Dibrugarh');
    expect(str).toContain('Dhola-Sadiya Bridge');
  });

  test('includes cultural dos and language tips', () => {
    const engine = makeEngine([CULTURAL]);
    const ext = engine.smartExtract(CULTURAL, '');
    const str = engine._buildContextString([ext]);
    expect(str).toContain('Cultural dos:');
    expect(str).toContain('Language:');
    expect(str).toContain('hello: "Nohkkhow"');
  });

  test('includes what most people miss', () => {
    const engine = makeEngine([HIDDEN_SPOT]);
    const ext = engine.smartExtract(HIDDEN_SPOT, '');
    const str = engine._buildContextString([ext]);
    expect(str).toContain('What most people miss: Sunrise boat ride');
  });

  test('includes ATM info', () => {
    const engine = makeEngine([HIDDEN_SPOT]);
    const ext = engine.smartExtract(HIDDEN_SPOT, '');
    const str = engine._buildContextString([ext]);
    expect(str).toContain('ATM: Tinsukia');
  });

  test('includes no permit needed marker', () => {
    const engine = makeEngine([HIDDEN_SPOT]);
    const ext = engine.smartExtract(HIDDEN_SPOT, '');
    const str = engine._buildContextString([ext]);
    expect(str).toContain('No permit needed');
  });
});

// ── query ─────────────────────────────────────────────────────
describe('query', () => {
  test('returns empty when not loaded', () => {
    const engine = new InsightEngine();
    expect(engine.query()).toEqual([]);
  });

  test('returns all entries with no filters', () => {
    const engine = makeEngine(ALL_ENTRIES);
    expect(engine.query().length).toBe(ALL_ENTRIES.length);
  });

  test('filters by type', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const results = engine.query({ type: 'cultural' });
    expect(results.every(r => r.type === 'cultural')).toBe(true);
    expect(results.length).toBe(1);
  });

  test('filters by state (case-insensitive)', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const results = engine.query({ state: 'assam' });
    expect(results.every(r => r.state.toLowerCase() === 'assam')).toBe(true);
    expect(results.length).toBe(2);
  });

  test('filters by month across best/also_good/shoulder', () => {
    const engine = makeEngine(ALL_ENTRIES);
    // 'november' in best for maguri, cultural, dibang; 'november' in best for offbeat
    const results = engine.query({ month: 'november' });
    expect(results.length).toBeGreaterThanOrEqual(3);
  });

  test('filters by month in shoulder season', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const results = engine.query({ month: 'september' });
    expect(results.some(r => r.id === 'dzukou-valley-seasonal')).toBe(true);
  });

  test('filters by month in also_good', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const results = engine.query({ month: 'february' });
    expect(results.some(r => r.id === 'dibang-valley')).toBe(true);
  });

  test('filters by minHiddenScore', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const results = engine.query({ minHiddenScore: 8 });
    expect(results.every(r => (r.hidden_score || 0) >= 8)).toBe(true);
    expect(results.length).toBe(2); // maguri(8) + dibang(9)
  });

  test('filters by permitNeeded true', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const results = engine.query({ permitNeeded: true });
    expect(results.some(r => r.id === 'dibang-valley')).toBe(true);
  });

  test('filters by permitNeeded false', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const results = engine.query({ permitNeeded: false });
    expect(results.every(r => {
      const p = r.permit?.required ?? r.local_intel?.permit_needed ?? r.permit_needed;
      return p === false;
    })).toBe(true);
  });

  test('filters by hasStay', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const results = engine.query({ hasStay: true });
    expect(results.length).toBeGreaterThanOrEqual(2); // maguri camp, shillong camp, dibang (via destinations)
  });

  test('filters by stayType', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const results = engine.query({ stayType: 'camp' });
    expect(results.some(r => r.id === 'maguri-beel-hidden')).toBe(true);
    expect(results.some(r => r.id === 'shillong-dawki-route')).toBe(true);
  });

  test('filters by stayType in nested destinations', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const results = engine.query({ stayType: 'hotel' });
    expect(results.some(r => r.id === 'dibang-valley')).toBe(true);
  });

  test('filters by noSignal', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const results = engine.query({ noSignal: true });
    expect(results.some(r => r.id === 'dibang-valley')).toBe(true);
    expect(results.some(r => r.id === 'dzukou-valley-seasonal')).toBe(true);
  });

  test('filters by tags', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const results = engine.query({ tags: ['birding'] });
    expect(results.length).toBe(1);
    expect(results[0].id).toBe('maguri-beel-hidden');
  });

  test('tags filter is case-insensitive', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const results = engine.query({ tags: ['BIRDING'] });
    expect(results.length).toBe(1);
  });

  test('sorts results by hidden_score descending', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const results = engine.query();
    for (let i = 1; i < results.length; i++) {
      expect((results[i - 1].hidden_score || 0)).toBeGreaterThanOrEqual(results[i].hidden_score || 0);
    }
  });

  test('respects limit', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const results = engine.query({ limit: 2 });
    expect(results.length).toBe(2);
  });

  test('combines multiple filters', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const results = engine.query({ state: 'Assam', minHiddenScore: 8 });
    expect(results.length).toBe(1);
    expect(results[0].id).toBe('maguri-beel-hidden');
  });
});

// ── Shorthand methods ─────────────────────────────────────────
describe('shorthand methods', () => {
  test('hiddenGems returns score >= threshold', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const results = engine.hiddenGems(8);
    expect(results.every(r => r.hidden_score >= 8)).toBe(true);
  });

  test('hiddenGems defaults to minScore 7', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const results = engine.hiddenGems();
    expect(results.every(r => r.hidden_score >= 7)).toBe(true);
  });

  test('goodInMonth delegates correctly', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const results = engine.goodInMonth('december');
    expect(results.length).toBeGreaterThan(0);
  });

  test('byState returns entries for that state', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const results = engine.byState('Nagaland');
    expect(results.length).toBe(1);
    expect(results[0].id).toBe('dzukou-valley-seasonal');
  });

  test('homestays returns entries with homestay stays', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const results = engine.homestays();
    // None of our fixtures have a 'homestay' stay type
    expect(results.length).toBe(0);
  });

  test('campStays returns entries with camp stays', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const results = engine.campStays();
    expect(results.some(r => r.id === 'maguri-beel-hidden')).toBe(true);
  });

  test('digitalDetox returns no-signal entries', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const results = engine.digitalDetox();
    expect(results.length).toBe(2);
  });
});

// ── getById / getBySlug ───────────────────────────────────────
describe('getById / getBySlug', () => {
  test('getById returns the correct entry', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const result = engine.getById('maguri-beel-hidden');
    expect(result.title).toBe('Maguri Beel');
  });

  test('getById returns null for unknown id', () => {
    const engine = makeEngine(ALL_ENTRIES);
    expect(engine.getById('nonexistent')).toBeNull();
  });

  test('getBySlug returns the correct entry', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const result = engine.getBySlug('maguri-beel');
    expect(result.title).toBe('Maguri Beel');
  });

  test('getBySlug returns null for unknown slug', () => {
    const engine = makeEngine(ALL_ENTRIES);
    expect(engine.getBySlug('nonexistent')).toBeNull();
  });
});

// ── search ────────────────────────────────────────────────────
describe('search', () => {
  test('matches by title', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const results = engine.search('Maguri');
    expect(results.some(r => r.id === 'maguri-beel-hidden')).toBe(true);
  });

  test('matches by description', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const results = engine.search('wetland');
    expect(results.some(r => r.id === 'maguri-beel-hidden')).toBe(true);
  });

  test('matches by incitetales_angle', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const results = engine.search('frontier');
    expect(results.some(r => r.id === 'dibang-valley')).toBe(true);
  });

  test('matches by tags', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const results = engine.search('trekking');
    expect(results.some(r => r.id === 'dzukou-valley-seasonal')).toBe(true);
  });

  test('matches by region', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const results = engine.search('Majuli');
    expect(results.some(r => r.id === 'mising-tribe')).toBe(true);
  });

  test('matches by state', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const results = engine.search('Meghalaya');
    expect(results.some(r => r.id === 'shillong-dawki-route')).toBe(true);
  });

  test('matches by nested destination name', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const results = engine.search('Anini');
    expect(results.some(r => r.id === 'dibang-valley')).toBe(true);
  });

  test('is case-insensitive', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const results = engine.search('MAGURI');
    expect(results.some(r => r.id === 'maguri-beel-hidden')).toBe(true);
  });

  test('returns empty for no match', () => {
    const engine = makeEngine(ALL_ENTRIES);
    expect(engine.search('xyznonexistent')).toEqual([]);
  });
});

// ── stats ─────────────────────────────────────────────────────
describe('stats', () => {
  test('returns correct total', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const s = engine.stats();
    expect(s.total).toBe(ALL_ENTRIES.length);
  });

  test('groups by type correctly', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const s = engine.stats();
    expect(s.byType['hidden-spot']).toBe(1);
    expect(s.byType['cultural']).toBe(1);
    expect(s.byType['destination']).toBe(1);
    expect(s.byType['seasonal']).toBe(1);
    expect(s.byType['offbeat']).toBe(1);
  });

  test('groups by state correctly', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const s = engine.stats();
    expect(s.byState['Assam']).toBe(2);
    expect(s.byState['Arunachal Pradesh']).toBe(1);
    expect(s.byState['Nagaland']).toBe(1);
    expect(s.byState['Meghalaya']).toBe(1);
  });

  test('counts verified entries', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const s = engine.stats();
    expect(s.verified).toBe(1); // only HIDDEN_SPOT has verified: true
  });

  test('computes average hidden score', () => {
    const engine = makeEngine(ALL_ENTRIES);
    const s = engine.stats();
    const expected = ((8 + 7 + 9 + 6 + 7) / 5).toFixed(1);
    expect(s.avgHiddenScore).toBe(expected);
  });
});

// ── Edge cases ────────────────────────────────────────────────
describe('edge cases', () => {
  test('entry without geographic_scope does not match', () => {
    const entry = { ...HIDDEN_SPOT, geographic_scope: undefined };
    const engine = makeEngine([entry]);
    const results = engine.scopeMatch('maguri');
    expect(results.length).toBe(0);
  });

  test('entry with empty geographic_scope does not match', () => {
    const entry = { ...HIDDEN_SPOT, geographic_scope: [] };
    const engine = makeEngine([entry]);
    const results = engine.scopeMatch('maguri');
    expect(results.length).toBe(0);
  });

  test('smartExtract handles entry with no routes', () => {
    const noRoutes = { ...DESTINATION, routes: undefined };
    const engine = makeEngine([noRoutes]);
    const ext = engine.smartExtract(noRoutes, 'dibang');
    expect(ext.route).toBeUndefined();
  });

  test('smartExtract handles entry with no destinations', () => {
    const noDests = { ...DESTINATION, destinations: undefined };
    const engine = makeEngine([noDests]);
    const ext = engine.smartExtract(noDests, 'dibang');
    expect(ext.destinations).toEqual([]);
  });

  test('query handles entries without season', () => {
    const noSeason = { ...HIDDEN_SPOT, season: undefined };
    const engine = makeEngine([noSeason]);
    const results = engine.query({ month: 'november' });
    expect(results.length).toBe(0);
  });

  test('query handles entries without tags', () => {
    const noTags = { ...HIDDEN_SPOT, tags: undefined };
    const engine = makeEngine([noTags]);
    const results = engine.query({ tags: ['birding'] });
    expect(results.length).toBe(0);
  });

  test('search handles entries with missing optional fields', () => {
    const minimal = { id: 'minimal', type: 'test' };
    const engine = makeEngine([minimal]);
    expect(engine.search('test')).toEqual([]);
  });

  test('stats handles empty insights', () => {
    const engine = makeEngine([]);
    const s = engine.stats();
    expect(s.total).toBe(0);
    expect(isNaN(parseFloat(s.avgHiddenScore))).toBe(true);
  });
});

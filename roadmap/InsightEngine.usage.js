// ─────────────────────────────────────────────────────────────
// InsightEngine — Usage Examples
// Drop InsightEngine.js into your project and import/require it
// ─────────────────────────────────────────────────────────────

const engine = new InsightEngine('/data/insights');
await engine.load(); // loads index.json + all entry files


// ── BASIC QUERIES ─────────────────────────────────────────────

// All hidden gems (score 7+)
engine.hiddenGems(7);

// All entries good in December
engine.goodInMonth('december');

// All routes in Meghalaya
engine.query({ type: 'route', state: 'Meghalaya' });

// All entries in Arunachal with no permit required
engine.query({ state: 'Arunachal Pradesh', permitNeeded: false });

// All offbeat spots with hidden score 8+, easy physical level
engine.query({ type: 'offbeat', minHiddenScore: 8, physicalLevel: 'easy' });


// ── STAY-BASED QUERIES ────────────────────────────────────────

// All homestays
engine.homestays();

// All riverside / camp stays
engine.campStays();

// All entries with any stay option
engine.query({ hasStay: true });

// All entries with resort stays in Meghalaya
engine.query({ stayType: 'resort', state: 'Meghalaya' });


// ── MONTH + SEASON QUERIES ────────────────────────────────────

// What's good in January?
engine.goodInMonth('january');

// What's good in July that avoids the worst monsoon spots?
engine.query({ month: 'july', state: 'Nagaland' }); // Dzukou is July peak

// Best months for a specific entry
engine.bestMonths('dzukou-valley-seasonal');
// returns: { best: ['june','july','august'], avoid: ['april','may'], notes: '...' }


// ── CONNECTIVITY ─────────────────────────────────────────────

// Digital detox — no mobile signal
engine.digitalDetox();
// returns: dzukou-valley (no signal), any other no-signal entries


// ── SEARCH ───────────────────────────────────────────────────

// Full text search
engine.search('river');        // matches Brahmaputra, Umngot, Umsong
engine.search('dolphin');      // matches Maguri Beel
engine.search('camping');      // matches Brahmaputra char camp, Shnongpedeng
engine.search('permit');       // matches Dzukou, Stilwell Road, Tawang corridor


// ── SINGLE ENTRY ─────────────────────────────────────────────

engine.getById('maguri-beel-hidden');
engine.getBySlug('maguri-beel');


// ── STATS ────────────────────────────────────────────────────

engine.stats();
// returns:
// {
//   total: 8,
//   byType: { 'hidden-spot': 1, seasonal: 1, cultural: 1, offbeat: 2, experience: 1, route: 3 },
//   byState: { Assam: 3, Nagaland: 1, 'Arunachal Pradesh': 2, Meghalaya: 2 },
//   verified: 7,
//   withStory: 1,
//   avgHiddenScore: '7.0'
// }


// ── RECOMMENDATION LAYER (preview) ───────────────────────────
// This is what powers the next step — combining filters to match a user profile:

function recommendForUser(userProfile) {
  return engine.query({
    month: userProfile.travelMonth,
    state: userProfile.destination,
    physicalLevel: userProfile.fitnessLevel,
    minHiddenScore: userProfile.wantsOffbeat ? 6 : 0,
    permitNeeded: userProfile.hasPermit ? undefined : false,
    hasStay: true,
    limit: 5
  });
}

// Example:
recommendForUser({
  travelMonth: 'december',
  destination: 'Meghalaya',
  fitnessLevel: 'easy',
  wantsOffbeat: true,
  hasPermit: false
});
// returns: Shnongpedeng route, Cherrapunji route (filtered, ranked by hidden_score)

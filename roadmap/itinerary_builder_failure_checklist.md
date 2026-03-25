# Itinerary Builder Failure Checklist

Use this file as the first debugging reference when the itinerary builder fails, shows a generic alert, does not redirect to the result page, or returns the wrong destination/recommendations.

## Main Frontend Files To Check

- `itinerary-builder/index.html`
- `itinerary-result/index.html`
- `js/InsightEngine.js`

## Main Worker Endpoint

- `https://incitetales-api.incitetales.workers.dev`

## Primary Failure Points In `itinerary-builder/index.html`

### 1. Textbox interpretation flow

Look at:

- `generateFromIdea()`
- `resolveIdeaInterpretation()`
- `findVerifiedDestinationMatch()`
- `collectVerifiedSuggestions()`
- `scorePhraseMatch()`
- `normalizeIdeaResult()`

Why this matters:

- This is where free text like `Shergaon trip 5 days` is interpreted.
- Verified-first matching should win over generic dropdown presets.
- If this step breaks, the builder may suggest the wrong destination or wrong 2-3 recommendations.

Key things to verify:

- `currentInsights` is being populated from `engine.buildPromptContext(...)`
- nested destination matches like `Shergaon` inside `West Kameng` are winning
- recommendations are coming from verified local data, not generic fallback guesses

### 2. Final itinerary generation request

Look at:

- `generateItinerary()`

Why this matters:

- This is where the builder sends the request to the Cloudflare Worker.
- If the request shape is wrong, the worker may return `destination is required` or fail silently.

Current required payload shape:

```js
{
  action: 'generate',
  destination,
  days,
  duration: days,
  group,
  groupType: group,
  budget,
  interests,
  primaryInterest: interests,
  prompt: itineraryPrompt
}
```

If this payload changes, the deployed worker must stay compatible.

### 3. Worker response parsing

Look at:

- `readWorkerPayload()`
- `parseModelJsonResponse()`

Why this matters:

- Older flow expected model text containing JSON.
- New worker may return structured itinerary JSON directly.
- The parser must handle both styles.

Current compatibility requirement:

- Accept direct structured JSON object:
  - `destination`
  - `title`
  - `days`
- Also accept text-wrapped JSON if older worker/model responses still appear

### 4. Result page handoff

Look at:

- `localStorage.setItem('incitetales_itinerary', ...)`
- `window.location.href = '/itinerary-result/'`

Why this matters:

- The builder generates on `/itinerary-builder/`
- The final itinerary renders on `/itinerary-result/`
- If `localStorage` is empty or malformed, the result page shows no itinerary

## Main Result Page Checks In `itinerary-result/index.html`

Look at:

- `document.addEventListener('DOMContentLoaded', ...)`
- `localStorage.getItem('incitetales_itinerary')`
- `renderItinerary(itinerary, meta)`

Why this matters:

- If the builder succeeds but the result page still fails, the issue is often here
- malformed stored JSON
- missing `days`, `budget`, or `packing`
- stale localStorage format mismatch

## Main Brain File To Check

### `js/InsightEngine.js`

Look at:

- `load()`
- `scopeMatch()`
- `smartExtract()`
- `buildPromptContext()`
- `_buildContextString()`

Why this matters:

- This is the local verified brain
- It loads the local JSON entries from `/data/insights`
- It decides whether verified local knowledge exists
- It controls the AI-only fallback flag

If the builder is not recognizing places correctly:

- inspect `geographic_scope`
- inspect nested `destinations`
- inspect `title`, `district`, `name`

## Main Data Files To Check

Examples:

- `data/insights/index.json`
- `data/insights/destinations/arunachal-pradesh/west-kameng.json`
- `data/insights/offbeat/tawang-corridor.json`
- other matching JSON files inside `data/insights/`

Why this matters:

- If a place like `Shergaon` or an offbeat recommendation is missing or malformed here, the builder cannot resolve it properly

For each relevant JSON file, verify:

- `geographic_scope`
- `destinations`
- `key_stops`
- `what_is_there`
- `local_tips`
- `stays`
- `hidden_score`

## Worker-Side Checks

The worker is not in this repo, but if itinerary generation fails, confirm these on the deployed Cloudflare Worker:

- request body shape matches frontend payload
- worker accepts `destination`, `days`/`duration`, `group`/`groupType`, `budget`, `interests`
- worker returns structured itinerary JSON, not only plain text
- worker still injects Supabase insights into the prompt

Expected structured worker response:

```json
{
  "destination": "Tawang",
  "title": "Trip title",
  "overview": "Overview text",
  "days": [],
  "permits": null,
  "budget": [],
  "packing": [],
  "emailSent": false,
  "insightCount": 0,
  "whatsapp": null
}
```

If the worker returns either of these, there is still a contract mismatch:

```json
{"error":"destination is required"}
```

```json
{"itinerary":"long plain text itinerary"}
```

## Supabase / Share Your Story Checks

If verified recommendations are missing even though story extraction is live:

- confirm the relevant story-derived rows exist in Supabase `insights`
- confirm `verified= true`
- confirm `geographic_scope` includes the destination or nearby aliases
- confirm the worker is actually reading Supabase before calling Groq

## Fast Debug Order

1. Check browser console error on `/itinerary-builder/`
2. Check worker response shape
3. Check `generateItinerary()` payload
4. Check `parseModelJsonResponse()` compatibility
5. Check `localStorage` handoff to `/itinerary-result/`
6. Check `currentInsights` and verified destination matching
7. Check local JSON and Supabase records for missing scope/tips/stops

## Typical Symptoms And Likely Causes

`Something went wrong generating your itinerary`

- worker request mismatch
- parser mismatch
- malformed worker JSON

Wrong destination suggestion from textbox

- interpretation logic too generic
- verified match not winning
- weak `geographic_scope` or missing nested destination data

No itinerary on result page

- failed `localStorage` write
- malformed stored itinerary object
- result page render mismatch

AI-only output when verified facts should exist

- local `InsightEngine` did not match the query
- Supabase insight row missing or not verified
- worker not injecting Supabase insights

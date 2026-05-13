# En-Route Stops: Admin Options

## Why This Exists

When the itinerary generator builds a travel day (e.g. Guwahati → Cherrapunji), the AI currently fills the drive slot with generic text. The goal is to replace that with verified, on-road stops — places the traveller passes through naturally with no diversion — stored deterministically in Supabase so the AI cannot hallucinate them.

This document covers two options for populating that data: a terminal script (Option C) and an admin page served by the Cloudflare Worker (Option B).

---

## Stops Data Structure

All stops are stored in the `stops` column of the `routes` table in Supabase. The column holds a JSONB array of objects:

```json
[
  { "name": "Umiam Lake", "type": "viewpoint", "duration_min": 30 },
  { "name": "Shillong viewpoint", "type": "viewpoint", "duration_min": 20 },
  { "name": "Mawkdok Dympep Valley", "type": "nature", "duration_min": 20 }
]
```

**Allowed types:** `viewpoint`, `nature`, `culture`, `religious`, `historical`, `food`

**Rule:** Only stops that sit directly on the main road. No detours, no diversions.

**Threshold:** If total `drive_hours_max` for the route is ≤ 5 hours, stops can spill into the afternoon slot. If > 5 hours, all stops are packed into the morning drive slot only and the afternoon is locked.

---

## Option C — Terminal Script

### Overview

Two Node.js scripts that live in `incitetales-api/scripts/`. You run them from your terminal whenever you add a new route. The first script calls the AI and prints suggested stops. You review and edit the output. The second script pushes the final stops to Supabase.

### Files to Create

```
incitetales-api/
  scripts/
    suggest-stops.js    ← calls Groq, prints suggestions to terminal
    push-stops.js       ← reads edited JSON, writes to Supabase
  stops-output.json     ← temporary file you edit between the two commands
  .env                  ← local secrets (not committed)
```

### Setup (one time)

**1. Install dotenv in incitetales-api:**
```bash
cd incitetales-api
npm install dotenv
```

**2. Create `.env` in `incitetales-api/`:**
```
GROQ_API_KEY=your_groq_key
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_SERVICE_ROLE_KEY=your_service_role_key
```
> Use `SUPABASE_SERVICE_ROLE_KEY` (not anon key) — writing to Supabase requires it. Never commit this file.

**3. Add `.env` to `.gitignore`** if not already present.

### Build: `scripts/suggest-stops.js`

What this script does:
- Accepts `from_city` and `to_city` as command-line arguments
- Calls Groq (llama-3.3-70b-versatile) with a strict prompt asking for on-road stops only
- Writes the output as a JSON array to `stops-output.json`
- Prints the result to the terminal for review

```js
// scripts/suggest-stops.js
import "dotenv/config";
import fs from "fs";

const [,, from, to] = process.argv;
if (!from || !to) {
  console.error("Usage: node scripts/suggest-stops.js \"From City\" \"To City\"");
  process.exit(1);
}

const prompt = `List only the stops a traveller would naturally make while driving from ${from} to ${to} in Northeast India.

Rules:
- Only stops that sit directly on the main road. No diversions, no detours.
- Maximum 5 stops.
- Each stop must be a real, named place.
- Return ONLY a JSON array. No explanation, no markdown.

Schema:
[
  { "name": "Place name", "type": "viewpoint|nature|culture|religious|historical|food", "duration_min": 20 }
]`;

const res = await fetch("https://api.groq.com/openai/v1/chat/completions", {
  method: "POST",
  headers: {
    Authorization: `Bearer ${process.env.GROQ_API_KEY}`,
    "Content-Type": "application/json",
  },
  body: JSON.stringify({
    model: "llama-3.3-70b-versatile",
    messages: [{ role: "user", content: prompt }],
    temperature: 0.2,
    max_tokens: 500,
  }),
});

const data = await res.json();
const raw = data.choices?.[0]?.message?.content || "";
const cleaned = raw.replace(/```json|```/gi, "").trim();

let stops;
try {
  stops = JSON.parse(cleaned);
} catch {
  console.error("AI returned invalid JSON:\n", raw);
  process.exit(1);
}

fs.writeFileSync("stops-output.json", JSON.stringify(stops, null, 2));
console.log(`\nSuggested stops for ${from} → ${to}:\n`);
console.log(JSON.stringify(stops, null, 2));
console.log("\nReview stops-output.json, edit if needed, then run:");
console.log(`  node scripts/push-stops.js "${from}" "${to}"`);
```

### Build: `scripts/push-stops.js`

What this script does:
- Reads `stops-output.json`
- Finds the matching row in the `routes` table by `from_city` and `to_city`
- Updates the `stops` column with the final array

```js
// scripts/push-stops.js
import "dotenv/config";
import fs from "fs";

const [,, from, to] = process.argv;
if (!from || !to) {
  console.error("Usage: node scripts/push-stops.js \"From City\" \"To City\"");
  process.exit(1);
}

const stops = JSON.parse(fs.readFileSync("stops-output.json", "utf8"));

const res = await fetch(
  `${process.env.SUPABASE_URL}/rest/v1/routes?from_city=eq.${encodeURIComponent(from)}&to_city=eq.${encodeURIComponent(to)}`,
  {
    method: "PATCH",
    headers: {
      apikey: process.env.SUPABASE_SERVICE_ROLE_KEY,
      Authorization: `Bearer ${process.env.SUPABASE_SERVICE_ROLE_KEY}`,
      "Content-Type": "application/json",
      Prefer: "return=representation",
    },
    body: JSON.stringify({ stops }),
  }
);

if (!res.ok) {
  const err = await res.text();
  console.error("Supabase error:", err);
  process.exit(1);
}

const updated = await res.json();
if (!updated.length) {
  console.error(`No route found for ${from} → ${to}. Check exact city names in Supabase.`);
  process.exit(1);
}

console.log(`Stops saved for ${from} → ${to}:`);
console.log(JSON.stringify(stops, null, 2));
```

### Execution Flow (every new route)

```
Step 1 — Generate suggestions:
  node scripts/suggest-stops.js "Guwahati" "Cherrapunji"

Step 2 — Review terminal output.
  Open stops-output.json.
  Delete any wrong stops.
  Edit names or duration_min if needed.
  Save the file.

Step 3 — Push to Supabase:
  node scripts/push-stops.js "Guwahati" "Cherrapunji"

Done. The route row in Supabase now has verified stops.
```

### Limitations

- JSON must be edited manually in a text editor — easy to make syntax errors
- Two separate commands to remember every time
- No visibility into existing stops without opening Supabase Studio
- Only the person with the `.env` file can run this

---

## Option B — Admin Page via Cloudflare Worker

### Overview

A password-protected admin interface served at `/admin` by the existing Cloudflare Worker. You open it in a browser, see all routes, click "Suggest" to get AI-generated stops for any route, edit them visually, and click "Save." No terminal, no JSON editing, no separate commands.

### New Endpoints to Add to the Worker

| Method | Path | What it does |
|--------|------|--------------|
| `GET` | `/admin` | Serves the admin HTML page |
| `POST` | `/admin/routes` | Returns all routes from Supabase |
| `POST` | `/admin/suggest` | Calls Groq to suggest stops for a given route |
| `POST` | `/admin/save` | Writes final stops to Supabase |

All POST endpoints require the password in the request body `{ "password": "..." }`. The Worker checks it against the `ADMIN_SECRET` environment variable. If wrong, returns 401.

### New Environment Variable

Add via Wrangler:
```bash
cd incitetales-api
npx wrangler secret put ADMIN_SECRET
```
You will be prompted to type the password. This is stored securely in Cloudflare and never exposed in code.

Also add:
```bash
npx wrangler secret put SUPABASE_SERVICE_ROLE_KEY
```
Required for writing to Supabase from the Worker (the existing `SUPABASE_ANON_KEY` is read-only).

### Build: Changes to `src/index.js`

**1. Add route handler in the main `fetch()` function:**

In the `fetch(request, env)` handler, before the existing POST checks, add:

```js
const url = new URL(request.url);

if (url.pathname === "/admin" && request.method === "GET") {
  return serveAdminPage();
}

if (url.pathname === "/admin/routes" && request.method === "POST") {
  return handleAdminRoutes(request, env);
}

if (url.pathname === "/admin/suggest" && request.method === "POST") {
  return handleAdminSuggest(request, env);
}

if (url.pathname === "/admin/save" && request.method === "POST") {
  return handleAdminSave(request, env);
}
```

**2. Add `checkAdminAuth(body, env)` helper:**

```js
function checkAdminAuth(body, env) {
  return body.password === env.ADMIN_SECRET;
}
```

**3. Add `handleAdminRoutes(request, env)`:**

Fetches all rows from the `routes` table and returns them as JSON. Used by the admin page to populate the route list on load.

**4. Add `handleAdminSuggest(request, env)`:**

Accepts `{ password, from_city, to_city }`. Calls Groq with the same strict prompt as the terminal script. Returns the suggested stops array as JSON. The admin page renders these as editable cards.

**5. Add `handleAdminSave(request, env)`:**

Accepts `{ password, from_city, to_city, stops }`. PATCHes the `routes` row in Supabase using `SUPABASE_SERVICE_ROLE_KEY`. Returns success or error.

**6. Add `serveAdminPage()`:**

Returns an HTML string as the response. The page is a single self-contained HTML file embedded as a template literal in the Worker.

### Admin Page UI — What You See

**Step 1 — Password screen:**
```
┌─────────────────────────────────┐
│         INCITETALES ADMIN       │
│                                 │
│  Password: [________________]   │
│                                 │
│            [Enter]              │
└─────────────────────────────────┘
```

**Step 2 — Routes list (after login):**
```
┌─────────────────────────────────────────────────────────┐
│  Route                      Stops    Action             │
├─────────────────────────────────────────────────────────┤
│  Guwahati → Pasighat         0       [Suggest stops]    │
│  Pasighat → Mechuka          0       [Suggest stops]    │
│  Guwahati → Cherrapunji      3       [Edit stops]       │
└─────────────────────────────────────────────────────────┘
```

**Step 3 — After clicking "Suggest stops" for a route:**

The AI suggestion appears inline below the route row as editable cards:

```
Guwahati → Pasighat
─────────────────────────────────────────
  [Numaligarh Refinery viewpoint]  viewpoint  30 min  [Delete]
  [Kaziranga entry gate area]      nature     20 min  [Delete]
  [Jakhalabandha bridge]           viewpoint  15 min  [Delete]

  [+ Add stop manually]

                              [Save stops]
─────────────────────────────────────────
```

Each card allows editing the name, type (dropdown), and duration. You can delete wrong ones or add manually. Clicking Save writes directly to Supabase.

### Execution Flow (every new route)

```
Step 1 — Open browser:
  https://incitetales-api.<your-subdomain>.workers.dev/admin

Step 2 — Enter password.

Step 3 — Find the new route in the list.
  Click "Suggest stops."

Step 4 — Review the cards that appear.
  Delete anything wrong.
  Edit names or duration if needed.

Step 5 — Click "Save."
  Done. Supabase updated instantly.
```

### Deployment

No new hosting or repo. Deploy along with any Worker change:
```bash
cd incitetales-api
npx wrangler deploy
```

---

## Comparison Summary

| | Option C (Terminal) | Option B (Admin Page) |
|---|---|---|
| Build time | ~2 hours | ~1.5 days |
| Per-route effort | 2 commands + JSON editing | Click → review → save |
| Who can use it | Terminal-comfortable only | Anyone with the password |
| Error risk | High (manual JSON syntax) | Low (visual, structured) |
| Visibility into existing stops | None (must check Supabase) | Shown inline per route |
| Suitable for scale | Up to ~10 destinations | Any number of destinations |

---

## Implementation Order (when ready to build)

Regardless of which option is chosen, these steps happen first:

1. **Supabase `routes` table** — add missing segment rows (Pasighat → Mechuka, Mechuka → Pasighat, etc.)
2. **`stops` column format** — confirm column is JSONB array (not text array). Update `formatRoutesBlock()` in Worker to handle object stops, not just strings.
3. **Build chosen admin option** (C or B)
4. **Populate stops for all existing routes**
5. **Worker `buildTravelSkeleton()`** — skeleton builder that uses routes + stops to lock travel days and assign en-route stops to the correct time slot
6. **Frontend origin field** — free-text "Starting from" in `itinerary-builder/index.html`

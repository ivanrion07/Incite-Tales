# En-Route Stops: Full Build Guide

## Why This Exists

When the itinerary generator builds a travel day (e.g. Pasighat → Mechuka = 7.5–8 hrs), the AI currently fills the afternoon slot with sightseeing — impossible since the traveller is still in a vehicle. The root cause is that route data is injected as soft text into the system prompt, which the AI can ignore or misinterpret.

The fix has two parts:
1. **Admin page** — a browser tool for populating verified en-route stops into Supabase without touching code
2. **Skeleton builder** — the Worker pre-computes a fixed day-type map (travel vs activity, locked vs open afternoon slots) and injects it as a hard constraint. The AI fills narrative only into open slots.

---

## Stops Data Structure

All stops live in the `stops` column of the `routes` table in Supabase. The column is JSONB and already exists. Format:

```json
[
  { "name": "Umiam Lake", "type": "viewpoint", "duration_min": 30 },
  { "name": "Shillong viewpoint", "type": "viewpoint", "duration_min": 20 },
  { "name": "Mawkdok Dympep Valley", "type": "nature", "duration_min": 20 }
]
```

**Allowed types:** `viewpoint`, `nature`, `culture`, `religious`, `historical`, `food`

**Rule:** Only stops that sit directly on the main road. No detours, no diversions.

**Afternoon threshold:**
- `drive_hours_max ≤ 5` → stops can spill into afternoon slot
- `drive_hours_max > 5` → all stops in morning only, afternoon is LOCKED

---

## Implementation Order

1. Add missing Supabase route rows
2. Fix `formatRoutesBlock()` in Worker (stops rendering)
3. Build Admin Page (Option B) in Worker
4. Populate stops for all existing routes via admin page
5. Add `buildTravelSkeleton()` to Worker
6. Modify `buildSystemPrompt()` and the generate handler to use the skeleton
7. Add route chaining to `fetchAllSupabaseSources()`
8. Add origin field to `itinerary-builder/index.html`
9. Read origin and remove hardcoded road times in `itinerary-result/index.html`
10. Deploy

---

## Step 1 — Supabase: Add Missing Route Rows

**Where:** Supabase Studio → Table Editor → `routes` table

**What to add:** Every segment that forms a day-boundary leg needs its own row. Without these rows, the Worker cannot chain a journey and cannot lock travel days.

Minimum rows needed for current destinations:

| from_city | to_city | distance_km | drive_hours_min | drive_hours_max | travel_days | no_flights | verified |
|---|---|---|---|---|---|---|---|
| Guwahati | Pasighat | 380 | 9 | 10 | 2 | true | true |
| Pasighat | Mechuka | 250 | 7 | 8 | 1 | true | true |
| Mechuka | Pasighat | 250 | 7 | 8 | 1 | true | true |
| Pasighat | Guwahati | 380 | 9 | 10 | 2 | true | true |

> For multi-day inbound legs like Guwahati → Pasighat (2 travel days via overnight at Pasighat), split them: `Guwahati → Pasighat` as Day 1 (drive_hours: 9–10, travel_days: 1), and `Pasighat → Mechuka` as Day 2. The skeleton builder will chain them.

**Check existing rows:** Run this in Supabase SQL Editor to see what's already there:
```sql
SELECT from_city, to_city, drive_hours_min, drive_hours_max, travel_days, verified
FROM routes
ORDER BY from_city;
```

Add rows for any missing segments. Leave `stops` as `null` for now — the admin page (Step 3) will populate them.

---

## Step 2 — Fix `formatRoutesBlock()` in Worker

**File:** `incitetales-api/src/index.js`
**Function:** `formatRoutesBlock()` — around line 427

**Problem:** The current code maps stops as template strings, which renders objects as `[object Object]`:
```js
const stops = Array.isArray(row.stops) ? row.stops : [];
if (stops.length) lines.push(`Key stops:\n${stops.map((s) => `  - ${s}`).join("\n")}`);
```

**Fix:** Replace those two lines with object-aware rendering:

```js
const stops = Array.isArray(row.stops) ? row.stops : [];
if (stops.length) {
  const stopLines = stops.map((s) => {
    if (typeof s === "string") return `  - ${s}`;
    const parts = [s.name];
    if (s.type) parts.push(s.type);
    if (s.duration_min) parts.push(`${s.duration_min} min`);
    return `  - ${parts.join(", ")}`;
  });
  lines.push(`Key stops:\n${stopLines.join("\n")}`);
}
```

**After this fix,** a route with object stops will render in the system prompt as:
```
Key stops:
  - Umiam Lake, viewpoint, 30 min
  - Shillong viewpoint, viewpoint, 20 min
  - Mawkdok Dympep Valley, nature, 20 min
```

---

## Step 3 — Build Admin Page (Option B)

**File:** `incitetales-api/src/index.js`

This is the largest change. It adds 4 new endpoints and a self-contained admin HTML page to the existing Worker. No new hosting needed.

### 3a — Update CORS_HEADERS

**Find** (around line 33):
```js
const CORS_HEADERS = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Methods": "POST, OPTIONS",
  "Access-Control-Allow-Headers": "Content-Type",
};
```

**Replace with:**
```js
const CORS_HEADERS = {
  "Access-Control-Allow-Origin": "*",
  "Access-Control-Allow-Methods": "GET, POST, OPTIONS",
  "Access-Control-Allow-Headers": "Content-Type",
};
```

### 3b — Add auth helper and admin handlers

Add these four functions anywhere before the `export default` block (e.g. after `sendEmail()`):

```js
function checkAdminAuth(body, env) {
  return body?.password === env.ADMIN_SECRET;
}

async function handleAdminRoutes(request, env) {
  let body;
  try { body = await request.json(); } catch { body = {}; }
  if (!checkAdminAuth(body, env)) {
    return new Response(JSON.stringify({ error: "Unauthorized" }), {
      status: 401,
      headers: { ...CORS_HEADERS, "Content-Type": "application/json" },
    });
  }
  const res = await fetch(
    `${env.SUPABASE_URL}/rest/v1/routes?select=id,from_city,to_city,drive_hours_min,drive_hours_max,stops,verified&order=from_city.asc`,
    {
      headers: {
        apikey: env.SUPABASE_ANON_KEY,
        Authorization: `Bearer ${env.SUPABASE_ANON_KEY}`,
      },
    }
  );
  const rows = res.ok ? await res.json() : [];
  return new Response(JSON.stringify(rows), {
    headers: { ...CORS_HEADERS, "Content-Type": "application/json" },
  });
}

async function handleAdminSuggest(request, env) {
  let body;
  try { body = await request.json(); } catch { body = {}; }
  if (!checkAdminAuth(body, env)) {
    return new Response(JSON.stringify({ error: "Unauthorized" }), {
      status: 401,
      headers: { ...CORS_HEADERS, "Content-Type": "application/json" },
    });
  }
  const { from_city, to_city } = body;
  if (!from_city || !to_city) {
    return new Response(JSON.stringify({ error: "from_city and to_city required" }), {
      status: 400,
      headers: { ...CORS_HEADERS, "Content-Type": "application/json" },
    });
  }

  const prompt = `List only the stops a traveller would naturally make while driving from ${from_city} to ${to_city} in Northeast India.

Rules:
- Only stops that sit directly on the main road. No diversions, no detours.
- Maximum 5 stops.
- Each stop must be a real, named place.
- Return ONLY a JSON array. No explanation, no markdown fences.

Schema:
[{ "name": "Place name", "type": "viewpoint|nature|culture|religious|historical|food", "duration_min": 20 }]`;

  const groqRes = await fetch("https://api.groq.com/openai/v1/chat/completions", {
    method: "POST",
    headers: {
      Authorization: `Bearer ${env.GROQ_API_KEY}`,
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      model: "llama-3.3-70b-versatile",
      messages: [{ role: "user", content: prompt }],
      temperature: 0.2,
      max_tokens: 500,
    }),
  });

  const groqData = await groqRes.json();
  const raw = groqData.choices?.[0]?.message?.content || "";
  const cleaned = raw.replace(/```json|```/gi, "").trim();

  let stops;
  try {
    stops = JSON.parse(cleaned);
  } catch {
    return new Response(JSON.stringify({ error: "AI returned invalid JSON", raw }), {
      status: 500,
      headers: { ...CORS_HEADERS, "Content-Type": "application/json" },
    });
  }

  return new Response(JSON.stringify({ stops }), {
    headers: { ...CORS_HEADERS, "Content-Type": "application/json" },
  });
}

async function handleAdminSave(request, env) {
  let body;
  try { body = await request.json(); } catch { body = {}; }
  if (!checkAdminAuth(body, env)) {
    return new Response(JSON.stringify({ error: "Unauthorized" }), {
      status: 401,
      headers: { ...CORS_HEADERS, "Content-Type": "application/json" },
    });
  }
  const { from_city, to_city, stops } = body;
  if (!from_city || !to_city || !Array.isArray(stops)) {
    return new Response(JSON.stringify({ error: "from_city, to_city, stops[] required" }), {
      status: 400,
      headers: { ...CORS_HEADERS, "Content-Type": "application/json" },
    });
  }

  const res = await fetch(
    `${env.SUPABASE_URL}/rest/v1/routes?from_city=eq.${encodeURIComponent(from_city)}&to_city=eq.${encodeURIComponent(to_city)}`,
    {
      method: "PATCH",
      headers: {
        apikey: env.SUPABASE_SERVICE_ROLE_KEY,
        Authorization: `Bearer ${env.SUPABASE_SERVICE_ROLE_KEY}`,
        "Content-Type": "application/json",
        Prefer: "return=representation",
      },
      body: JSON.stringify({ stops }),
    }
  );

  if (!res.ok) {
    const err = await res.text();
    return new Response(JSON.stringify({ error: "Supabase write failed", detail: err }), {
      status: 500,
      headers: { ...CORS_HEADERS, "Content-Type": "application/json" },
    });
  }

  const updated = await res.json();
  if (!updated.length) {
    return new Response(JSON.stringify({ error: `No route found for ${from_city} → ${to_city}` }), {
      status: 404,
      headers: { ...CORS_HEADERS, "Content-Type": "application/json" },
    });
  }

  return new Response(JSON.stringify({ ok: true, saved: stops.length }), {
    headers: { ...CORS_HEADERS, "Content-Type": "application/json" },
  });
}

function serveAdminPage() {
  const html = `<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Incitetales Admin</title>
<style>
*{margin:0;padding:0;box-sizing:border-box;}
body{font-family:system-ui,sans-serif;background:#f5f5f5;color:#1a1a1a;font-size:14px;}
.screen{display:none;} .screen.active{display:block;}
/* Login */
#login{max-width:360px;margin:120px auto;background:#fff;border:1px solid #ddd;padding:40px;}
#login h1{font-size:18px;font-weight:600;margin-bottom:24px;letter-spacing:0.05em;}
#login input{width:100%;border:1px solid #ccc;padding:10px 12px;font-size:14px;outline:none;margin-bottom:12px;}
#login input:focus{border-color:#2a5c48;}
#login button{width:100%;background:#1a1a1a;color:#fff;border:none;padding:11px;font-size:13px;cursor:pointer;letter-spacing:0.1em;}
#login button:hover{background:#2a5c48;}
.error{color:#c00;font-size:12px;margin-top:8px;}
/* Main */
#main{max-width:800px;margin:0 auto;padding:40px 24px;}
#main h1{font-size:20px;font-weight:600;margin-bottom:4px;}
#main .sub{font-size:12px;color:#888;margin-bottom:28px;}
table{width:100%;border-collapse:collapse;background:#fff;border:1px solid #ddd;}
thead tr{background:#f0f0f0;}
th,td{padding:10px 14px;text-align:left;border-bottom:1px solid #eee;font-size:13px;}
th{font-size:11px;letter-spacing:0.08em;text-transform:uppercase;color:#555;}
.pill{display:inline-block;font-size:10px;padding:2px 8px;border-radius:2px;background:#eaf5f0;color:#2a5c48;border:1px solid #b0d8c8;}
.pill.empty{background:#fdf0f0;color:#c00;border-color:#f0c0c0;}
.btn{font-size:11px;letter-spacing:0.08em;text-transform:uppercase;border:1px solid #ccc;background:#fff;padding:5px 12px;cursor:pointer;transition:all .15s;}
.btn:hover{background:#1a1a1a;color:#fff;border-color:#1a1a1a;}
.btn.primary{background:#2a5c48;color:#fff;border-color:#2a5c48;}
.btn.primary:hover{background:#1e4434;}
.btn.danger{border-color:#c00;color:#c00;}
.btn.danger:hover{background:#c00;color:#fff;}
/* Stop editor */
.editor{display:none;padding:16px 14px;background:#fafafa;border:1px solid #ddd;border-top:none;}
.editor.open{display:block;}
.stop-card{display:grid;grid-template-columns:1fr 140px 80px 36px;gap:8px;align-items:center;margin-bottom:8px;}
.stop-card input,.stop-card select{border:1px solid #ccc;padding:7px 10px;font-size:13px;width:100%;outline:none;}
.stop-card input:focus,.stop-card select:focus{border-color:#2a5c48;}
.editor-actions{display:flex;gap:8px;margin-top:12px;}
.add-btn{background:none;border:1px dashed #aaa;padding:7px 14px;width:100%;cursor:pointer;font-size:12px;color:#666;margin-bottom:12px;}
.add-btn:hover{border-color:#2a5c48;color:#2a5c48;}
.status{font-size:12px;margin-top:6px;color:#2a5c48;}
.loading{color:#888;font-size:12px;font-style:italic;}
</style>
</head>
<body>

<div id="login" class="screen active">
  <h1>INCITETALES ADMIN</h1>
  <input type="password" id="pw-input" placeholder="Password" autocomplete="current-password">
  <button onclick="doLogin()">Enter</button>
  <div class="error" id="login-error"></div>
</div>

<div id="main" class="screen">
  <h1>En-Route Stops</h1>
  <div class="sub">Click "Suggest" to get AI-generated stops. Review, edit, then save to Supabase.</div>
  <table>
    <thead><tr><th>Route</th><th>Drive time</th><th>Stops</th><th>Action</th></tr></thead>
    <tbody id="routes-body"></tbody>
  </table>
</div>

<script>
let password = '';
const BASE = window.location.origin;

async function doLogin() {
  const pw = document.getElementById('pw-input').value;
  const err = document.getElementById('login-error');
  err.textContent = '';
  const res = await fetch(BASE + '/admin/routes', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ password: pw })
  });
  if (!res.ok) { err.textContent = 'Wrong password.'; return; }
  password = pw;
  const routes = await res.json();
  document.getElementById('login').classList.remove('active');
  document.getElementById('main').classList.add('active');
  renderRoutes(routes);
}

document.getElementById('pw-input').addEventListener('keydown', e => { if (e.key === 'Enter') doLogin(); });

function renderRoutes(routes) {
  const tbody = document.getElementById('routes-body');
  tbody.innerHTML = '';
  routes.forEach(route => {
    const stopCount = Array.isArray(route.stops) ? route.stops.length : 0;
    const row = document.createElement('tr');
    row.id = 'row-' + route.id;
    row.innerHTML = \`
      <td><strong>\${route.from_city} → \${route.to_city}</strong></td>
      <td>\${route.drive_hours_min ?? '?'}–\${route.drive_hours_max ?? '?'} hrs</td>
      <td><span class="pill \${stopCount === 0 ? 'empty' : ''}">\${stopCount} stop\${stopCount !== 1 ? 's' : ''}</span></td>
      <td><button class="btn" onclick="openEditor('\${route.id}', '\${route.from_city}', '\${route.to_city}', \${route.drive_hours_max ?? 0})">\${stopCount ? 'Edit' : 'Suggest'} stops</button></td>
    \`;
    const editorRow = document.createElement('tr');
    editorRow.id = 'editor-row-' + route.id;
    editorRow.innerHTML = \`<td colspan="4" style="padding:0;"><div class="editor" id="editor-\${route.id}"></div></td>\`;
    tbody.appendChild(row);
    tbody.appendChild(editorRow);

    if (stopCount > 0) {
      renderEditor(route.id, route.from_city, route.to_city, route.drive_hours_max ?? 0, route.stops, false);
    }
  });
}

function openEditor(id, from, to, maxHours) {
  const editorEl = document.getElementById('editor-' + id);
  if (editorEl.classList.contains('open')) { editorEl.classList.remove('open'); return; }
  document.querySelectorAll('.editor').forEach(e => e.classList.remove('open'));
  editorEl.innerHTML = '<div class="loading" style="padding:12px;">Getting AI suggestions...</div>';
  editorEl.classList.add('open');
  fetch(BASE + '/admin/suggest', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ password, from_city: from, to_city: to })
  }).then(r => r.json()).then(data => {
    if (data.error) { editorEl.innerHTML = '<div style="padding:12px;color:#c00;">Error: ' + data.error + '</div>'; return; }
    renderEditor(id, from, to, maxHours, data.stops, true);
  });
}

function renderEditor(id, from, to, maxHours, stops, open) {
  const editorEl = document.getElementById('editor-' + id);
  const threshold = maxHours > 5 ? 'Afternoon LOCKED (drive > 5 hrs). All stops go in morning slot.' : 'Stops can spill into afternoon (drive ≤ 5 hrs).';
  const types = ['viewpoint','nature','culture','religious','historical','food'];
  let html = \`<div style="padding:14px;">
    <div style="font-size:11px;color:#888;margin-bottom:12px;">
      <strong>\${from} → \${to}</strong> &nbsp;·&nbsp; \${threshold}
    </div>
    <div id="stop-list-\${id}">\`;
  stops.forEach((s, i) => {
    html += stopCardHtml(id, i, s, types);
  });
  html += \`</div>
    <button class="add-btn" onclick="addStop('\${id}')">+ Add stop manually</button>
    <div class="editor-actions">
      <button class="btn primary" onclick="saveStops('\${id}', '\${from}', '\${to}')">Save stops</button>
      <button class="btn" onclick="document.getElementById('editor-\${id}').classList.remove('open')">Cancel</button>
    </div>
    <div class="status" id="status-\${id}"></div>
  </div>\`;
  editorEl.innerHTML = html;
  if (open) editorEl.classList.add('open');
}

function stopCardHtml(routeId, idx, s, types) {
  const typeOptions = types.map(t => \`<option value="\${t}" \${s.type === t ? 'selected' : ''}>\${t}</option>\`).join('');
  return \`<div class="stop-card" id="stop-\${routeId}-\${idx}">
    <input type="text" value="\${s.name || ''}" placeholder="Stop name">
    <select>\${typeOptions}</select>
    <input type="number" value="\${s.duration_min || 20}" min="5" max="120" placeholder="min">
    <button class="btn danger" onclick="removeStop('\${routeId}', \${idx})" title="Remove">✕</button>
  </div>\`;
}

function addStop(routeId) {
  const list = document.getElementById('stop-list-' + routeId);
  const idx = list.children.length;
  const types = ['viewpoint','nature','culture','religious','historical','food'];
  const div = document.createElement('div');
  div.innerHTML = stopCardHtml(routeId, idx, { name: '', type: 'viewpoint', duration_min: 20 }, types);
  list.appendChild(div.firstElementChild);
}

function removeStop(routeId, idx) {
  const el = document.getElementById('stop-' + routeId + '-' + idx);
  if (el) el.remove();
}

function collectStops(routeId) {
  const list = document.getElementById('stop-list-' + routeId);
  return Array.from(list.querySelectorAll('.stop-card')).map(card => {
    const inputs = card.querySelectorAll('input, select');
    return {
      name: inputs[0].value.trim(),
      type: inputs[1].value,
      duration_min: parseInt(inputs[2].value, 10) || 20,
    };
  }).filter(s => s.name);
}

async function saveStops(routeId, from, to) {
  const stops = collectStops(routeId);
  const status = document.getElementById('status-' + routeId);
  status.textContent = 'Saving...';
  status.style.color = '#888';
  const res = await fetch(BASE + '/admin/save', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ password, from_city: from, to_city: to, stops })
  });
  const data = await res.json();
  if (data.ok) {
    status.textContent = '✓ Saved ' + data.saved + ' stop' + (data.saved !== 1 ? 's' : '') + ' to Supabase.';
    status.style.color = '#2a5c48';
    document.getElementById('editor-' + routeId).classList.remove('open');
    const pill = document.querySelector('#row-' + routeId + ' .pill');
    if (pill) { pill.textContent = data.saved + ' stop' + (data.saved !== 1 ? 's' : ''); pill.classList.remove('empty'); }
  } else {
    status.textContent = 'Error: ' + (data.error || 'unknown');
    status.style.color = '#c00';
  }
}
</script>
</body>
</html>`;
  return new Response(html, {
    headers: { "Content-Type": "text/html;charset=UTF-8" },
  });
}
```

### 3c — Add route dispatching to the main fetch handler

**Find** the main `fetch(request, env)` handler. It currently starts with:

```js
export default {
  async fetch(request, env) {
    if (request.method === "OPTIONS") {
      return new Response(null, { headers: CORS_HEADERS });
    }

    if (request.method !== "POST") {
      return new Response("Method not allowed", { status: 405 });
    }
```

**Replace the opening of that handler with:**

```js
export default {
  async fetch(request, env) {
    if (request.method === "OPTIONS") {
      return new Response(null, { headers: CORS_HEADERS });
    }

    const url = new URL(request.url);

    // Admin routes
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

    if (request.method !== "POST") {
      return new Response("Method not allowed", { status: 405 });
    }
```

### 3d — Set environment variables via Wrangler

Run these two commands. You'll be prompted to type the values. They're stored securely in Cloudflare — never in code.

```bash
cd /Users/vantagecircle/chaoindranuj/git-repo/incitetales-api

npx wrangler secret put ADMIN_SECRET
# Type the admin password when prompted

npx wrangler secret put SUPABASE_SERVICE_ROLE_KEY
# Paste the service role key from Supabase → Project Settings → API
```

### 3e — Deploy and verify

```bash
cd /Users/vantagecircle/chaoindranuj/git-repo/incitetales-api
npx wrangler deploy
```

Then open `https://incitetales-api.incitetales.workers.dev/admin` in a browser. You should see the password screen.

---

## Step 4 — Populate Stops via Admin Page

With the admin page live, work through every route in the table:

1. Open `/admin` and log in
2. Click "Suggest stops" for each route
3. Review the AI-suggested cards — delete anything not actually on the road
4. Edit names or duration if needed
5. Click "Save"

Do this for all routes before moving to Step 5. The skeleton builder depends on `stops` being populated.

---

## Step 5 — Add `buildTravelSkeleton()` to Worker

**File:** `incitetales-api/src/index.js`

Add this function before the `export default` block. It chains route rows into an inbound + outbound journey and assigns each day a type, locked state, and en-route stops.

```js
function buildTravelSkeleton(routes, origin, destination, duration) {
  const days = parseInt(duration, 10);
  if (!origin || !destination || !days || !routes.length) return null;

  // Chain inbound legs: origin → ... → destination
  function chainLegs(from, to) {
    const legs = [];
    let current = from.toLowerCase().trim();
    const target = to.toLowerCase().trim();
    const used = new Set();

    while (current !== target) {
      const leg = routes.find((r) => {
        const fc = (r.from_city || "").toLowerCase().trim();
        const tc = (r.to_city || "").toLowerCase().trim();
        return fc === current && !used.has(fc + "|" + tc);
      });
      if (!leg) break;
      used.add(leg.from_city.toLowerCase() + "|" + leg.to_city.toLowerCase());
      legs.push(leg);
      current = (leg.to_city || "").toLowerCase().trim();
    }
    return current === target ? legs : null;
  }

  const inboundLegs = chainLegs(origin, destination);
  if (!inboundLegs) return null;

  // Mirror for outbound
  const outboundLegs = inboundLegs.map((leg) => {
    const reverse = routes.find(
      (r) =>
        (r.from_city || "").toLowerCase().trim() === (leg.to_city || "").toLowerCase().trim() &&
        (r.to_city || "").toLowerCase().trim() === (leg.from_city || "").toLowerCase().trim()
    );
    return reverse || {
      from_city: leg.to_city,
      to_city: leg.from_city,
      drive_hours_min: leg.drive_hours_min,
      drive_hours_max: leg.drive_hours_max,
      stops: leg.stops,
    };
  }).reverse();

  const totalTravelDays = inboundLegs.length + outboundLegs.length;
  const activityDays = days - totalTravelDays;

  if (activityDays < 1) return null;

  const skeleton = {};
  let dayNum = 1;

  // Inbound travel days
  for (const leg of inboundLegs) {
    const maxHrs = leg.drive_hours_max || 0;
    const afternoonLocked = maxHrs > 5;
    const stops = Array.isArray(leg.stops) ? leg.stops : [];
    skeleton[dayNum] = {
      type: "travel",
      route: `${leg.from_city} → ${leg.to_city}`,
      driveHoursMin: leg.drive_hours_min,
      driveHoursMax: leg.drive_hours_max,
      stay: leg.to_city,
      afternoonLocked,
      stops,
    };
    dayNum++;
  }

  // Activity days
  for (let i = 0; i < activityDays; i++) {
    skeleton[dayNum] = { type: "activity", stay: destination };
    dayNum++;
  }

  // Outbound travel days
  for (const leg of outboundLegs) {
    const maxHrs = leg.drive_hours_max || 0;
    const afternoonLocked = maxHrs > 5;
    const stops = Array.isArray(leg.stops) ? leg.stops : [];
    skeleton[dayNum] = {
      type: "travel",
      route: `${leg.from_city} → ${leg.to_city}`,
      driveHoursMin: leg.drive_hours_min,
      driveHoursMax: leg.drive_hours_max,
      stay: leg.to_city,
      afternoonLocked,
      stops,
    };
    dayNum++;
  }

  return skeleton;
}
```

---

## Step 6 — Inject Skeleton into `buildSystemPrompt()`

**File:** `incitetales-api/src/index.js`

### 6a — Add skeleton formatter

Add this helper function near `buildTravelSkeleton()`:

```js
function formatSkeletonBlock(skeleton) {
  if (!skeleton) return "";

  const lines = [
    "## TRAVEL SKELETON — FIXED, DO NOT ALTER",
    "The day types, routes, stays, and LOCKED slots below are pre-computed from verified road data.",
    "Fill narrative ONLY into open slots. Do not change day type, route, stay location, or any LOCKED field.\n",
  ];

  for (const [day, slot] of Object.entries(skeleton)) {
    if (slot.type === "travel") {
      const driveLabel =
        slot.driveHoursMin && slot.driveHoursMax
          ? `${slot.driveHoursMin}–${slot.driveHoursMax} hrs`
          : "full day drive";

      const stopLines = slot.stops.length
        ? slot.stops
            .map((s) => {
              if (typeof s === "string") return `    · ${s}`;
              const parts = [s.name];
              if (s.type) parts.push(s.type);
              if (s.duration_min) parts.push(`${s.duration_min} min`);
              return `    · ${parts.join(", ")}`;
            })
            .join("\n")
        : "    · (no verified stops — keep drive narrative only)";

      lines.push(`Day ${day}: TRAVEL — ${slot.route} (${driveLabel})`);
      lines.push(`  Morning: En-route drive with stops:\n${stopLines}`);

      if (slot.afternoonLocked) {
        lines.push(`  Afternoon: LOCKED — still driving, no sightseeing permitted`);
      } else {
        lines.push(`  Afternoon: Available for activities on arrival at ${slot.stay}`);
      }

      lines.push(`  Stay: ${slot.stay}`);
    } else {
      lines.push(`Day ${day}: ACTIVITY — full day at ${slot.stay}`);
      lines.push(`  Morning/Afternoon/Evening: Fill with verified local activities`);
      lines.push(`  Stay: ${slot.stay}`);
    }
    lines.push("");
  }

  return lines.join("\n");
}
```

### 6b — Update `buildSystemPrompt()` signature

**Find** (around line 462):
```js
function buildSystemPrompt(insightsBlock, routesBlock) {
```

**Replace with:**
```js
function buildSystemPrompt(insightsBlock, routesBlock, skeletonBlock) {
```

**Find** at the bottom of `buildSystemPrompt()`:
```js
  const sections = [basePrompt];
  if (routesBlock) sections.push(routesBlock);
  if (insightsBlock) sections.push(insightsBlock);
  return sections.join("\n\n");
```

**Replace with:**
```js
  const sections = [basePrompt];
  if (skeletonBlock) sections.push(skeletonBlock);
  if (routesBlock) sections.push(routesBlock);
  if (insightsBlock) sections.push(insightsBlock);
  return sections.join("\n\n");
```

### 6c — Update the generate handler to accept and use origin

**Find** in the `generate` action block (around line 644):
```js
    const destination = body.destination || body.customDestination || "";
    const duration = body.duration || body.days || "5";
    const groupType = body.groupType || body.group || "solo traveller";
    const interests = body.interests || body.primaryInterest || "culture, nature, local food";
    const budget = body.budget || "mid-range";
    const email = body.email || "";
    const name = body.name || "";
    const startDate = body.startDate || "";
```

**Replace with:**
```js
    const destination = body.destination || body.customDestination || "";
    const origin = body.origin || "";
    const duration = body.duration || body.days || "5";
    const groupType = body.groupType || body.group || "solo traveller";
    const interests = body.interests || body.primaryInterest || "culture, nature, local food";
    const budget = body.budget || "mid-range";
    const email = body.email || "";
    const name = body.name || "";
    const startDate = body.startDate || "";
```

**Find** (around line 671):
```js
    const insightsBlock = formatInsightsBlock(mergedInsights);
    const routesBlock = formatRoutesBlock(matchedRoutes);
    const systemPrompt = buildSystemPrompt(insightsBlock, routesBlock);
```

**Replace with:**
```js
    const insightsBlock = formatInsightsBlock(mergedInsights);
    const routesBlock = formatRoutesBlock(matchedRoutes);
    const skeleton = origin ? buildTravelSkeleton(matchedRoutes, origin, destination, duration) : null;
    const skeletonBlock = formatSkeletonBlock(skeleton);
    const systemPrompt = buildSystemPrompt(insightsBlock, routesBlock, skeletonBlock);
```

---

## Step 7 — Route Chaining in `fetchAllSupabaseSources()`

**File:** `incitetales-api/src/index.js`
**Function:** `fetchAllSupabaseSources()` — around line 298

Currently routes are filtered by `to_city`, `from_city`, or tags matching the destination. This misses intermediate legs (e.g. when going Guwahati → Mechuka, the leg `Guwahati → Pasighat` won't match "Mechuka" as destination).

**Find** the route filter at the bottom of `fetchAllSupabaseSources()` (around line 375):
```js
  const routes = routeRows.filter((row) => {
    const scope = [
      row.to_city,
      row.from_city,
      ...(Array.isArray(row.tags) ? row.tags : []),
    ];
    return destinationMatches(scope, destination);
  });
```

**Replace with:**
```js
  // Primary match: rows where destination is the to_city or from_city
  const directRoutes = routeRows.filter((row) => {
    const scope = [
      row.to_city,
      row.from_city,
      ...(Array.isArray(row.tags) ? row.tags : []),
    ];
    return destinationMatches(scope, destination);
  });

  // Pull in intermediate legs so skeleton builder can chain full journeys.
  // Walk backward from each matched from_city until no predecessor is found.
  const allRouteIds = new Set(directRoutes.map((r) => r.id));
  const chainedRoutes = [...directRoutes];

  let frontier = directRoutes.map((r) => (r.from_city || "").toLowerCase().trim());
  let safety = 0;
  while (frontier.length && safety++ < 10) {
    const nextFrontier = [];
    for (const city of frontier) {
      const predecessors = routeRows.filter(
        (r) => !allRouteIds.has(r.id) && (r.to_city || "").toLowerCase().trim() === city
      );
      predecessors.forEach((r) => {
        allRouteIds.add(r.id);
        chainedRoutes.push(r);
        nextFrontier.push((r.from_city || "").toLowerCase().trim());
      });
    }
    frontier = nextFrontier;
  }

  const routes = chainedRoutes;
```

---

## Step 8 — Add Origin Field to `itinerary-builder/index.html`

**File:** `incitetales/itinerary-builder/index.html`

### 8a — Add the form field

**Find** the "Where do you want to go?" form group (around line 1096):
```html
      <div class="form-group">
        <label class="form-label">Where do you want to go?</label>
        <select class="form-select" id="destination">
```

**Insert a new form group directly above it:**
```html
      <div class="form-group">
        <label class="form-label">Starting from</label>
        <input type="text" class="form-input" id="origin" placeholder="e.g. Guwahati">
      </div>
```

### 8b — Pass origin in the URL params

**Find** `generateItinerary()` function (around line 1617). Near the bottom where it builds the redirect URL:

```js
  const params = new URLSearchParams({ destination, days, group, budget, interests });
  window.location.href = '../itinerary-result/?' + params.toString();
```

**Replace with:**
```js
  const origin = document.getElementById('origin').value.trim();
  const params = new URLSearchParams({ destination, days, group, budget, interests });
  if (origin) params.set('origin', origin);
  window.location.href = '../itinerary-result/?' + params.toString();
```

---

## Step 9 — Read Origin and Clean Up in `itinerary-result/index.html`

**File:** `incitetales/itinerary-result/index.html`

### 9a — Read origin from URL params

**Find** the `DOMContentLoaded` handler (around line 776):
```js
  const params = new URLSearchParams(window.location.search);
  const destination = params.get('destination') || '';
  const days = params.get('days') || '7';
  const group = params.get('group') || 'friend group of 3-5 people';
  const budget = params.get('budget') || 'mid-range (₹10,000–₹20,000)';
  const interests = params.get('interests') || 'a mix of everything';
```

**Replace with:**
```js
  const params = new URLSearchParams(window.location.search);
  const destination = params.get('destination') || '';
  const days = params.get('days') || '7';
  const group = params.get('group') || 'friend group of 3-5 people';
  const budget = params.get('budget') || 'mid-range (₹10,000–₹20,000)';
  const interests = params.get('interests') || 'a mix of everything';
  const origin = params.get('origin') || '';
```

### 9b — Pass origin in the Worker request body

**Find** the fetch call to the Worker (around line 792):
```js
      body: JSON.stringify({
        action: 'generate',
        destination,
        days,
        duration: days,
        group,
        groupType: group,
        budget,
        interests,
        primaryInterest: interests,
        prompt: buildItineraryPrompt(destination, days, group, budget, interests)
      })
```

**Replace with:**
```js
      body: JSON.stringify({
        action: 'generate',
        destination,
        origin,
        days,
        duration: days,
        group,
        groupType: group,
        budget,
        interests,
        primaryInterest: interests,
        prompt: buildItineraryPrompt(destination, days, group, budget, interests)
      })
```

### 9c — Remove hardcoded RULE 2 road times from `buildItineraryPrompt()`

**Find** `buildItineraryPrompt()` (around line 512). The entire `RULE 2 — NORTHEAST INDIA ACTUAL ROAD TIMES` block (lines 577–589) is now superseded by the Worker's skeleton. Delete that block:

```
RULE 2 — NORTHEAST INDIA ACTUAL ROAD TIMES (use these exactly):
- Dibrugarh → Pasighat: ...
- Dibrugarh → Roing: ...
...
- Shillong → Cherrapunji: ...
```

The Worker's skeleton block replaces this with verified Supabase data. Keeping the hardcoded block can cause contradictions when the skeleton says one thing and the frontend prompt says another.

> Note: The Worker uses `body.prompt` as the user message if it is a non-empty string (current line 683). After removing RULE 2, the remaining frontend prompt is still valid as a user message. Long-term, consider removing `buildItineraryPrompt()` from the frontend entirely and letting the Worker build both system and user messages — but that is a separate task.

---

## Step 10 — Deploy

```bash
cd /Users/vantagecircle/chaoindranuj/git-repo/incitetales-api
npx wrangler deploy
```

Then test end-to-end:
1. Go to `itinerary-builder/` and enter "Guwahati" as origin, "Mechuka" as destination, 7 days
2. On the result page, check Day 2 — it should show drive narrative with en-route stops in the morning and a locked afternoon
3. Check that no sightseeing appears on travel days

---

## Env Vars Summary

| Variable | Where set | Used for |
|---|---|---|
| `GROQ_API_KEY` | Already set | All AI calls |
| `SUPABASE_URL` | Already set | Supabase reads |
| `SUPABASE_ANON_KEY` | Already set | Supabase reads |
| `ADMIN_SECRET` | `wrangler secret put` | Admin page password |
| `SUPABASE_SERVICE_ROLE_KEY` | `wrangler secret put` | Admin page writes to Supabase |

---

## Key Files Quick Reference

| File | What changes |
|---|---|
| `incitetales-api/src/index.js` | Steps 2, 3, 5, 6, 7 — all Worker logic |
| `incitetales/itinerary-builder/index.html` | Step 8 — origin field + URL param |
| `incitetales/itinerary-result/index.html` | Step 9 — read origin, pass to Worker, remove hardcoded road times |
| Supabase Studio | Step 1 — add missing route rows manually |
| Admin page (`/admin`) | Step 4 — populate stops (browser, no code) |

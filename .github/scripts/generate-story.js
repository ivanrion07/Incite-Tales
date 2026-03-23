// .github/scripts/generate-story.js
// Runs in GitHub Actions — fetches story from Supabase, generates HTML page

const fs   = require('fs');
const path = require('path');
const https = require('https');

const SUPABASE_URL     = process.env.SUPABASE_URL;
const SUPABASE_ANON_KEY = process.env.SUPABASE_ANON_KEY;
const STORY_SLUG       = process.env.STORY_SLUG;

if (!SUPABASE_URL || !SUPABASE_ANON_KEY || !STORY_SLUG) {
  console.error('Missing environment variables');
  process.exit(1);
}

// ── Fetch story from Supabase ──
function fetchStory() {
  return new Promise((resolve, reject) => {
    const url = `${SUPABASE_URL}/rest/v1/stories?slug=eq.${encodeURIComponent(STORY_SLUG)}&select=*&limit=1`;
    const urlObj = new URL(url);
    const options = {
      hostname: urlObj.hostname,
      path:     urlObj.pathname + urlObj.search,
      headers: {
        'apikey':        SUPABASE_ANON_KEY,
        'Authorization': `Bearer ${SUPABASE_ANON_KEY}`,
      }
    };
    https.get(options, (res) => {
      let data = '';
      res.on('data', chunk => data += chunk);
      res.on('end', () => {
        try {
          const parsed = JSON.parse(data);
          resolve(Array.isArray(parsed) ? parsed[0] : null);
        } catch (e) { reject(e); }
      });
    }).on('error', reject);
  });
}

// ── Generate story HTML ──
function generateHTML(story) {
  const {
    title, slug, author_name, location,
    content_polished, published_at, type
  } = story;

  const date = new Date(published_at).toLocaleDateString('en-IN', {
    month: 'long', year: 'numeric'
  });

  const isFieldStory = type === 'field_story';
  const byline = isFieldStory
    ? `Field Story by ${author_name}`
    : `By ${author_name} · Incitetales`;

  // Paragraphs
  const paragraphs = content_polished
    .split('\n\n')
    .filter(p => p.trim().length > 0)
    .map((p, i) => {
      const cls = i === 0 ? 'class="intro"' : '';
      return `    <p ${cls}>${p.trim().replace(/\n/g, '<br>')}</p>`;
    })
    .join('\n\n');

  return `<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" type="image/png" href="../../favicon.png">
<title>${title} — Incitetales</title>
<meta name="description" content="A story about ${location} from the Incitetales field notes.">
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,600;0,700;1,400;1,600&family=DM+Mono:wght@300;400;500&family=Lora:ital,wght@0,400;0,500;1,400&display=swap" rel="stylesheet">
<style>
:root {
  --bg:#ffffff; --bg2:#fffdf5; --ink:#1c1814; --ink2:#3a342c; --ink3:#6a6058;
  --terra:#8b4a2a; --forest:#2a5c48; --yellow:#f5c842; --border:#ede8d8; --border2:#e0d8c4;
}
*,*::before,*::after{margin:0;padding:0;box-sizing:border-box;}
html{scroll-behavior:smooth;}
body{background:var(--bg);color:var(--ink);font-family:'Lora',Georgia,serif;font-size:16px;line-height:1.7;overflow-x:hidden;}
nav{position:fixed;top:0;left:0;right:0;z-index:100;display:flex;justify-content:center;align-items:center;padding:18px 48px;background:rgba(255,255,255,0.97);border-bottom:1px solid var(--border);backdrop-filter:blur(8px);}
.nav-logo{font-family:'Playfair Display',serif;font-size:20px;font-weight:700;color:var(--ink);text-decoration:none;}
.nav-logo span{background:var(--yellow);color:var(--ink);padding:0 4px;}
.story-hero{background:var(--ink);padding:120px 48px 72px;text-align:center;}
.story-tag{font-family:'DM Mono',monospace;font-size:8.5px;letter-spacing:0.3em;text-transform:uppercase;color:var(--yellow);margin-bottom:20px;}
.story-byline{font-family:'DM Mono',monospace;font-size:9px;letter-spacing:0.18em;text-transform:uppercase;color:rgba(255,255,255,0.4);margin-bottom:16px;}
.story-headline{font-family:'Playfair Display',serif;font-size:clamp(32px,5vw,56px);font-weight:400;color:#ffffff;line-height:1.1;margin-bottom:16px;}
.story-headline em{font-style:italic;color:var(--yellow);}
.story-location{font-size:14px;color:rgba(255,255,255,0.45);font-style:italic;}
.meta-bar{border-top:1px solid var(--border);border-bottom:1px solid var(--border);padding:14px 48px;display:flex;gap:32px;align-items:center;background:var(--bg2);}
.meta-item{font-family:'DM Mono',monospace;font-size:8px;letter-spacing:0.15em;text-transform:uppercase;color:var(--ink3);}
.meta-item strong{display:block;color:var(--ink);margin-top:2px;font-size:10px;}
.article-wrap{max-width:680px;margin:0 auto;padding:64px 48px 100px;}
.field-story-badge{display:inline-block;font-family:'DM Mono',monospace;font-size:8px;letter-spacing:0.2em;text-transform:uppercase;color:var(--forest);border:1px solid var(--forest);padding:4px 12px;margin-bottom:32px;opacity:0.8;}
.article-body p{margin-bottom:1.6em;color:var(--ink2);font-size:17px;line-height:1.85;}
.article-body p.intro{font-size:19px;color:var(--ink);font-style:italic;}
.article-body p:first-child::first-letter{font-family:'Playfair Display',serif;font-size:4em;font-weight:700;float:left;line-height:0.8;margin:0.08em 0.08em 0 0;color:var(--ink);}
footer{background:var(--bg2);border-top:1px solid var(--border);padding:32px 48px;display:flex;justify-content:space-between;align-items:center;}
.footer-copy{font-family:'DM Mono',monospace;font-size:8.5px;letter-spacing:0.12em;color:var(--ink3);text-transform:uppercase;}
.footer-tagline{font-family:'Playfair Display',serif;font-size:13px;font-style:italic;color:var(--ink3);}
@media(max-width:640px){.story-hero{padding:100px 24px 56px;}.meta-bar{padding:12px 24px;flex-wrap:wrap;gap:16px;}.article-wrap{padding:48px 24px 72px;}footer{padding:28px 24px;flex-direction:column;gap:8px;}}
</style>
</head>
<body>

<nav>
  <a href="../../" class="nav-logo">Incite<span>tales</span></a>
</nav>

<div class="story-hero">
  <div class="story-tag">◆ &nbsp; ${location}</div>
  <div class="story-byline">${byline}</div>
  <h1 class="story-headline">${title}</h1>
  <div class="story-location">${location}</div>
</div>

<div class="meta-bar">
  <div class="meta-item">Location<strong>${location}</strong></div>
  <div class="meta-item">Published<strong>${date}</strong></div>
  ${isFieldStory ? `<div class="meta-item">Type<strong>Field Story</strong></div>` : ''}
</div>

<div class="article-wrap">
  ${isFieldStory ? `<div class="field-story-badge">◆ Field Story by ${author_name}</div>` : ''}
  <div class="article-body">
${paragraphs}
  </div>
</div>

<footer>
  <span class="footer-copy">© 2026 Incitetales · Guwahati, Assam</span>
  <span class="footer-tagline">"One story. Every week."</span>
</footer>

</body>
</html>`;
}

// ── Main ──
(async () => {
  try {
    console.log(`Fetching story: ${STORY_SLUG}`);
    const story = await fetchStory();
    if (!story) {
      console.error(`Story not found: ${STORY_SLUG}`);
      process.exit(1);
    }

    const html      = generateHTML(story);
    const dir       = path.join('stories', story.slug);
    const filePath  = path.join(dir, 'index.html');

    fs.mkdirSync(dir, { recursive: true });
    fs.writeFileSync(filePath, html);
    console.log(`✅ Generated: ${filePath}`);
  } catch (err) {
    console.error('Error:', err.message);
    process.exit(1);
  }
})();

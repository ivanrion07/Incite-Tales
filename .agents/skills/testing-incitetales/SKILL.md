---
name: testing-incitetales
description: Test the Incite-Tales static site end-to-end. Use when verifying CSS/JS changes, shared utility refactors, or page rendering across the site.
---

# Testing Incite-Tales

## Overview
Incite-Tales is a static HTML/CSS/JS site (no build system, no bundler, no framework). Pages are plain HTML files served from the repo root.

## Local Setup
```bash
cd /home/ubuntu/Incite-Tales
python3 -m http.server 8080 &
```
No `npm install` or build step required. The site is ready to serve immediately.

## Shared Utilities (as of 2026-07)
- `css/shared.css` — Design tokens, reset, nav, footer, section, button, animation styles
- `js/analytics.js` — Google Analytics init (loaded on every page)
- `js/shared.js` — IntersectionObserver scroll-reveal + nav scroll-shadow
- `js/api-utils.js` — `extractJsonBlock()`, `parseModelJsonResponse()`, `readWorkerPayload()`, Supabase/Worker constants

## Key Pages to Test
| Page | Path | Key Dependencies |
|------|------|-----------------|
| Homepage | `/` | shared.css, analytics.js |
| Discover NE | `/discover-ne/` | shared.css, shared.js, analytics.js |
| Explore Nearby | `/explore-nearby/` | shared.css, shared.js, analytics.js |
| Merch | `/merch/` | shared.css, shared.js, analytics.js |
| Stories listing | `/stories/` | shared.css, api-utils.js (Supabase), analytics.js |
| Itinerary Builder | `/itinerary-builder/` | shared.css, api-utils.js, analytics.js |
| Itinerary Result | `/itinerary-result/` | shared.css, api-utils.js, analytics.js |
| Story subpages | `/stories/*/` | shared.css, analytics.js (some use api-utils.js) |

## Testing Strategy
1. **Visual rendering** — Each page should have styled nav (logo + links), proper typography (Lora serif font), and styled footer
2. **Shared CSS** — If shared.css fails to load, pages appear completely unstyled (no colors, default browser margins, no nav styling)
3. **Shared JS** — If shared.js fails, `.reveal` elements stay at `opacity: 0` (invisible cards/sections)
4. **API utils** — If api-utils.js fails, the Stories "Field Stories" tab won't fetch from Supabase, and itinerary generation will error on `extractJsonBlock is not defined`
5. **CSS overrides** — Some pages override shared.css defaults (e.g., Anini uses 18px body font instead of 16px, Maguri Beel has a completely dark theme and does NOT import shared.css)

## Common Failure Modes
- 404 on shared files: Check paths use absolute `/css/shared.css` not relative `../css/shared.css`
- CSS variable conflicts: Pages that override `:root` tokens might clash with shared.css tokens
- Dark-themed pages (Maguri Beel): Should NOT import shared.css — if it accidentally does, the white background will bleed through
- Scroll reveal invisible: If shared.js doesn't load, cards with `.reveal` class remain hidden

## Verification Checklist
- [ ] Open DevTools Network tab — all shared files return 200
- [ ] Console tab shows no red JS errors (cookie/third-party warnings from GA are OK)
- [ ] Nav bar renders with "Incite**tales**" logo (yellow highlight on "tales")
- [ ] Footer grid renders with columns (Stories, Trips, About)
- [ ] Stories "Field Stories" tab fetches and displays data from Supabase
- [ ] Scroll-reveal pages: scroll down and verify cards animate in

## Devin Secrets Needed
None required for local testing. The Supabase key and GA ID are hardcoded in the source.

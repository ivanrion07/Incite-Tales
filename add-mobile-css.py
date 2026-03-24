#!/usr/bin/env python3
# Run from inside your incitetales/ folder
# Adds mobile.css link to all pages except index.html (homepage)

import os

LINK_TAG = '<link rel="stylesheet" href="../css/mobile.css">'

PAGES = [
    'anini-the-unseen-valley/index.html',
    'itinerary-builder/index.html',
    'itinerary-result/index.html',
    'merch/index.html',
    'discover-ne/index.html',
    'explore-nearby/index.html',
    'share-your-story/index.html',
    'maguri-beel/index.html',
    'stories/index.html',
]

for page in PAGES:
    if not os.path.exists(page):
        print(f'⚠️  Not found: {page}')
        continue
    with open(page, 'r', encoding='utf-8') as f:
        content = f.read()
    if 'mobile.css' in content:
        print(f'✅ Already has mobile.css: {page}')
        continue
    if '</head>' not in content:
        print(f'❌ No </head>: {page}')
        continue
    content = content.replace('</head>', LINK_TAG + '\n</head>')
    with open(page, 'w', encoding='utf-8') as f:
        f.write(content)
    print(f'✅ Added: {page}')

print('\nDone.')

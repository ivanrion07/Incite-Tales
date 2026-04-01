#!/usr/bin/env python3
"""
Add mobile.css link to site HTML files in Incitetales.
Run from repo root: python3 add-mobile-css.py
"""

import os
import re
from pathlib import Path

HEAD_CLOSE_RE = re.compile(r"</head\s*>", re.IGNORECASE)
VIEWPORT_RE = re.compile(r'<meta\s+name=["\']viewport["\']', re.IGNORECASE)
MOBILE_CSS_RE = re.compile(r'href=["\'][^"\']*mobile\.css["\']', re.IGNORECASE)


def add_mobile_css_link(html_file):
    """Add mobile.css link if not already present"""
    html_path = Path(html_file)
    content = html_path.read_text(encoding='utf-8')

    # Check if mobile.css already linked
    if MOBILE_CSS_RE.search(content):
        print(f"✓ {html_file} — already has mobile.css")
        return False

    # Check if viewport meta exists
    has_viewport = VIEWPORT_RE.search(content) is not None
    if not has_viewport:
        print(f"⚠ {html_file} — missing viewport meta tag (critical for mobile)")

    # Find </head> tag
    if not HEAD_CLOSE_RE.search(content):
        print(f"✗ {html_file} — no </head> tag found")
        return False

    # Calculate relative path to css/mobile.css
    rel_path = os.path.relpath(Path('css/mobile.css'), start=html_path.parent).replace(os.sep, '/')

    # Add mobile.css link + viewport meta (if missing)
    viewport_meta = '<meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">\n'
    mobile_link = f'<link rel="stylesheet" href="{rel_path}">\n'

    insert_block = f'{viewport_meta}{mobile_link}' if not has_viewport else mobile_link
    content = HEAD_CLOSE_RE.sub(lambda match: f'{insert_block}{match.group(0)}', content, count=1)

    html_path.write_text(content, encoding='utf-8')

    print(f"✓ {html_file} — added mobile.css ({rel_path})")
    return True


def main():
    repo_root = Path('.')
    html_files = [
        path for path in repo_root.glob('**/*.html')
        if 'roadmap' not in path.parts and 'downloaded' not in path.parts
    ]

    if not html_files:
        print("No HTML files found. Run from Incitetales repo root.")
        return

    print(f"Found {len(html_files)} HTML files\n")

    updated = 0
    for html_file in sorted(html_files):
        if add_mobile_css_link(str(html_file)):
            updated += 1

    print(f"\n✓ Updated {updated} files")
    print("\nNext steps:")
    print("1. git diff — review changes")
    print("2. Test on mobile (DevTools: Cmd+Shift+M)")
    print("3. Check text contrast with WebAIM Contrast Checker")
    print("4. Deploy to GitHub Pages")

if __name__ == '__main__':
    main()

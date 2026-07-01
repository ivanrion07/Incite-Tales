"""Tests for add-mobile-css.py — add_mobile_css_link function."""

import importlib.util
import os
import sys
from pathlib import Path

import pytest

# Load module from non-standard filename
REPO_ROOT = Path(__file__).resolve().parent.parent
spec = importlib.util.spec_from_file_location("add_mobile_css", REPO_ROOT / "add-mobile-css.py")
add_mobile_css = importlib.util.module_from_spec(spec)
spec.loader.exec_module(add_mobile_css)

add_mobile_css_link = add_mobile_css.add_mobile_css_link
HEAD_CLOSE_RE = add_mobile_css.HEAD_CLOSE_RE
VIEWPORT_RE = add_mobile_css.VIEWPORT_RE
MOBILE_CSS_RE = add_mobile_css.MOBILE_CSS_RE


# ── Regex unit tests ──────────────────────────────────────────

class TestRegexPatterns:
    def test_head_close_matches_standard(self):
        assert HEAD_CLOSE_RE.search("</head>") is not None

    def test_head_close_matches_with_spaces(self):
        assert HEAD_CLOSE_RE.search("</head  >") is not None

    def test_head_close_is_case_insensitive(self):
        assert HEAD_CLOSE_RE.search("</HEAD>") is not None

    def test_viewport_matches_double_quotes(self):
        assert VIEWPORT_RE.search('<meta name="viewport"') is not None

    def test_viewport_matches_single_quotes(self):
        assert VIEWPORT_RE.search("<meta name='viewport'") is not None

    def test_viewport_is_case_insensitive(self):
        assert VIEWPORT_RE.search('<META NAME="viewport"') is not None

    def test_mobile_css_matches_double_quotes(self):
        assert MOBILE_CSS_RE.search('href="css/mobile.css"') is not None

    def test_mobile_css_matches_single_quotes(self):
        assert MOBILE_CSS_RE.search("href='../css/mobile.css'") is not None

    def test_mobile_css_matches_nested_path(self):
        assert MOBILE_CSS_RE.search('href="../../css/mobile.css"') is not None


# ── add_mobile_css_link function tests ────────────────────────

class TestAddMobileCssLink:
    def _write_html(self, tmp_path, content, name="test.html"):
        f = tmp_path / name
        f.write_text(content, encoding="utf-8")
        return str(f)

    def test_adds_mobile_css_to_page_with_viewport(self, tmp_path):
        html = (
            "<html><head>\n"
            '<meta name="viewport" content="width=device-width">\n'
            "</head><body></body></html>"
        )
        path = self._write_html(tmp_path, html)
        result = add_mobile_css_link(path)
        assert result is True
        updated = Path(path).read_text(encoding="utf-8")
        assert "mobile.css" in updated
        # Should NOT add a second viewport meta
        assert updated.count("viewport") == 1

    def test_adds_viewport_when_missing(self, tmp_path):
        html = "<html><head></head><body></body></html>"
        path = self._write_html(tmp_path, html)
        result = add_mobile_css_link(path)
        assert result is True
        updated = Path(path).read_text(encoding="utf-8")
        assert "mobile.css" in updated
        assert "viewport" in updated

    def test_skips_file_already_has_mobile_css(self, tmp_path):
        html = (
            "<html><head>\n"
            '<link rel="stylesheet" href="css/mobile.css">\n'
            "</head><body></body></html>"
        )
        path = self._write_html(tmp_path, html)
        result = add_mobile_css_link(path)
        assert result is False

    def test_skips_file_without_head_close_tag(self, tmp_path):
        html = "<html><body>No head tag here</body></html>"
        path = self._write_html(tmp_path, html)
        result = add_mobile_css_link(path)
        assert result is False

    def test_relative_path_from_root(self, tmp_path):
        html = (
            "<html><head>\n"
            '<meta name="viewport" content="width=device-width">\n'
            "</head><body></body></html>"
        )
        path = self._write_html(tmp_path, html)
        old_cwd = os.getcwd()
        try:
            os.chdir(tmp_path)
            # Create css/mobile.css so the relative path resolves
            (tmp_path / "css").mkdir(exist_ok=True)
            (tmp_path / "css" / "mobile.css").write_text("", encoding="utf-8")
            result = add_mobile_css_link(path)
            assert result is True
            updated = Path(path).read_text(encoding="utf-8")
            assert "mobile.css" in updated
        finally:
            os.chdir(old_cwd)

    def test_relative_path_from_subdirectory(self, tmp_path):
        subdir = tmp_path / "pages" / "about"
        subdir.mkdir(parents=True)
        html = (
            "<html><head>\n"
            '<meta name="viewport" content="width=device-width">\n'
            "</head><body></body></html>"
        )
        path = self._write_html(subdir, html, "index.html")
        old_cwd = os.getcwd()
        try:
            os.chdir(tmp_path)
            (tmp_path / "css").mkdir(exist_ok=True)
            (tmp_path / "css" / "mobile.css").write_text("", encoding="utf-8")
            result = add_mobile_css_link(path)
            assert result is True
            updated = Path(path).read_text(encoding="utf-8")
            assert "../../css/mobile.css" in updated
        finally:
            os.chdir(old_cwd)

    def test_inserted_before_head_close(self, tmp_path):
        html = (
            "<html><head>\n"
            '<meta name="viewport" content="width=device-width">\n'
            "</head><body></body></html>"
        )
        path = self._write_html(tmp_path, html)
        add_mobile_css_link(path)
        updated = Path(path).read_text(encoding="utf-8")
        mobile_pos = updated.index("mobile.css")
        head_close_pos = updated.index("</head>")
        assert mobile_pos < head_close_pos

    def test_preserves_existing_content(self, tmp_path):
        html = (
            "<html><head>\n"
            '<meta charset="UTF-8">\n'
            '<meta name="viewport" content="width=device-width">\n'
            '<link rel="stylesheet" href="main.css">\n'
            "</head><body><h1>Hello</h1></body></html>"
        )
        path = self._write_html(tmp_path, html)
        add_mobile_css_link(path)
        updated = Path(path).read_text(encoding="utf-8")
        assert '<meta charset="UTF-8">' in updated
        assert 'href="main.css"' in updated
        assert "<h1>Hello</h1>" in updated

    def test_idempotent(self, tmp_path):
        html = (
            "<html><head>\n"
            '<meta name="viewport" content="width=device-width">\n'
            "</head><body></body></html>"
        )
        path = self._write_html(tmp_path, html)
        add_mobile_css_link(path)
        first_pass = Path(path).read_text(encoding="utf-8")
        result = add_mobile_css_link(path)
        assert result is False
        second_pass = Path(path).read_text(encoding="utf-8")
        assert first_pass == second_pass

    def test_handles_uppercase_head(self, tmp_path):
        html = (
            "<html><HEAD>\n"
            '<meta name="viewport" content="width=device-width">\n'
            "</HEAD><body></body></html>"
        )
        path = self._write_html(tmp_path, html)
        result = add_mobile_css_link(path)
        assert result is True
        updated = Path(path).read_text(encoding="utf-8")
        assert "mobile.css" in updated

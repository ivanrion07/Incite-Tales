const { generateHTML } = require('../.github/scripts/generate-story');

const STORY_FIXTURE = {
  title: 'The Lost Valley of Anini',
  slug: 'the-lost-valley-of-anini',
  author_name: 'Rana Das',
  location: 'Anini, Dibang Valley',
  content_polished: 'The road ends here.\n\nBeyond Roing, the asphalt gives way to gravel.\n\nAnini is silence made visible.',
  published_at: '2026-03-15T10:00:00Z',
  type: 'field_story',
};

describe('generateHTML', () => {
  let html;

  beforeAll(() => {
    html = generateHTML(STORY_FIXTURE);
  });

  test('produces valid HTML document', () => {
    expect(html).toContain('<!DOCTYPE html>');
    expect(html).toContain('<html lang="en">');
    expect(html).toContain('</html>');
  });

  test('includes story title in <title> tag', () => {
    expect(html).toContain('<title>The Lost Valley of Anini — Incitetales</title>');
  });

  test('includes story title in headline', () => {
    expect(html).toContain('The Lost Valley of Anini');
  });

  test('includes meta description with location', () => {
    expect(html).toContain('content="A story about Anini, Dibang Valley from the Incitetales field notes."');
  });

  test('includes location in story tag and hero', () => {
    expect(html).toContain('Anini, Dibang Valley');
  });

  test('formats date correctly', () => {
    // en-IN locale: "March 2026"
    expect(html).toMatch(/March\s+2026/);
  });

  test('renders field_story byline', () => {
    expect(html).toContain('Field Story by Rana Das');
  });

  test('renders field story badge', () => {
    expect(html).toContain('field-story-badge');
    expect(html).toContain('Field Story by Rana Das');
  });

  test('renders field story type in meta bar', () => {
    expect(html).toContain('Type<strong>Field Story</strong>');
  });

  test('splits content into paragraphs', () => {
    expect(html).toContain('<p class="intro">The road ends here.</p>');
    expect(html).toContain('<p >Beyond Roing, the asphalt gives way to gravel.</p>');
    expect(html).toContain('<p >Anini is silence made visible.</p>');
  });

  test('first paragraph has intro class', () => {
    const introMatch = html.match(/<p class="intro">/g);
    expect(introMatch).not.toBeNull();
    expect(introMatch.length).toBe(1);
  });

  test('includes footer with copyright', () => {
    expect(html).toContain('© 2026 Incitetales');
    expect(html).toContain('"One story. Every week."');
  });

  test('includes Incitetales nav logo', () => {
    expect(html).toContain('Incite<span>tales</span>');
  });

  test('includes Google Fonts link', () => {
    expect(html).toContain('fonts.googleapis.com');
    expect(html).toContain('Playfair+Display');
  });
});

describe('generateHTML non-field story', () => {
  const regularStory = {
    ...STORY_FIXTURE,
    type: 'editorial',
    author_name: 'Incitetales Team',
  };

  let html;

  beforeAll(() => {
    html = generateHTML(regularStory);
  });

  test('renders standard byline for non-field story', () => {
    expect(html).toContain('By Incitetales Team');
    expect(html).toContain('Incitetales');
  });

  test('does not render field story badge div in body', () => {
    expect(html).not.toContain('◆ Field Story by');
  });

  test('does not include Field Story type in meta bar', () => {
    expect(html).not.toContain('Type<strong>Field Story</strong>');
  });
});

describe('generateHTML content edge cases', () => {
  test('handles single paragraph content', () => {
    const story = {
      ...STORY_FIXTURE,
      content_polished: 'Just one paragraph.',
    };
    const html = generateHTML(story);
    expect(html).toContain('<p class="intro">Just one paragraph.</p>');
  });

  test('handles content with inline newlines', () => {
    const story = {
      ...STORY_FIXTURE,
      content_polished: 'Line one\nLine two\n\nSecond paragraph.',
    };
    const html = generateHTML(story);
    expect(html).toContain('Line one<br>Line two');
    expect(html).toContain('Second paragraph.');
  });

  test('filters out empty paragraphs', () => {
    const story = {
      ...STORY_FIXTURE,
      content_polished: 'First para.\n\n\n\nSecond para.',
    };
    const html = generateHTML(story);
    const pCount = (html.match(/<p /g) || []).length;
    expect(pCount).toBe(2);
  });

  test('handles special HTML characters in title', () => {
    const story = {
      ...STORY_FIXTURE,
      title: 'A Tale of "Rivers" & Mountains',
    };
    const html = generateHTML(story);
    expect(html).toContain('A Tale of "Rivers" & Mountains');
  });
});

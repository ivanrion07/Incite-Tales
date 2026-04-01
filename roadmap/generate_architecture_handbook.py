from datetime import date
from pathlib import Path

from reportlab.lib import colors
from reportlab.lib.enums import TA_CENTER
from reportlab.lib.pagesizes import A4
from reportlab.lib.styles import ParagraphStyle, getSampleStyleSheet
from reportlab.lib.units import mm
from reportlab.platypus import (
    KeepTogether,
    ListFlowable,
    ListItem,
    PageBreak,
    Paragraph,
    SimpleDocTemplate,
    Spacer,
    Table,
    TableStyle,
)


ROOT = Path(__file__).resolve().parent
OUTPUT = ROOT / "incitetales_architecture_handbook.pdf"


def build_styles():
    styles = getSampleStyleSheet()
    styles.add(
        ParagraphStyle(
            name="HandbookTitle",
            parent=styles["Title"],
            fontName="Helvetica-Bold",
            fontSize=21,
            leading=25,
            textColor=colors.HexColor("#1c1814"),
            alignment=TA_CENTER,
            spaceAfter=8,
        )
    )
    styles.add(
        ParagraphStyle(
            name="HandbookSubtle",
            parent=styles["BodyText"],
            fontName="Helvetica",
            fontSize=8.7,
            leading=11.2,
            textColor=colors.HexColor("#6a6058"),
            alignment=TA_CENTER,
            spaceAfter=12,
        )
    )
    styles.add(
        ParagraphStyle(
            name="HandbookH1",
            parent=styles["Heading1"],
            fontName="Helvetica-Bold",
            fontSize=14.5,
            leading=18,
            textColor=colors.HexColor("#1c1814"),
            spaceBefore=9,
            spaceAfter=6,
            keepWithNext=True,
        )
    )
    styles.add(
        ParagraphStyle(
            name="HandbookH2",
            parent=styles["Heading2"],
            fontName="Helvetica-Bold",
            fontSize=11,
            leading=14,
            textColor=colors.HexColor("#2a5c48"),
            spaceBefore=6,
            spaceAfter=4,
            keepWithNext=True,
        )
    )
    styles.add(
        ParagraphStyle(
            name="HandbookBody",
            parent=styles["BodyText"],
            fontName="Helvetica",
            fontSize=8.8,
            leading=11.8,
            textColor=colors.HexColor("#2b2621"),
            spaceAfter=4,
        )
    )
    styles.add(
        ParagraphStyle(
            name="HandbookCode",
            parent=styles["BodyText"],
            fontName="Courier",
            fontSize=7.7,
            leading=9.5,
            textColor=colors.HexColor("#1c1814"),
            backColor=colors.HexColor("#f7f3ea"),
            borderPadding=4,
            spaceAfter=4,
            wordWrap="CJK",
        )
    )
    styles.add(
        ParagraphStyle(
            name="TableCell",
            parent=styles["BodyText"],
            fontName="Helvetica",
            fontSize=8.1,
            leading=10.2,
            textColor=colors.HexColor("#2b2621"),
        )
    )
    styles.add(
        ParagraphStyle(
            name="TableHead",
            parent=styles["BodyText"],
            fontName="Helvetica-Bold",
            fontSize=8.3,
            leading=10.4,
            textColor=colors.white,
        )
    )
    return styles


def add_page_num(canvas, doc):
    canvas.setFont("Helvetica", 8)
    canvas.setFillColor(colors.HexColor("#6a6058"))
    canvas.drawRightString(A4[0] - 16 * mm, 9 * mm, f"Page {doc.page}")
    canvas.drawString(16 * mm, 9 * mm, "Incitetales Architecture Handbook")


def paragraph(text, styles, style="HandbookBody"):
    return Paragraph(text, styles[style])


def bullets(items, styles):
    return ListFlowable(
        [ListItem(Paragraph(item, styles["HandbookBody"])) for item in items],
        bulletType="bullet",
        leftPadding=13,
        bulletFontName="Helvetica",
        bulletFontSize=7.5,
        bulletColor=colors.HexColor("#8b4a2a"),
        spaceAfter=4,
    )


def code_lines(lines, styles):
    return [Paragraph(line, styles["HandbookCode"]) for line in lines]


def repo_table(styles):
    rows = [
        [
            Paragraph("Path", styles["TableHead"]),
            Paragraph("Role", styles["TableHead"]),
        ],
        [
            Paragraph("itinerary-builder/", styles["TableCell"]),
            Paragraph(
                "Free-text + form-based trip planning UI; local interpretation; worker call; loading state; localStorage handoff.",
                styles["TableCell"],
            ),
        ],
        [
            Paragraph("itinerary-result/", styles["TableCell"]),
            Paragraph(
                "Renders the structured itinerary JSON returned by the worker; supports save-to-email.",
                styles["TableCell"],
            ),
        ],
        [
            Paragraph("share-your-story/", styles["TableCell"]),
            Paragraph(
                "Story submission and publish-confirm flow; sends text to worker for polishing and extraction.",
                styles["TableCell"],
            ),
        ],
        [
            Paragraph("stories/", styles["TableCell"]),
            Paragraph(
                "Story listing UI and generated story pages. Field stories are pulled from Supabase on the listing page.",
                styles["TableCell"],
            ),
        ],
        [
            Paragraph("data/insights/", styles["TableCell"]),
            Paragraph(
                "Local verified knowledge base including route, offbeat, cultural, seasonal, experience, and destination files.",
                styles["TableCell"],
            ),
        ],
        [
            Paragraph("js/InsightEngine.js", styles["TableCell"]),
            Paragraph(
                "Client-side loader, matcher, smart extractor, and prompt-context builder for the local brain.",
                styles["TableCell"],
            ),
        ],
        [
            Paragraph(".github/scripts/", styles["TableCell"]),
            Paragraph(
                "Automation scripts, including story-page generation from Supabase.",
                styles["TableCell"],
            ),
        ],
        [
            Paragraph(".github/workflows/", styles["TableCell"]),
            Paragraph(
                "GitHub Pages deploy and story generation automation.",
                styles["TableCell"],
            ),
        ],
        [
            Paragraph("roadmap/", styles["TableCell"]),
            Paragraph(
                "Reference docs, roadmaps, troubleshooting notes, and generated handbook PDFs.",
                styles["TableCell"],
            ),
        ],
    ]

    table = Table(
        rows,
        colWidths=[49 * mm, 122 * mm],
        repeatRows=1,
        splitByRow=0,
    )
    table.setStyle(
        TableStyle(
            [
                ("BACKGROUND", (0, 0), (-1, 0), colors.HexColor("#1c1814")),
                ("TEXTCOLOR", (0, 0), (-1, 0), colors.white),
                ("VALIGN", (0, 0), (-1, -1), "TOP"),
                ("GRID", (0, 0), (-1, -1), 0.3, colors.HexColor("#d8d0c0")),
                (
                    "ROWBACKGROUNDS",
                    (0, 1),
                    (-1, -1),
                    [colors.HexColor("#fffdf7"), colors.HexColor("#fbf7ef")],
                ),
                ("LEFTPADDING", (0, 0), (-1, -1), 5),
                ("RIGHTPADDING", (0, 0), (-1, -1), 5),
                ("TOPPADDING", (0, 0), (-1, -1), 4),
                ("BOTTOMPADDING", (0, 0), (-1, -1), 4),
            ]
        )
    )
    return KeepTogether([table])


def build_story():
    styles = build_styles()
    story = [
        Paragraph("Incitetales Architecture Handbook", styles["HandbookTitle"]),
        Paragraph(
            f"Generated for repo reference on {date.today().isoformat()} · Technical handbook for the current website, content system, itinerary builder, local insight brain, and integration contracts.",
            styles["HandbookSubtle"],
        ),
        Paragraph("1. Product Snapshot", styles["HandbookH1"]),
        paragraph(
            "Incitetales is a static-site style travel product centered around three connected systems: editorial destination and story pages, a verified-knowledge itinerary builder, and a story submission flow that feeds a structured travel knowledge layer. The current codebase is primarily frontend HTML/CSS/JS plus data JSON, with Cloudflare Worker and Supabase acting as external runtime services.",
            styles,
        ),
        bullets(
            [
                "<b>Static site pages:</b> destination storytelling, story archives, itinerary builder, itinerary result, share-your-story, and supporting sections such as discover/explore/merch.",
                "<b>Local knowledge brain:</b> <font name=\"Courier\">/data/insights</font> JSON files loaded in-browser by <font name=\"Courier\">js/InsightEngine.js</font>.",
                "<b>External backend runtime:</b> Cloudflare Worker for itinerary generation, story processing/publishing, and email delivery.",
                "<b>External database:</b> Supabase tables for stories and extracted insights.",
                "<b>Automation:</b> GitHub Actions to deploy the site and generate story pages from Supabase content.",
            ],
            styles,
        ),
        Paragraph("2. Repository Structure", styles["HandbookH1"]),
        paragraph(
            "At a high level, the repository is organized around standalone page folders, a JSON knowledge base, client-side logic, and roadmap/reference materials.",
            styles,
        ),
        repo_table(styles),
        Spacer(1, 6),
        Paragraph("3. Local Insight Brain", styles["HandbookH1"]),
        paragraph(
            "The local knowledge base lives under <font name=\"Courier\">/data/insights</font>. The root file <font name=\"Courier\">data/insights/index.json</font> currently declares <b>version 2.0</b>, <b>16 total entries</b>, and describes the dataset as a unified brain of insights plus destinations. This matters because product language may refer to “InsightEngine v3.0”, but the checked-in local engine and local index are still labeled 2.0.",
            styles,
        ),
        bullets(
            [
                "<b>Current local entry count:</b> 16 JSON entries.",
                "<b>Types represented:</b> hidden-spot, seasonal, cultural, offbeat/route, experience, and destination.",
                "<b>Arunachal destination layer:</b> West Kameng, Tawang, Ziro, Mechuka, Dibang Valley, Changlang, East Siang/Pasighat, and Lohit/Namsai.",
                "<b>Representative nested destination data:</b> Dibang Valley includes Roing, Mayodia Pass, and Anini with route day-splits, stays, local tips, permit notes, connectivity, and season rules.",
                "<b>Geographic scope model:</b> each file exposes <font name=\"Courier\">geographic_scope</font> tokens used for verified matching.",
            ],
            styles,
        ),
        Paragraph("InsightEngine client responsibilities", styles["HandbookH2"]),
        bullets(
            [
                "<font name=\"Courier\">load()</font> loads <font name=\"Courier\">index.json</font> and every indexed entry file into memory.",
                "<font name=\"Courier\">scopeMatch(text, destination)</font> matches a user query against <font name=\"Courier\">geographic_scope[]</font> and sorts by hidden score.",
                "<font name=\"Courier\">smartExtract(entry, userQuery)</font> reduces large entries into prompt-relevant fields such as destinations, route day splits, stays, permits, connectivity, and local tips.",
                "<font name=\"Courier\">buildPromptContext(userText, destination, selectedIds)</font> returns <font name=\"Courier\">contextBlock</font>, <font name=\"Courier\">matchedEntries</font>, <font name=\"Courier\">hasVerifiedData</font>, and <font name=\"Courier\">isAIOnly</font>.",
                "<font name=\"Courier\">_buildContextString()</font> turns extracted entries into hard prompt instructions such as “use route day_splits exactly” and “use recommended stays”.",
            ],
            styles,
        ),
        Paragraph("Key local brain paths", styles["HandbookH2"]),
        *code_lines(
            [
                "js/InsightEngine.js",
                "data/insights/index.json",
                "data/insights/destinations/arunachal-pradesh/dibang-valley.json",
                "data/insights/destinations/arunachal-pradesh/west-kameng.json",
                "data/insights/offbeat/tawang-corridor.json",
            ],
            styles,
        ),
        Paragraph("4. Itinerary Builder Architecture", styles["HandbookH1"]),
        paragraph(
            "The itinerary builder page is the most complex frontend flow in the repo. It blends a free-text trip idea input with structured form controls, verified-match interpretation, selected-insight prompt assembly, and a worker-based itinerary generation step.",
            styles,
        ),
        Paragraph("Builder page responsibilities", styles["HandbookH2"]),
        bullets(
            [
                "Load the local InsightEngine and derive matched knowledge from the user’s trip idea.",
                "Interpret free text into destination, duration, group, budget, and interest defaults.",
                "Preserve user-selected dropdown overrides separately from interpreted values.",
                "Build a strict generation prompt with local context and hard Northeast India logistics rules.",
                "Submit a structured request to the Cloudflare Worker and accept either direct structured JSON or text-wrapped JSON.",
                "Store the final itinerary payload in localStorage and redirect to the result page in the same tab.",
            ],
            styles,
        ),
        Paragraph("Current key state model inside itinerary-builder/index.html", styles["HandbookH2"]),
        bullets(
            [
                "<font name=\"Courier\">currentInsights</font>: current verified matches from the local brain.",
                "<font name=\"Courier\">interpretedOverrides</font>: interpreted values from the idea textbox.",
                "<font name=\"Courier\">manualSelections</font>: flags showing whether a dropdown value was chosen explicitly by the user.",
                "<font name=\"Courier\">currentItinerary</font>: JSON string of the generated itinerary for the active session.",
                "<font name=\"Courier\">engineReady</font>: indicates that the local InsightEngine has finished loading.",
            ],
            styles,
        ),
        Paragraph("Key interpretation logic", styles["HandbookH2"]),
        bullets(
            [
                "<font name=\"Courier\">findVerifiedDestinationMatch()</font> prefers nested destinations, key stops, and matched local entries over generic preset inference.",
                "<font name=\"Courier\">collectVerifiedSuggestions()</font> builds 2–3 concrete recommendations from verified data such as <font name=\"Courier\">what_is_there</font>, <font name=\"Courier\">local_tips</font>, <font name=\"Courier\">key_stops</font>, and verified stays.",
                "<font name=\"Courier\">isConcreteSuggestionName()</font> blocks broad region labels like Arunachal Pradesh, West Kameng, Dibang Valley, route, district, and state from appearing as recommendations.",
                "<font name=\"Courier\">normalizeIdeaResult()</font> normalizes parsed values and preserves any valid integer day count from 1–30 instead of forcing a small preset list.",
                "<font name=\"Courier\">ensureDayOption()</font> dynamically inserts typed durations such as 4 days into the dropdown without forcing a preset choice.",
            ],
            styles,
        ),
        Paragraph("Manual vs interpreted control model", styles["HandbookH2"]),
        paragraph(
            "A major behavior in the builder is the separation between values inferred from the textbox and values explicitly chosen by the user. The intended rule is: typed free text can influence defaults, but dropdown values should only take priority if the user actively selects them. The code implements this by storing boolean control flags in <font name=\"Courier\">manualSelections</font> and resolving request values in <font name=\"Courier\">generateItinerary()</font> using a priority chain.",
            styles,
        ),
        Paragraph("Priority chain used for final request values", styles["HandbookCode"]),
        *[paragraph(line, styles) for line in [
            "destination = custom text or interpreted destination, unless manual dropdown destination was selected",
            "days = manual dropdown days OR interpreted days OR live textbox interpretation OR existing dropdown value",
            "group, budget, and interests follow the same pattern",
            "generateItinerary() re-runs live interpretation if needed so typed durations such as “4 days” survive final submit",
        ]],
        Paragraph("Worker request contract from the builder", styles["HandbookH2"]),
        paragraph(
            "The builder posts a structured JSON body to the worker. The request includes both normalized structured fields and a fully expanded hard-constraint prompt.",
            styles,
        ),
        Paragraph(
            "{ action, destination, days, duration, group, groupType, budget, interests, primaryInterest, prompt }",
            styles["HandbookCode"],
        ),
        paragraph(
            "The included <font name=\"Courier\">prompt</font> is important because it carries the strict travel rules that prevent impossible itineraries, for example the two-day Dibrugarh → Roing → Anini access pattern and the requirement that journeys longer than 4 hours are treated as travel days.",
            styles,
        ),
        Paragraph("Current builder file to inspect", styles["HandbookH2"]),
        *code_lines(
            [
                "itinerary-builder/index.html",
                "Functions: parseModelJsonResponse, readWorkerPayload, resolveIdeaInterpretation, findVerifiedDestinationMatch, collectVerifiedSuggestions, generateItinerary",
                "Key globals: interpretedOverrides, manualSelections, currentInsights",
            ],
            styles,
        ),
        Paragraph("5. Itinerary Result Page", styles["HandbookH1"]),
        paragraph(
            "The result page is a renderer, not a generator. It expects the builder to have already stored a structured itinerary payload in localStorage under <font name=\"Courier\">incitetales_itinerary</font>.",
            styles,
        ),
        bullets(
            [
                "<font name=\"Courier\">renderItinerary(data, meta)</font> renders overview, day cards, permits, budget rows, and packing list.",
                "The hero visual is generated as inline SVG fallback imagery rather than fetched photography.",
                "The result page clears <font name=\"Courier\">incitetales_itinerary</font> after successful render to avoid stale state.",
                "<font name=\"Courier\">saveItinerary()</font> can post an email delivery request to the worker.",
            ],
            styles,
        ),
        *code_lines(
            [
                "itinerary-result/index.html",
                "localStorage key: incitetales_itinerary",
                "Functions: renderItinerary, saveItinerary, toggleDay, buildImageUrl",
            ],
            styles,
        ),
        Paragraph("6. Share Your Story Pipeline", styles["HandbookH1"]),
        paragraph(
            "The story submission flow is a frontend page backed by worker endpoints. It is designed to convert a user story into polished editorial copy plus extracted structured insight data.",
            styles,
        ),
        bullets(
            [
                "Step 1: user submits title, location, author details, and raw content.",
                "Step 2: page posts to <font name=\"Courier\">/story/process</font> on the worker.",
                "Step 3: response returns polished text and an <font name=\"Courier\">extracted</font> insight object.",
                "Step 4: the page previews “what your story adds to the brain”, including geographic scope, local tips, warnings, and season notes.",
                "Step 5: publish posts to <font name=\"Courier\">/story/publish</font> with original text, polished text, extracted insights, and slug.",
                "Step 6: success state explicitly tells the user the facts have been added to the knowledge base.",
            ],
            styles,
        ),
        *code_lines(
            [
                "share-your-story/index.html",
                "Worker endpoints used: /story/process and /story/publish",
                "Key functions: renderInsights, publishStory",
            ],
            styles,
        ),
        Paragraph("7. Stories System and Publishing Automation", styles["HandbookH1"]),
        paragraph(
            "Stories exist in two modes in the current product: static story pages committed into the repo and “field stories” loaded dynamically from Supabase on the listing page.",
            styles,
        ),
        bullets(
            [
                "<font name=\"Courier\">stories/index.html</font> lazy-loads field stories from the Supabase <font name=\"Courier\">stories</font> table when the field tab is opened.",
                "Story cards link either to a supplied <font name=\"Courier\">story_url</font> or to a generated local <font name=\"Courier\">stories/&lt;slug&gt;/index.html</font> path.",
                "GitHub Actions workflow <font name=\"Courier\">.github/workflows/generate-story.yml</font> handles repository-dispatch events of type <font name=\"Courier\">new-story</font>.",
                "Automation script <font name=\"Courier\">.github/scripts/generate-story.js</font> fetches a story record from Supabase and writes a static HTML story page into the repo.",
                "Workflow <font name=\"Courier\">.github/workflows/deploy.yml</font> deploys the whole repository to GitHub Pages on pushes to main.",
            ],
            styles,
        ),
        Paragraph("8. Current Cloudflare Worker Contract", styles["HandbookH1"]),
        paragraph(
            "The worker source is not part of this repository, but the frontend code and active integration contract make its responsibilities clear. The worker is expected to handle itinerary generation, story processing, story publishing, and some email delivery paths.",
            styles,
        ),
        bullets(
            [
                "<b>Generate action:</b> accepts structured itinerary input plus an optional prompt; returns structured JSON with <font name=\"Courier\">destination</font>, <font name=\"Courier\">title</font>, <font name=\"Courier\">overview</font>, <font name=\"Courier\">days[]</font>, <font name=\"Courier\">permits</font>, <font name=\"Courier\">budget[]</font>, and <font name=\"Courier\">packing[]</font>.",
                "<b>Story actions:</b> <font name=\"Courier\">/story/process</font> and <font name=\"Courier\">/story/publish</font>.",
                "<b>Email behavior:</b> builder/result flows may ask the worker to email itinerary content.",
                "<b>Knowledge inputs:</b> product intent is that itinerary generation should be grounded in local verified knowledge and Supabase-derived extracted insights, even though that backend source-unification logic lives outside this repo.",
            ],
            styles,
        ),
        Paragraph("Important architecture note on “InsightEngine v3.0”", styles["HandbookH2"]),
        paragraph(
            "In the checked-in repo, the local browser engine and local insight index are still labeled version 2.0. Product discussion and backend work may call the unified local-plus-Supabase concept “v3.0”, but the repo itself still exposes <font name=\"Courier\">InsightEngine.js — v2.0</font> and <font name=\"Courier\">data/insights/index.json version 2.0</font>. This naming mismatch is worth remembering during debugging.",
            styles,
        ),
        Paragraph("9. Data Flow Summary", styles["HandbookH1"]),
        bullets(
            [
                "<b>Local idea interpretation path:</b> textbox → InsightEngine local scope match → verified destination inference → recommendation cards and interpreted defaults.",
                "<b>Final itinerary generation path:</b> interpreted/manual values → strict prompt assembly → worker POST → structured itinerary JSON → localStorage handoff → result page render.",
                "<b>Story-to-brain path:</b> story submission → worker extraction → publish → Supabase stories and insights ecosystem.",
                "<b>Story display path:</b> Supabase story record → GitHub Actions generation script → static story page in repo → deploy to GitHub Pages.",
            ],
            styles,
        ),
        Paragraph("10. Known Technical Realities and Debug Notes", styles["HandbookH1"]),
        bullets(
            [
                "The builder’s free-text experience depends heavily on the local JSON brain; incorrect destination interpretation usually points first to matching logic or data structure in <font name=\"Courier\">data/insights</font>.",
                "The result page only renders what the builder stored; if generation succeeds but no result shows, inspect the localStorage handoff.",
                "If story pages appear in the Stories section, that does not automatically prove the extracted insight rows are being consumed by itinerary generation.",
                "If a place exists as a visible story but not as structured insight data, the itinerary engine may still fall back to generic output.",
                "The worker is an external dependency; frontend robustness includes handling direct structured JSON and older text-wrapped JSON gracefully.",
            ],
            styles,
        ),
        Paragraph("11. Fast Inspection Checklist", styles["HandbookH1"]),
        bullets(
            [
                "<b>Builder interpretation wrong:</b> inspect <font name=\"Courier\">resolveIdeaInterpretation()</font>, <font name=\"Courier\">findVerifiedDestinationMatch()</font>, local JSON <font name=\"Courier\">geographic_scope</font>, nested destination names, and suggestion filtering.",
                "<b>Wrong duration, group, or budget:</b> inspect <font name=\"Courier\">inferDaysFromIdea()</font>, <font name=\"Courier\">normalizeIdeaResult()</font>, <font name=\"Courier\">ensureDayOption()</font>, and <font name=\"Courier\">manualSelections</font>.",
                "<b>Generation alert shown:</b> inspect worker response body, <font name=\"Courier\">readWorkerPayload()</font>, and <font name=\"Courier\">parseModelJsonResponse()</font>.",
                "<b>Result page empty:</b> inspect the <font name=\"Courier\">incitetales_itinerary</font> localStorage payload and <font name=\"Courier\">renderItinerary()</font>.",
                "<b>Story extraction issues:</b> inspect <font name=\"Courier\">share-your-story/index.html</font> and the worker <font name=\"Courier\">/story/process</font> output.",
                "<b>Story page generation issues:</b> inspect <font name=\"Courier\">.github/workflows/generate-story.yml</font> and <font name=\"Courier\">.github/scripts/generate-story.js</font>.",
                "<b>Deploy issues:</b> inspect <font name=\"Courier\">.github/workflows/deploy.yml</font> and GitHub Pages status.",
            ],
            styles,
        ),
        PageBreak(),
        Paragraph("12. High-Value Files", styles["HandbookH1"]),
        *code_lines(
            [
                "itinerary-builder/index.html",
                "itinerary-result/index.html",
                "share-your-story/index.html",
                "stories/index.html",
                "js/InsightEngine.js",
                "data/insights/index.json",
                "data/insights/destinations/arunachal-pradesh/dibang-valley.json",
                "data/insights/destinations/arunachal-pradesh/west-kameng.json",
                ".github/scripts/generate-story.js",
                ".github/workflows/generate-story.yml",
                ".github/workflows/deploy.yml",
                "roadmap/itinerary_builder_failure_checklist.md",
            ],
            styles,
        ),
        Paragraph("13. Closing Note", styles["HandbookH1"]),
        paragraph(
            "This handbook documents the architecture present in the repository today. It intentionally separates checked-in code from external runtime assumptions. The website repo currently contains the local verified knowledge base and frontend orchestration; the live itinerary generation and story-processing worker remain external services that the frontend integrates with through explicit request/response contracts.",
            styles,
        ),
    ]
    return story


def main():
    doc = SimpleDocTemplate(
        str(OUTPUT),
        pagesize=A4,
        rightMargin=16 * mm,
        leftMargin=16 * mm,
        topMargin=14 * mm,
        bottomMargin=14 * mm,
        title="Incitetales Architecture Handbook",
        author="Codex",
    )
    doc.build(build_story(), onFirstPage=add_page_num, onLaterPages=add_page_num)
    print(OUTPUT)


if __name__ == "__main__":
    main()

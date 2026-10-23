# GEMMA website – agent instructions

Instructions for AI coding agents (Claude Code, GitHub Copilot, etc.) working on
this repository. `CLAUDE.md` and `.github/copilot-instructions.md` both point here,
so keep this file as the single source of truth.

## Project overview

This is the public website for the **GEMMA** (Greenhouse gas Measurement and
Modelling Advancement) project, funded by UKRI under the Building a Green Future
programme (April 2023 – March 2027). It is built with **Quarto** and deployed to GitHub Pages.

**Purpose:** showcase what GEMMA has achieved over the project, to attract the
attention of future funders.

The primary audience is **policymakers, funders, and the interested public**.
The secondary audience is the scientific community (reached via links to papers).
Every page should be readable by a non-specialist. Explain acronyms on first use.
Never assume the reader has a science background. Lead with outcomes and what
they make possible; keep method detail brief.

See the [README](README.md) for build commands and project structure.

## Content tone and voice

- Write in **plain English**. Active verbs, short sentences, no unexplained jargon.
  Instrument brand names and technical acronyms (e.g. Picarro, GC-MS) belong in
  the body, not in key points or descriptions.
- Refer to the project in the third person: "GEMMA has shown…", not "We have shown…"
  (the established "What we found" heading in highlights is the one exception).
- Always translate a scientific finding into a **policy implication** — "this matters
  because…" framing.
- Use UK English spelling (realise, modelling, programme, colour).
- Greenhouse gas names: spell out in full on first use, then abbreviate
  (e.g. "methane (CH₄)"). Use the subscript/superscript characters (₄, ₂, ₆, etc.),
  not plain ASCII.
- Dates are displayed UK-style ("24 June 2026"); this is set site-wide in
  `_quarto.yml`.

## Avoid machine-sounding prose

Text on this site should read as if a scientist wrote it carefully for a
policy reader. Readers, funders especially, quickly notice generic
AI-generated prose, and it undermines credibility. Write like the existing
highlights, which are plain and specific.

**Be specific rather than impressive.** Every sentence should carry a fact: a
number, a place, a gas, a date, an organisation. If a sentence would still be true
of any research project, cut it or replace it with something concrete.

- Weak: "This groundbreaking work represents a significant step forward in
  emissions monitoring."
- Better: "Simulations show the ten GEMINI-UK instruments could cut uncertainty in
  UK methane emission estimates by up to 75% in summer."

**Words and phrases to avoid** (use the plain alternative or drop them):

| Avoid | Prefer |
|---|---|
| delve, dive into, explore (as filler) | look at, examine, or just state the finding |
| crucial, vital, pivotal, critical (as emphasis) | important, or say *why* it matters |
| leverage, harness, utilise | use |
| robust (unless describing a statistical property) | reliable, or be specific |
| groundbreaking, cutting-edge, state-of-the-art, world-class, unprecedented | describe what is new, plainly |
| landscape, realm, ecosystem, tapestry, journey | omit |
| seamless, holistic, comprehensive, transformative, game-changer | omit or be specific |
| plays a key role in, serves as, stands as | is, does |
| underscores, highlights the importance of, sheds light on | shows |
| it is worth noting that, importantly, notably, crucially | omit; just say it |
| not only… but also | and |
| in today's rapidly changing world, in an era of… | omit |
| paving the way, unlocking the potential, a testament to | say what it enables |

**Structural habits to avoid:**

- **The "rule of three"** used as rhythm: "accurate, timely, and credible". A
  list is fine when there really are three items, but don't pad to three.
- **Contrast for drama:** "It's not just X — it's Y." / "This isn't about X; it's
  about Y." State Y.
- **Em dashes everywhere.** One per paragraph at most; use commas, brackets, or a
  full stop.
- **Summary sentences** at the end of paragraphs or sections that restate what was
  just said ("Overall, this demonstrates…", "In summary…"). End on the last new
  fact.
- **Signposting:** "Let's take a look at…", "In this section we…". Use headings
  instead.
- **Hedge stacking:** "could potentially help to possibly improve". One hedge,
  placed where the uncertainty really is.
- **Bold everywhere.** Bold only the few words a skimming reader must see; the
  key points box already does the heavy lifting.
- **Bullets for continuous reasoning.** Use bullets for genuinely separate items;
  write cause-and-effect as sentences.
- **Inflated significance.** Don't claim a result "transforms" or "revolutionises"
  anything. Let the numbers make the case. Funders trust understatement backed
  by evidence.

**Before finishing any prose edit**, reread it against this list and check that
every claim is supported by the source material (paper, author draft, or existing
page). Do not add claims, figures, or policy implications that the source does not
support.

## Key terminology (use these consistently)

| Term | Notes |
|---|---|
| greenhouse gas inventory | not "emissions register" or "carbon ledger" |
| atmospheric inversion / inverse modelling | not "back-calculation" |
| DECC network | Deriving Emissions linked to Climate Change — spell out on first use |
| AGAGE | Advanced Global Atmospheric Gases Experiment — spell out on first use |
| InTEM | Inversion Technique for Emissions Modelling (Met Office) — spell out on first use |
| GEMINI-UK | Greenhouse gas Emission Monitoring network to Inform Net-zero Initiatives for the UK |
| traceable measurements | preferred over "calibrated" in policy contexts |
| devolved administrations | when referring to England/Scotland/Wales/NI individually |
| Paris Agreement | capital A; the Global Stocktake is a proper noun |

Partner names (exact):
- **National Physical Laboratory (NPL)** — project lead
- **University of Bristol**
- **Met Office**
- **University of East Anglia (UEA)**
- **University of Manchester**
- **National Centre for Atmospheric Science (NCAS)**
- **National Centre for Earth Observation (NCEO)**
- **University of Edinburgh**
- **University of Leicester**

## Architecture

```
_quarto.yml              # site config, render list, navbar, footer, OG, theme
custom.scss              # all custom styles — Sass variables then rules
robots.txt               # currently blocks all crawlers (soft launch)
index.qmd                # home page (hero, feature split, stats bar, recent highlights, partners)
about.qmd                # project background, objectives, consortium, funding
team.qmd                 # PI and researcher profiles
outputs/index.qmd        # publications, datasets, software, policy documents
research-highlights/
  _metadata.yml          # shared HTML + Typst format settings for all highlights
  typst-template.typ     # branding/layout of the one-page PDF policy brief
  index.qmd              # listing page (auto-generated from *.qmd) + author template comment
  <slug>.qmd             # one file per research highlight
  figures/               # highlight figures, named <slug>-fig<n>.png
assets/                  # site-wide images: logos/, photos/, home page images
.github/workflows/publish.yml   # renders and deploys to GitHub Pages on push to main
```

Quarto renders each research highlight to **both HTML and a Typst-derived PDF**
simultaneously. `quarto preview` only renders HTML; `quarto render` produces both.
New top-level page globs must be added to `project.render` in `_quarto.yml`.

## Adding a research highlight

The authoritative template is the comment block in
`research-highlights/index.qmd`; any existing highlight is a worked example.
Each highlight must fit a **one-page A4 PDF**: roughly 550 words of body text plus
one figure.

Frontmatter:

```yaml
---
title: "Short, plain-English title"
date: YYYY-MM-DD
author:
  - name: "Full Name"
    affiliation: "Organisation"
    email: "optional@example.ac.uk"
categories:
  - methane            # controlled vocabulary only — see below
  - inverse modelling
image: /research-highlights/figures/<slug>-fig1.png   # shown on listing cards
description: >
  Two- or three-sentence summary for listing cards and social sharing.
  Plain English. State what was done and why it matters.
---
```

Categories use a **controlled vocabulary** (lowercase, spaces allowed — they
appear as filter chips on the listing page):
- gas: `methane` · `carbon dioxide` · `nitrous oxide` · `halocarbons` · `hydrogen`
- theme: `measurement network` · `inverse modelling` · `emissions by sector`

Body, in this order:

1. **Key points** — 3–4 bullets; the takeaways for a reader who reads nothing else.
   ```markdown
   ::: {.key-points}
   **Key points**

   - …
   :::
   ```
2. **PDF download bar** (HTML only; update the filename):
   ```markdown
   ::: {.content-visible when-format="html"}
   ::: {.pdf-download-bar}
   **Download this page as a PDF policy brief:**
   [Download PDF](<slug>.pdf){.btn .btn-sm .btn-primary}
   :::
   :::
   ```
3. **Metadata block** (optional — use for related publications or links):
   ```markdown
   ::: {.highlight-meta}
   **Related publication:** [Title (Author et al., YYYY, *Journal*)](https://doi.org/…)
   :::
   ```
4. Sections:
   - `## Why this matters` — the policy problem *before* the work. Context only:
     no results, no limitations.
   - `## What GEMMA did` — one short paragraph of method (infrastructure
     highlights may use `## What was installed` and fold findings into it).
   - `## What we found` — the findings, with the figure.
   - `## What this means for policy` — what is different now the work is done.
   - `## What comes next` — planned follow-on work.

### Figures

- Put highlight figures in `research-highlights/figures/<slug>-fig<n>.png`;
  site-wide images go in `assets/`.
- Always include `fig-alt` alt text.
- **Landscape figures:** a normal Markdown image with an absolute path works in
  both HTML and PDF:
  `![Caption.](/research-highlights/figures/<slug>-fig1.png){fig-alt="…"}`
- **Tall/portrait figures:** show the Markdown image in HTML only, and add a raw
  Typst block that floats the figure within its PDF column (relative path), so the
  brief stays on one page. Copy the pattern from `decc-network-expansion.qmd`.

## SCSS conventions

All styles live in `custom.scss`. **Do not add new classes** without first checking
whether an existing one covers the need. Key classes and their uses:

| Class | Used on |
|---|---|
| `.hero-banner` | Home page full-width hero div |
| `.feature-split` | Home page text + image split section |
| `.stats-bar` / `.stat-item` | Home page statistics strip |
| `.section-header` | On home page `##` headings — styles the wrapping `<section>` as a full-width band with centred title |
| `.section-tinted` | Add alongside `.section-header` for a grey band |
| `.partner-logos` / `.partner-logo` | Flex row of partner logo links (keep each `<a>` on one line) |
| `.key-points` | Key points box at top of each research highlight |
| `.highlight-meta` | Metadata block on research highlights |
| `.pdf-download-bar` | Download call-to-action on research highlights |
| `.team-entry` / `.team-photo` / `.team-bio` | Team page profiles |

SCSS variables (defined at top of `custom.scss`):
`$primary: #1b5e8c` · `$headings-color: #1b3a5c` · `$light: #f8f9fa` · `$secondary: #6c757d`

PDF brief styling is separate, in `research-highlights/typst-template.typ`.

## Quarto-specific rules

- Internal links: always use `.qmd` paths, never `.html`
  (e.g. `[About](about.qmd)`, not `[About](about.html)`).
- To show content only in HTML (not in the PDF policy brief):
  ```markdown
  ::: {.content-visible when-format="html"}
  …
  :::
  ```
- Do not add executable code blocks — no page runs R, Python, or Julia.
- Do not use Quarto footnotes in research highlights; they do not render
  well in the Typst PDF output. Use inline parenthetical references instead.

## Build and deploy

```bash
quarto preview          # live-reload HTML only (fast, for editing)
quarto render           # full build: HTML + PDF for all highlights
```

Deployment is automatic: `.github/workflows/publish.yml` renders the site and
deploys it to GitHub Pages on every push to `main`. Do not manually edit files
under `_site/` — it is the build output directory.

The site is in soft launch: `robots.txt` disallows all crawlers and
`_quarto.yml` adds a `noindex, nofollow` meta tag. Remove both when the site goes
public.

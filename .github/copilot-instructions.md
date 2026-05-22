# GEMMA website – Copilot instructions

## Project overview

This is the public website for the **GEMMA** (Greenhouse gas Measurement and
Modelling Advancement) project, funded by UKRI under the Building a Green Future
programme. It is built with **Quarto** and deployed to GitHub Pages.

The primary audience is **policymakers, funders, and the interested public**.
The secondary audience is the scientific community (reached via links to papers).
Every page should be readable by a non-specialist. Explain acronyms on first use.
Never assume the reader has a science background.

See the [README](../README.md) for build commands and project structure.

## Content tone and voice

- Write in **plain English**. Active verbs, short sentences, no unexplained jargon.
- Refer to the project in the third person: "GEMMA has shown…", not "We have shown…"
- Always translate a scientific finding into a **policy implication** — "this matters
  because…" framing.
- Use UK English spelling (realise, modelling, programme, colour).
- Greenhouse gas names: spell out in full on first use, then abbreviate
  (e.g. "methane (CH₄)"). Use the subscript/superscript characters (₄, ₂, ₆, etc.),
  not plain ASCII.

## Key terminology (use these consistently)

| Term | Notes |
|---|---|
| greenhouse gas inventory | not "emissions register" or "carbon ledger" |
| atmospheric inversion / inverse modelling | not "back-calculation" |
| DECC network | Deriving Emissions linked to Climate Change — spell out on first use |
| AGAGE | Advanced Global Atmospheric Gases Experiment — spell out on first use |
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

## Architecture

```
_quarto.yml              # site config, navbar, footer, OG, theme
custom.scss              # all custom styles — Sass variables then rules
index.qmd                # home page (hero, stats bar, listing of recent highlights)
about.qmd                # project background, objectives, consortium, funding
team.qmd                 # PI and researcher profiles
news/index.qmd           # chronological news items (hand-edited for now)
outputs/index.qmd        # publications, datasets, software, policy documents
research-highlights/
  _metadata.yml          # shared HTML + Typst format settings for all highlights
  index.qmd              # listing page (auto-generated from *.qmd)
  <slug>.qmd             # one file per research highlight
assets/                  # images, logos (no subdirectory nesting needed for now)
```

Quarto renders each research highlight to **both HTML and a Typst-derived PDF**
simultaneously. `quarto preview` only renders HTML; `quarto render` produces both.

## Adding a research highlight

Use this frontmatter template exactly — all fields are required:

```yaml
---
title: "Short, plain-English title (≤ 12 words)"
date: YYYY-MM-DD
author:
  - name: "Full Name"
    affiliation: "Organisation"
categories:
  - one or more lowercase tags
image: /assets/<slug>-fig1.png        # 16:9 or wider; shown on listing cards
description: >
  Two-sentence summary for listing cards and social sharing. Plain English.
  State what was done and why it matters.
---
```

Every highlight page must contain these blocks in order:

1. **PDF download bar** (verbatim, update filename):
   ```markdown
   ::: {.pdf-download-bar}
   **Download this page as a PDF policy brief:**
   [Download PDF](<slug>.pdf){.btn .btn-sm .btn-primary}
   :::
   ```

2. **Metadata block**:
   ```markdown
   ::: {.highlight-meta}
   **Authors:** … \
   **Published:** DD Month YYYY \
   **Related publication:** [Title](https://doi.org/…)
   :::
   ```

3. **Body sections** (use these headings — adapt wording as needed):
   - `## Why this matters` — policy context, no assumed science background
   - `## What GEMMA did` (or "What was installed", "What was found", etc.)
   - `## Scientific and policy impact`
   - `## What comes next`

Figures: always include `fig-alt` for accessibility. Place figures in `assets/`
named `<slug>-fig<n>.png`. Use absolute paths (`/assets/…`) so they resolve in
both HTML and Typst output.

## SCSS conventions

All styles live in `custom.scss`. **Do not add new classes** without first checking
whether an existing one covers the need. Key classes and their uses:

| Class | Used on |
|---|---|
| `.hero-banner` | Home page full-width hero div |
| `.stats-bar` / `.stat-item` | Home page statistics strip |
| `.section-block` | Content section wrapper (add `.section-tinted` for grey bg) |
| `.section-header` | Applied directly to `##` headings that need centred primary-colour styling |
| `.partner-logos` | Flex container for partner logo images |
| `.highlight-meta` | Metadata block at top of each research highlight |
| `.pdf-download-bar` | Download call-to-action at top of each research highlight |

SCSS variables (defined at top of `custom.scss`):  
`$primary: #1b5e8c` · `$headings-color: #1b3a5c` · `$light: #f8f9fa` · `$secondary: #6c757d`

## Quarto-specific rules

- Internal links: always use `.qmd` paths, never `.html`
  (e.g. `[About](about.qmd)`, not `[About](about.html)`).
- To show content only in HTML (not in the PDF policy brief):
  ```markdown
  ::: {.content-visible when-format="html"}
  …
  :::
  ```
- All images on highlight pages must have `fig-alt` alt text.
- Do not add executable code blocks — no page runs R, Python, or Julia.
- Do not use Quarto footnotes in research highlights; they do not render
  well in the Typst PDF output. Use inline parenthetical references instead.
- Category tags on highlights are lowercase, hyphenated, no spaces
  (e.g. `network expansion` → `network-expansion`). They appear as filter
  chips on the listings page.

## Build and deploy

```bash
quarto preview          # live-reload HTML only (fast, for editing)
quarto render           # full build: HTML + PDF for all highlights
```

Deployment is via GitHub Actions to GitHub Pages (config to be added).
Do not manually edit files under `_site/` — it is the build output directory.

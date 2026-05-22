# GEMMA project website

Source for the GEMMA (Greenhouse gas Measurement and Modelling Advancement)
project website, built with [Quarto](https://quarto.org) and deployed to
GitHub Pages.

---

## Contents

- [Prerequisites](#prerequisites)
- [Local development](#local-development)
- [Project structure](#project-structure)
- [Adding a research highlight](#adding-a-research-highlight)
- [Adding figures](#adding-figures)
- [Deploying to GitHub Pages](#deploying-to-github-pages)
- [Customising the theme](#customising-the-theme)

---

## Prerequisites

You need one thing: **Quarto**.

1. Download the installer for your operating system from
   <https://quarto.org/docs/get-started/>.
   Install the latest stable release (≥ 1.5).

2. Verify the installation:
   ```
   quarto check
   ```
   You should see a list of green ticks. Typst (used for PDF rendering) is
   bundled with Quarto — no separate installation is required.

You do **not** need R, Python, or any other language runtime to work on this
site, because none of the pages execute code — they are pure prose and figures.
If you later add pages with executable code blocks you will need the relevant
runtime installed.

---

## Local development

### Clone the repository

```bash
git clone https://github.com/YOUR-ORG/gemma-website.git
cd gemma-website
```

### Start a live preview

```bash
quarto preview
```

This opens the site in your browser at `http://localhost:XXXX`. The page
reloads automatically whenever you save changes to any `.qmd` or `.scss` file.
Press `Ctrl+C` in the terminal to stop the server.

### Full render (optional)

To render the complete site to the `_site/` folder without starting a server:

```bash
quarto render
```

The output goes to `_site/`. This folder is in `.gitignore` and should not be
committed — the GitHub Action renders the site during deployment.

### Render a single file

Useful when editing a specific research highlight:

```bash
quarto render research-highlights/decc-network-expansion.qmd
```

This produces both the HTML page and a PDF (via Typst) in the same directory.
Open `_site/research-highlights/decc-network-expansion.html` in your browser to check it.

---

## Project structure

```
gemma-website/
│
├── _quarto.yml                    Site-wide configuration (navigation, theme, etc.)
├── custom.scss                    Custom CSS/SCSS overrides
│
├── index.qmd                      Home page
├── about.qmd                      About the project
├── team.qmd                       Team and partners
│
├── research-highlights/
│   ├── index.qmd                  Gallery listing all highlights
│   ├── _metadata.yml              Shared format settings (HTML + PDF)
│   ├── decc-network-expansion.qmd Example highlight
│   └── figures/                   Figures used by highlights in this directory
│       └── hfc-trend-thumbnail.png
│
├── outputs/
│   └── index.qmd                  Publications, datasets, software
│
├── news/
│   └── index.qmd                  Project news
│
├── assets/
│   └── logos/                     Partner logos (PNG, SVG)
│
└── .github/
    └── workflows/
        └── publish.yml            GitHub Actions deployment workflow
```

---

## Adding a research highlight

Research highlights are the main scientific content of the site. Each one is a
single Markdown file in `research-highlights/`. The file produces both an HTML
web page and a downloadable PDF policy brief from the same source.

### Step 1 — copy the template

```bash
cp research-highlights/decc-network-expansion.qmd research-highlights/my-new-highlight.qmd
```

Use a short, descriptive filename with hyphens and no spaces, for example
`urban-co2-london.qmd` or `methane-north-sea.qmd`.

### Step 2 — edit the frontmatter

At the top of the file, between the `---` lines, update the metadata fields:

```yaml
---
title: "Your title here (sentence case, not title case)"
date: 2025-06-01          # publication date; controls sort order on the gallery
author:
  - name: "Your Name"
    affiliation: "Your Institution"
  - name: "Co-author Name"
    affiliation: "Their Institution"
categories:               # used for filtering on the gallery page
  - methane
  - UK emissions
image: figures/your-thumbnail.png   # shown on the gallery card (approx 600×400 px)
description: >
  One or two sentences summarising the finding. This appears on the gallery card
  and in search engine previews. Write it for a general audience.
---
```

### Step 3 — write the content

Write the body of the page in Markdown below the second `---`. A suggested
structure (used in the template) is:

- **Background** — what is the scientific and policy context?
- **What we did** — brief, accessible methods summary
- **Key findings** — what did you find? Lead with the headline result.
- **Policy implications** — what should decision-makers take from this?
- **Methods and uncertainties** — more technical detail for interested readers
- **Further reading** — links to papers and other resources

Use plain language. Assume your reader knows what climate change is but has no
specialist atmospheric science background.

### Step 4 — update the PDF download link

Near the top of the file (just below the frontmatter), update the PDF filename
in the download button to match your new file:

```markdown
::: {.pdf-download-bar}
**Download this page as a PDF policy brief:**
[Download PDF](my-new-highlight.pdf){.btn .btn-sm .btn-primary}
:::
```

The PDF is generated automatically with the same base name as the `.qmd` file.

### Step 5 — add your figures

Place figure files in `research-highlights/figures/`. See
[Adding figures](#adding-figures) below.

### Step 6 — preview and commit

```bash
quarto preview
```

Check the new page looks correct, then commit and push:

```bash
git add research-highlights/my-new-highlight.qmd research-highlights/figures/
git commit -m "Add research highlight: brief description"
git push
```

The site will update automatically within a few minutes.

---

## Adding figures

Place figure files in `research-highlights/figures/` (for research highlights)
or `assets/` (for site-wide images such as logos).

Include a figure in a `.qmd` file using Markdown image syntax:

```markdown
![Caption text for the figure.](figures/my-figure.png){fig-alt="Alt text describing the figure for screen readers."}
```

**Gallery thumbnail** (`image:` in frontmatter): aim for approximately 600 × 400 px,
landscape orientation. JPEG or PNG. This image is shown on the gallery listing card.

**Figures within the page**: any reasonable size; Quarto will scale them. For
publication-quality figures, use vector formats (SVG or PDF) where possible — these
render sharply in both the HTML page and the PDF policy brief.

---

## Deploying to GitHub Pages

### First-time setup

These steps only need to be done once per repository.

1. **Push the repository to GitHub** (if not done already):
   ```bash
   git remote add origin https://github.com/YOUR-ORG/gemma-website.git
   git branch -M main
   git push -u origin main
   ```

2. **Enable GitHub Pages** in the repository settings:
   - Go to **Settings → Pages**.
   - Under *Build and deployment*, set the source to **GitHub Actions**.

3. **Check the Actions tab** after pushing. The workflow
   `.github/workflows/publish.yml` will run automatically. On first run it
   creates a `gh-pages` branch containing the rendered site.

4. Once the workflow completes, your site will be live at:
   ```
   https://YOUR-ORG.github.io/gemma-website/
   ```
   (or a custom domain if configured — see GitHub Pages documentation).

### Ongoing deployment

Every push to the `main` branch triggers the workflow automatically.
The typical time from push to live site is 2–4 minutes.

You can also trigger a deployment manually from
**Actions → Render and publish to GitHub Pages → Run workflow**.

### Setting a custom domain

1. Purchase or configure a domain (e.g. `gemma-project.ac.uk`).
2. Add a `CNAME` file to the repository root containing just the domain name:
   ```
   gemma-project.ac.uk
   ```
3. In **Settings → Pages**, enter the custom domain. GitHub will handle the
   HTTPS certificate automatically.

---

## Customising the theme

Site-wide colours and layout are controlled by two files:

- `_quarto.yml` — navigation structure, footer text, site title, search settings
- `custom.scss` — colours, typography, card styles, hero section

The site uses the Quarto `flatly` Bootstrap theme as a base. The primary colour
is defined by the `$primary` variable near the top of `custom.scss`. Change this
to adjust the navbar colour, buttons, and heading accents throughout the site.

For larger layout changes, refer to the
[Quarto website documentation](https://quarto.org/docs/websites/) and the
[Bootstrap utilities reference](https://getbootstrap.com/docs/5.3/utilities/).

// ─────────────────────────────────────────────────────────────────────────────
// GEMMA research-highlight policy brief — custom Quarto Typst template.
//
// Branded, compact layout designed to fit a single A4 page for briefs that stay
// within the content budget documented in research-highlights/index.qmd
// (roughly ≤550 words of body text plus one figure).
//
// This overrides only the `article` function; Quarto's default typst-show.typ
// still supplies all the named arguments below. Compaction levers live here
// (heading sizes, paragraph spacing, figure handling) alongside fontsize / margin
// / columns set in research-highlights/_metadata.yml.
// ─────────────────────────────────────────────────────────────────────────────

#let content-to-string(content) = {
  if content == none {
    ""
  } else if type(content) == str {
    content
  } else if content.has("text") {
    content.text
  } else if content.has("children") {
    content.children.map(content-to-string).join("")
  } else if content.has("body") {
    content-to-string(content.body)
  } else {
    ""
  }
}

#let gemma-primary = rgb("#1b5e8c")
#let gemma-dark = rgb("#1b3a5c")

#let article(
  title: none,
  subtitle: none,
  authors: none,
  keywords: (),
  date: none,
  abstract-title: none,
  abstract: none,
  thanks: none,
  cols: 1,
  lang: "en",
  region: "US",
  font: none,
  fontsize: 11pt,
  title-size: 1.45em,
  subtitle-size: 1.1em,
  heading-family: none,
  heading-weight: "bold",
  heading-style: "normal",
  heading-color: black,
  heading-line-height: 0.65em,
  mathfont: none,
  codefont: none,
  linestretch: 1,
  sectionnumbering: none,
  linkcolor: none,
  citecolor: none,
  filecolor: none,
  toc: false,
  toc_title: none,
  toc_depth: none,
  toc_indent: 1.5em,
  doc,
) = {
  set document(title: title, keywords: keywords)
  set document(
    author: authors.map(author => content-to-string(author.name)).join(", ", last: " & "),
  ) if authors != none and authors != ()

  // Compact base typography.
  set text(lang: lang, region: region, size: fontsize)
  set text(font: font) if font != none
  set par(justify: true, leading: 0.5em, spacing: 0.62em)
  show math.equation: set text(font: mathfont) if mathfont != none
  show raw: set text(font: codefont) if codefont != none

  // Tight, coloured headings.
  set heading(numbering: sectionnumbering)
  show heading: set text(fill: gemma-dark)
  show heading: set block(above: 0.85em, below: 0.45em)
  show heading.where(level: 1): set text(size: 1.12em)
  show heading.where(level: 2): set text(size: 1.0em)

  // Links in brand colour (metadata overrides still respected).
  show link: set text(fill: gemma-primary)
  show link: set text(fill: rgb(content-to-string(linkcolor))) if linkcolor != none
  show ref: set text(fill: rgb(content-to-string(citecolor))) if citecolor != none

  // Compact bullet lists.
  set list(spacing: 0.62em, indent: 0.4em)

  // Figures span both columns and float to a free slot, centred. Capped at 90%
  // width: full-bleed plots look heavy, and the height saved frees space in BOTH
  // columns. Tall portrait figures should instead be given an in-column
  // `when-format="typst"` variant in the .qmd (see decc-network-expansion).
  show figure: it => place(auto, float: true, scope: "parent", clearance: 1em,
    align(center, block(width: 90%, it)))
  show figure.caption: set text(size: 0.82em, fill: gemma-dark.lighten(15%))

  // Branded footer on every page.
  set page(footer: context {
    set text(size: 6.5pt, fill: gemma-dark)
    line(length: 100%, stroke: 0.5pt + gemma-primary.lighten(45%))
    v(-0.35em)
    grid(
      columns: (1fr, auto),
      align: (left + horizon, right + horizon),
      [GEMMA — Greenhouse gas Measurement and Modelling Advancement · gemma-uk.github.io · Funded by UKRI],
      counter(page).display(),
    )
  })

  // ── Title / brand header — spans full width above the columns ──────────────
  let has-title-block = title != none or (authors != none and authors != ()) or date != none
  if has-title-block {
    place(
      top,
      float: true,
      scope: "parent",
      clearance: 1.1em,
      block(width: 100%)[
        #grid(
          columns: (auto, 1fr),
          align: (left + horizon, right + horizon),
          image("/assets/gemma-logo-transparent.png", height: 2.1em),
          text(size: 0.82em, fill: gemma-primary, weight: "semibold", tracking: 0.08em)[RESEARCH HIGHLIGHT],
        )
        #v(-0.1em)
        #line(length: 100%, stroke: 1.75pt + gemma-primary)
        #v(0.5em)

        #if title != none {
          block(below: 0.4em)[
            #text(size: title-size, weight: "bold", fill: gemma-dark)[#title]
          ]
        }

        #if authors != none and authors != () {
          set text(size: 0.9em, fill: gemma-dark)

          // Unique affiliations, in order of first appearance.
          let affs = ()
          for a in authors {
            let s = content-to-string(a.affiliation).trim()
            if s != "" and not affs.contains(s) { affs.push(s) }
          }

          if affs.len() <= 1 {
            // One shared affiliation (or none): spell it out inline.
            let names = authors.map(a => [#a.name]).join(", ", last: " & ")
            [#names#if affs.len() == 1 [ (#emph(affs.at(0)))]#if date != none [ · #date]]
          } else {
            // Several affiliations: superscript markers keep long author lists to a
            // couple of lines instead of repeating institution names per author.
            let names = authors.map(a => {
              let s = content-to-string(a.affiliation).trim()
              let i = affs.position(x => x == s)
              if i == none { [#a.name] } else { [#a.name#super(str(i + 1))] }
            }).join(", ", last: " & ")
            [#names#if date != none [ · #date]]
            v(0.2em)
            text(size: 0.82em, style: "italic")[
              #affs.enumerate().map(pair => [#super(str(pair.at(0) + 1))#pair.at(1)]).join("  ")
            ]
          }
        } else if date != none {
          text(size: 0.9em, fill: gemma-dark)[#date]
        }
      ]
    )
  }

  doc
}

#set table(inset: 6pt, stroke: none)

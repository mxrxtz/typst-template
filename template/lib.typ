#let lmu-template(
  title: "Titel der Arbeit",
  subtitle: none,
  author: "Dein Name",
  date: datetime.today().display("[day].[month].[year]"),
  university: "Ludwig-Maximilians-Universität München",
  faculty: "Fakultät für Physik",
  institute: "Lehrstuhl für ...",
  advisor: none,
  abstract: none,
  kind: "standard", // "standard" oder "labreport"
  body
) = {
  // --- Globale Dokumenteigenschaften ---
  set document(title: title, author: author)
  set text(font: "Arial", size: 10pt, lang: "de")
  
  set page(
    paper: "a4",
    margin: (left: 3cm, right: 3cm, top: 2cm, bottom: 2cm),
    fill: white,
  )

  // --- Deckblatt & Titelseite (LaTeX Style) ---
  if kind == "labreport" {
    // Option: Offizielles Deckblatt-PDF einbinden (falls vorhanden)
    // page(header: none, footer: none, margin: 0pt)[#image("figures/Deckblatt-P1-web.pdf", width: 100%)]

    page(header: none, footer: none)[
      #set align(center)
      #v(1cm)
      // \large \sf \workUniversity
      #text(size: 12pt, font: "Arial")[#university] \
      #v(0.2cm)
      // \bf \workInstitute
      #text(size: 12pt, weight: "bold")[#institute]
      
      #v(4cm)
      // \workTitle
      #text(size: 18pt, weight: "bold")[#title]
      
      #v(2cm)
      // \large Bericht / Auswertung
      #text(size: 12pt)[Bericht / Auswertung]
      
      #v(4cm)
      // \author{\workAuthor}
      #text(size: 12pt)[#author]
      
      #v(1cm)
      // \date{\workDate}
      #text(size: 12pt)[#date]
      
      #v(1fr)
    ]
  } else {
    // Standard LaTeX \maketitle Style
    page(header: none, footer: none)[
      #set align(center)
      #v(3cm)
      #text(size: 22pt, weight: "bold")[#title]
      #if subtitle != none {
        v(0.5cm)
        text(size: 16pt)[#subtitle]
      }
      
      #v(3cm)
      #text(size: 14pt)[#author]
      
      #v(1cm)
      #text(size: 12pt)[#date]
      
      #v(4cm)
      #text(size: 12pt)[#university] \
      #text(size: 11pt)[#faculty] \
      #text(size: 11pt)[#institute]
      
      #if advisor != none {
        v(2cm)
        text(size: 11pt)[Betreuer: #advisor]
      }
      
      #v(1fr)
    ]
  }

  // --- Frontmatter (Römisch) ---
  set page(
    numbering: "I",
    header: context {
      set text(8pt)
      grid(
        columns: (1fr, 1fr),
        align(left, title),
        align(right, counter(page).display("I"))
      )
      v(-0.5em)
      line(length: 100%, stroke: 0.4pt)
    }
  )
  counter(page).update(1)

  if abstract != none {
    heading(level: 1, numbering: none)[Abstract]
    abstract
    pagebreak()
  }

  outline(indent: auto)
  pagebreak()

  // --- Hauptteil (Arabisch) ---
  set page(
    numbering: "1",
    header: context {
      set text(8pt)
      grid(
        columns: (1fr, 1fr),
        align(left, title),
        align(right, counter(page).display("1"))
      )
      v(-0.5em)
      line(length: 100%, stroke: 0.4pt)
    }
  )
  counter(page).update(1)

  set heading(numbering: "1.1")
  set par(justify: true, leading: 0.65em)
  
  show figure.where(kind: image): set figure(supplement: [Abb.])
  show figure.where(kind: table): set figure(supplement: [Tab.])
  set math.equation(numbering: "(1)")

  body
}

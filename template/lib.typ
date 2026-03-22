#let lmu-template(
  title: "Titel der Arbeit",
  subtitle: none,
  author: "Dein Name",
  date: datetime.today().display("[day].[month].[year]"),
  faculty: "Fakultät für Physik",
  institute: "Lehrstuhl für ...",
  advisor: none,
  abstract: none,
  body
) = {
  // --- Globale Dokumenteigenschaften (Basis: LaTeX 10pt) ---
  set document(title: title, author: author)
  set text(font: "Arial", size: 10pt, lang: "de")
  
  // LaTeX geometry: left=3cm, right=3cm, top=2cm
  set page(
    paper: "a4",
    margin: (left: 3cm, right: 3cm, top: 2cm, bottom: 2cm),
    fill: white,
  )

  // --- Titelseite (Keine Nummerierung) ---
  page(header: none, footer: none)[
    #align(center)[
      #v(2cm)
      #text(14pt, weight: "bold")[Ludwig-Maximilians-Universität München] \
      #text(12pt)[#faculty] \
      #text(11pt)[#institute]
      
      #v(4cm)
      #text(24pt, weight: "bold")[#title]
      #if subtitle != none {
        v(0.5cm)
        text(18pt)[#subtitle]
      }
      
      #v(4cm)
      #grid(
        columns: (1fr, 1fr),
        gutter: 1em,
        align(right, [Autor:]), align(left, author),
        align(right, [Datum:]), align(left, date),
        ..if advisor != none { (align(right, [Betreuer:]), align(left, advisor)) }
      )
      
      #v(1fr)
      #box(stroke: 1pt, inset: 10pt)[LMU MÜNCHEN]
    ]
  ]

  // --- Frontmatter (Römische Seitenzahlen: I, II, III...) ---
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
      line(length: 100%, stroke: 0.4pt) // LaTeX headrulewidth 0.4pt
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

  // --- Hauptteil (Arabische Seitenzahlen: 1, 2, 3...) ---
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

  // --- Formatierung für den Inhalt ---
  set heading(numbering: "1.1")
  set par(justify: true, leading: 0.65em)
  
  // Abbildungen und Tabellen (LaTeX: Abb. / Tab.)
  show figure.where(kind: image): set figure(supplement: [Abb.])
  show figure.where(kind: table): set figure(supplement: [Tab.])
  set math.equation(numbering: "(1)")

  body
}

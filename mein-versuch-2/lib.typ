#let lmu-template(
  title: "Titel der Arbeit",
  subtitle: none,
  author: "Dein Name",
  date: datetime.today().display(identifier: "[day].[month].[year]"),
  faculty: "Fakultät für Physik",
  institute: "Lehrstuhl für ...",
  advisor: none,
  body
) = {
  set document(title: title, author: author)
  set page(
    paper: "a4",
    margin: (x: 2.5cm, y: 3cm),
    header: context {
      if counter(page).get().first() > 1 {
        set text(8pt, style: "italic")
        grid(
          columns: (1fr, 1fr),
          align(left, title),
          align(right, author)
        )
        v(-0.5em)
        line(length: 100%, stroke: 0.5pt)
      }
    },
    footer: context {
      let page-num = counter(page).get().first()
      align(center, text(10pt, str(page-num)))
    },
  )

  set text(font: "Linux Libertine", size: 11pt, lang: "de")
  set par(justify: true)

  // Title Page
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
      #box(stroke: 1pt, inset: 10pt)[LMU MÜNCHEN] // Platzhalter für Logo
    ]
  ]

  outline(indent: auto)
  pagebreak()

  set heading(numbering: "1.1")
  show figure.where(kind: image): set figure(supplement: [Abb.])
  set math.equation(numbering: "(1)")

  body
}

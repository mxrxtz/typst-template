#let lmu-template(
  title: "Titel der Arbeit",
  subtitle: none,
  author: "Dein Name",
  date: datetime.today().display(),
  faculty: "Fakultät für Physik",
  institute: "Lehrstuhl für ...",
  advisor: none,
  keywords: (),
  abstract: none,
  body
) = {
  // Set the document's metadata.
  set document(title: title, author: author, keywords: keywords)

  // Set the page properties.
  set page(
    paper: "a4",
    margin: (x: 3cm, y: 3cm),
    header: locate(loc => {
      if counter(page).at(loc).first() > 1 {
        set text(size: 9pt, style: "italic")
        grid(
          columns: (1fr, 1fr),
          align(left, title),
          align(right, author)
        )
        v(-0.5em)
        line(length: 100%, stroke: 0.5pt)
      }
    }),
    footer: locate(loc => {
      let page-num = counter(page).at(loc).first()
      align(center, text(size: 10pt, str(page-num)))
    }),
  )

  // Configure text properties.
  set text(font: "Linux Libertine", size: 11pt, lang: "de")
  set par(justify: true, leading: 0.65em)

  // Title Page
  page(header: none, footer: none)[
    #align(center)[
      #v(2cm)
      #text(size: 14pt, weight: "bold")[Ludwig-Maximilians-Universität München] \
      #text(size: 12pt)[#faculty] \
      #text(size: 11pt)[#institute]
      
      #v(4cm)
      #text(size: 24pt, weight: "bold")[#title]
      #if subtitle != none [
        #v(0.5cm)
        #text(size: 18pt)[#subtitle]
      ]
      
      #v(4cm)
      #grid(
        columns: (1fr, 1fr),
        align(right, "Autor:"),
        align(left, " " + author),
        align(right, "Datum:"),
        align(left, " " + date),
        ..if advisor != none {
          (align(right, "Betreuer:"), align(left, " " + advisor))
        }
      )
      
      #v(1fr)
      #image.decode("<svg width='100' height='100' viewBox='0 0 100 100' xmlns='http://www.w3.org/2000/svg'><rect width='100' height='100' fill='none' stroke='black' stroke-width='2'/><text x='50' y='55' font-family='Arial' font-size='12' text-anchor='middle'>LMU LOGO</text></svg>", width: 4cm)
    ]
  ]

  // Table of Contents
  outline(indent: auto)
  pagebreak()

  // Abstract
  if abstract != none {
    heading(level: 1, numbering: none)[Abstract]
    abstract
    pagebreak()
  }

  // Main body
  set heading(numbering: "1.1")
  
  // Figure and Table numbering
  show figure: set block(breakable: true)
  show figure.where(kind: image): set figure(supplement: [Abb.])
  show figure.where(kind: table): set figure(supplement: [Tab.])
  
  // Math numbering
  set math.equation(numbering: "(1)")
  
  body
}

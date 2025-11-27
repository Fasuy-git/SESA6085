//Import all libraries from template file
#import "template.typ": *

// LaTex-ify the Typst
#set page(margin: 1in)
#set text(font: "New Computer Modern")

// Need to show word count for total word func
#show: word-count

// Large centered title
#v(9cm)

#align()[
  #text(28pt)[#strong[SESA6085]] \

  #text(15pt)[Advanced Aerospace Engineering Management - Coursework]
]

#v(1fr)

#line(length: 100%)


#align(left)[
  Author: Yusaf Sultan \
  Student ID: 32750552  \
  Lecturer: Dr David Toal \
  Word Count: #total-words  \
  #v(2cm)
]

#pagebreak()  // start new page after title page

#set page(
  header: [
    SESA 6085 - Coursework
    #h(1fr)
    Yusaf Sultan - 32750552
    #v(-0.3cm)
    #line(length: 100%)
  ],
  footer: context [
    #align(center)[
      #box(height: 14pt)[#v(0.35cm) #line(length: 43%)]
      #h(0.569cm)
      #counter(page).display("1")
      #h(0.569cm)
      #box(height: 14pt)[#v(0.35cm) #line(length: 43%)]
    ]
  ],
)

// LaTex-ify the Typst
#set text(hyphenate: true)
#set par(
  spacing: 0.65em,
)

#set math.mat(delim: "[")
#set math.vec(delim: "[")

#show heading: set block(below: 1.2em)
#set par(spacing: 1.5em)

// Contents Page
#align(left)[


  #outline()

  #v(1cm)

  #outline(
    title: [List of Figures],
    target: figure.where(kind: figure),
  )

  #v(1cm)

  #outline(
    title: [List of Tables],
    target: figure.where(kind: table),
  )

  #pagebreak()

]<contents>

#show: equate.with(breakable: true, sub-numbering: true)
#set math.equation(numbering: "(1.1)", supplement: [Eq.])
#set heading(numbering: (n1, ..x) => numbering("1.a", calc.max(0, n1 - 1), ..x))
#set math.mat(delim: "[")
#set math.vec(delim: "[")

#show figure: set block(breakable: true)

#include "coursework.typ"

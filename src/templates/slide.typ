#let slide(
  title: none,
  page_break: false,
  date: none,
  author: none,
  event: none,
  format: "presentation-4-3",
  bg_color: "fff",
  bg_image: none,
  header_image: none,
  doc: none,
) = {
  set page(
    paper: format,
    fill: rgb(bg_color), // overriden by bg_image, if present.
    background: bg_image,
    margin: (x: 5%, top: 20%, bottom: 15%),
    header: [
      #grid(
        columns: (1fr, 1fr),
        if page_break { none } else {
          align(horizon + left)[
            #set text(20pt, fill: rgb("fff"))
            #smallcaps(title)
          ]
        },
        align(horizon + right, header_image)
      )
    ],
    footer: [
      #set text(8pt, fill: rgb("fff"))
      \@ #date #author #h(1fr) #event) #text(14pt)[*| #counter(page).display("1")*]
    ],
    header-ascent: 50%,
    footer-descent: 42%,
  )

  set text(
    size: 12pt,
    fill: rgb("aaa"),
    font: "Times New Roman"
  )

  show heading: it => [
    #set align(top + left)
    #set text(fill: rgb("fff"))
    #block(it.body)
  ]

  if page_break {
    align(center + horizon, text(42pt, fill: rgb("fff"), title))
    doc = none
  }

  doc
}

#let presentation = (
  date: "2023",
  author: "Andrei N. Onea",
  event: "PIMS PRESENTATION",
  format: "presentation-16-9",
  bg_image: image(
    "static/steam-audio-landing-background3_150pct_cropped.png",
    width: 100%,
    height: 100%,
    fit: "cover",
  ),
  header_image: image(
    "static/steam-audio-logo.png",
    width: 30%,
    height: 50%,
    fit: "contain",
  ),
)

#let slide(
  format: none,
  page_break: false,
  title: none,
  bg_color: "fff",
  bg_image: none,
  header_image: none,
  doc,
) = {
  if format == none { format = presentation.format }
  if bg_image == none { bg_image = presentation.bg_image }
  if header_image == none { header_image = presentation.header_image }
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
      \@ #presentation.date #presentation.author #h(1fr) #presentation.event #text(14pt)[*| #counter(page).display("1")*]
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


/*
#import "slide.typ"
#show: doc => slide(
  page_break: false,
  title: [Introduction],
  bg_color: "012345",
  doc,
)
*/


#slide(
  page_break: true,
  title: [Welcome!],
  none
)

#show: doc => slide(
  title: [Introduction],
  bg_color: "012345",
  doc,
)

= Introduction 2

Some text it works very fine. But just how fine? Ok, very fine.

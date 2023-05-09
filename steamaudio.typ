#import "atatheme.typ": *
#import "presentation.typ": slide


// Construct theme using 'atatheme' as base.
#let theme = atatheme

#theme.insert("br",
  atatheme_br.with(fill: rgb("fff"))
)

#theme.insert("header",
  atatheme_header.with(
    fill: rgb("fff"),
    image: image(
      "static/steam-audio-logo.png",
      width: 30%,
      height: 50%,
      fit: "contain",
    ),
  )
)

#theme.insert("footer",
  atatheme_footer.with(fill: rgb("fff"))
)

#theme.insert("rest",
  atatheme_rest.with(fill: rgb("aaa"))
)

#show heading: it => [
  #set align(top + left)
  //#set text(fill: rgb("fff"))
  #block(it.body)
]

#let slide = slide.with(
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
  margin: (x: 5%, top: 20%, bottom: 15%),
  padding: (header: 50%, footer: 42%),
  numbers: (outof: true),
  theme: theme,
)

#slide(title: "Steam Audio", br: true)
#slide(title: "Ce este audierea binauriculară?", br: true)
#let slide = slide.with(title: "Ce este audierea binauriculară?")
#slide(body: [
= Nimic.

Da, Nimic.

== Chiar nimic?

Da..

=== Chiar nimic?

Da..
])

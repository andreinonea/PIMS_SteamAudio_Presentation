#let atatheme_br(body, ..extras) = {
  let extras = extras.named()
  if body == [] {} else {}

  set text(
    size: if "size" in extras { extras.size } else { 42pt },
    fill: if "fill" in extras { extras.fill } else { rgb("000") },
    font: if "font" in extras { extras.font } else { "Times New Roman" },
  )

  align(
    if "align" in extras { extras.align } else { center + horizon },
    body
  )
}

#let atatheme_header(body, ..extras) = {
  let extras = extras.named()

  set text(
    size: if "size" in extras { extras.size } else { 20pt },
    fill: if "fill" in extras { extras.fill } else { rgb("000") },
    font: if "font" in extras { extras.font } else { "Times New Roman" },
  )

  if body == [] [
    #grid(
      columns: (1fr, 1fr),
      if extras.br { none } else {
        align(horizon + left)[
          #smallcaps(extras.title)
        ]
      },
      //align(horizon + right, extra.image)
    )
  ] else [
    #body
  ]
}

#let atatheme_footer(body, ..extras) = {
  let extras = extras.named()

  set text(
    size: if "size" in extras { extras.size } else { 8pt },
    fill: if "fill" in extras { extras.fill } else { rgb("000") },
    font: if "font" in extras { extras.font } else { "Times New Roman" },
  )

  if body == [] [
    \@ #extras.date #extras.author #h(1fr) #extras.event #text(14pt)[*| #counter(page).display("1 / 1", both: true)*]
  ] else [
    #body
  ]
}

#let atatheme_rest(body, ..extras) = {
  let extras = extras.named()
  if body == [] {} else {}

  set text(
    size: if "size" in extras { extras.size } else { 12pt },
    fill: if "fill" in extras { extras.fill } else { rgb("aaa") },
    font: if "font" in extras { extras.font } else { "Times New Roman" },
  )

  body
}

#let atatheme_extras = (
  br: (:),
  header: (:),
  footer: (:),
  rest: (:),
)

#let atatheme = (
  br: atatheme_br,
  header: atatheme_header,
  footer: atatheme_footer,
  rest: atatheme_rest,
  extras: atatheme_extras
)


/*  Main slide function to create slides. */
#let slide(
  /*  Slide title.

      If `br` is `true`, appears enlarged and centered, and
                         is overriden by `body`, if present.
      If `br` is `false`, appears in the header, top-left.
  */
  title: "Welcome to ATA!",

  /*  Slide header `content`.

      Themes may build a header function based on the readily available data,
      such as `author`, `date`, `event` etc. Setting `header` here will override it.
  */
  header: [],

  /*  Slide footer `content`.

      Themes may build a footer function based on the readily available data,
      such as `author`, `date`, `event` etc. Setting `footer` here will override it.
  */
  footer: [],

  /*  Turn this slide into a page break for a transition to a new section in the presentation.
  */
  br: false,

  /*  Slide author.
  */
  author: none,

  /*  Presentation date.
  */
  date: none,

  /*  Presentation event.
  */
  event: none,

  /*  Slide format.

      Commonly, it is either "presentation-4-3" or "presentation-16-9".
  */
  format: "presentation-4-3",

  /*  Fills the background with this `color`.

      Ignored when `bg_image` is set.
  */
  bg_color: rgb("fff"),

  /*  Paints the background with this `image`.

      Overrides `bg_color`.
  */
  bg_image: none,

  /*  Margins of the slide.

      Must be type `dict` documented at:
      https://typst.app/docs/reference/layout/page/#parameters--margin
      Default: 0%.
  */
  margin: (:),

  /*  Paddings of the header and footer.

      Must be type `dict` with the following keys: `header`, `footer`.
      Values must be `relative length`: https://typst.app/docs/reference/types/relative-length
      Default: 30%.
  */
  padding: (header: 30%, footer: 30%),

  /*  Controls display of slide numbers.

      If `numbers.format` is a valid numbering scheme, then numbering is enabled.
      If `numbers.both` is `true`, the total number of slides will also be shown.
      More details at: https://typst.app/docs/reference/layout/page/#parameters--footer
  */
  numbers: (format: "", both: false),

  //-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

  theme: atatheme,

  /*  Content of the slide.

      If `br` is `true` and `body` is not empty, `title` is ignored.
      Any text customizations made in `body` overwrite those in `br` when used as dict,
      except for `align` - this should always be set using `br: (align: ...)`.
  */
  body: []
) = {
  /*  Make some necessary verifications for custom parameters. */
  if type(padding) != "dictionary" {
    panic("`numbers` must be dictionary: found " + type(numbers))
  } else {
    if "header" in padding and type(padding.header) not in ("ratio", "length", "relative length") {
      panic("`padding.header` must be a relative length: found " + type(padding.header))
    }
    if "footer" in padding and type(padding.footer) not in ("ratio", "length", "relative length") {
      panic("`padding.footer` must be a relative length: found " + type(padding.footer))
    }
  }
  if type(numbers) != "dictionary" {
    panic("`numbers` must be a dictionary: found " + type(numbers))
  }

  /*  Ensure each slide sits on its own page, leaving no empty pages. */
  pagebreak(weak: true)

  /*  Collect default extras to be joined with function specific ones later. */
  let default_extras = (
    title: title,
    author: author,
    date: date,
    event: event,
    br: br,
  )

  /*  Set page options. */
  set page(
    paper: format,
    fill: bg_color,
    background: bg_image,
    margin: margin,
    header: theme.at("header")(header, ..default_extras + theme.extras.at("header")),
    footer: theme.at("footer")(footer, ..default_extras + theme.extras.at("footer")),
    header-ascent: if "header" in padding { padding.header } else { 0% },
    footer-descent: if "footer" in padding { padding.footer } else { 0% },
  )

  /*  Paint slide. */
  let brush = "rest"

  /*  If we are on a break slide */
  if br {
    /*  If `body` is missing, use `title` instead. */
    if body == [] { body = if title == none [] else { title } }

    /*  Select correct brush. */
    brush = "br"
  }

  theme.at(brush)(body, ..default_extras + theme.extras.at(brush))
  return
}

//-=-=-=-==--=-=-=-=-==-=-=-=-=-=--==-=-=-=-=-=--


#let slide = slide.with(
  date: "2023",
  author: "Andrei N. Onea",
  event: "PIMS PRESENTATION",
  format: "presentation-16-9",
  // bg_image: image(
  //   "static/steam-audio-landing-background3_150pct_cropped.png",
  //   width: 100%,
  //   height: 100%,
  //   fit: "cover",
  // ),
  // header_image: image(
  //   "static/steam-audio-logo.png",
  //   width: 30%,
  //   height: 50%,
  //   fit: "contain",
  // ),
  margin: (x: 5%, top: 20%, bottom: 15%),
  padding: (header: 50%, footer: 42%),
  numbers: (outof: true),
)


#slide(br: true)
#slide(title: none, br: true)
#slide(title: [Caca din titlu], br: true)
#slide(title: none, br: true, body: [Caca din body])
#slide(title: [Caca din titlu desi ambele], br: true, body: [Caca din body desi ambele])

#slide(title: [Hello \ Pipi], br: true, body: [
  #align(horizon)[
    #underline(text(size: 22pt, "Se schimba titlul"))

    #text(size: 20pt, fill: rgb("aac"), "sub titlu")
  ]
])
#slide(body: [1 music nver stops])

#let slide = slide.with(author: "caca")

#slide(title: "", body: [2 music nver stops])

#let slide = slide.with(author: "pipilica")

#slide(title: [], body: [4 music nver stops])


#slide(title: "A new chapter", bg_color: rgb("fed"), body: [
  Text goes here #counter(page).display()

  #let arr = ([1],[2],[3],[4],[5])


  #grid(
    columns: (1fr,) * (arr.len() - 1),
    column-gutter: 20em,
    row-gutter: 2em,
    ..arr
  )

  #type(0.3%)
  #type(3em)
  #type(0.3% + 3em)

  #type(atatheme)
  #type(atatheme.br)
  #atatheme.at("br")([text])

  #let func(..extras) = {
    let extras = extras.named()
    extras.a
  }
  #let func2 = func.with(a: true)
  #func2()

])

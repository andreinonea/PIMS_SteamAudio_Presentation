#import "atatheme.typ": atatheme

/*  Main slide function to create slides. */
#let slide(
  /*  Slide title.

      Setting `title` to `""` when `body` is also empty has the
      effect of pushing a blank slide.
  */
  title: none,

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
    panic("`padding` must be dictionary: found " + type(padding))
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
    header: theme.at("header")(header, ..default_extras),
    footer: theme.at("footer")(footer, ..default_extras),
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

  theme.at(brush)(body, ..default_extras)
  return
}

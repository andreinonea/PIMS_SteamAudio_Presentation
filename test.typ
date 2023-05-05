/*  Static presentation state variables. */
#let s_ptitle = state("presentation_title", "Welcome to ATA!")
#let s_pdate = state("presentation_date", none)
#let s_pauthor = state("presentation_author", none)
#let s_pformat = state("presentation_format", "presentation-4-3")

#let slide(
  /*  Slide title.

      If `br` is `true`, appears enlarged and centered.
                         is overriden by `body`, if present.
      If `br` is `false`, appears in the header, top-left.

      After a break slide, `title` is saved and re-used in non-break slides.
      This is why is recommended to use a `title` even when 
      filling a break slide with the contents of the `body`.
      You may override the saved `title` in a non-break slide
      by explicitly giving a new one.
  */
  title: none,

  /*  Insert as break slide to move to a new section in the presentation.

      `br` can also be a dict with any of the following options:
          align: center + horizon
          size: 42pt
          fill: rgb("000")
      When an option is present in the dict, it overwrites the default
      value above. Note that `br` being a dict is ecquivalent to `true`.
  */
  br: false,

  /*  Content of the slide.

      Must be present, even if left empty: [].
      If `br` is `true` and `body` is not empty, it overwrites `title`.
      Any text customizations made in `body` overwrite those in `br` when used as dict,
      except for `align` - this should always be set using `br: (align: ...)`.
  */
  body
) = {
  /*  Ensure each slide sits on its own page, leaving no empty pages. */
  pagebreak(weak: true)

  /*  Check that `br` is valid. */
  let brtype = type(br)
  if brtype not in ("boolean", "dictionary") {
    panic("`br` must be boolean or dictionary: found " + brtype + ".")
  }
  let br_is_dict = brtype == "dictionary"

  if br_is_dict or br {
    /*  Deconstruct `br` if given as dict. */
    let br_align = if br_is_dict and "align" in br { br.align } else { center + horizon }
    let br_size = if br_is_dict and "size" in br { br.size } else { 42pt }
    let br_fill = if br_is_dict and "fill" in br { br.fill } else { rgb("000") }

    /*  If `body` is missing, use `title` instead. */
    if body == [] {
      /*  In case the first slide title is `none`, use a placeholder static title.
          Be aware that, as a result, whenever `title == none and br == true`,
          the previous title will be used for break slides.
          This should not happen often, unless specifically desired.
      */
      body = if title == none { s_ptitle.display() } else { title }
    }

    /*  Paint break slide body. */
    align(br_align, text(size: br_size, fill: br_fill, body))

    /*  Save `title` for future slides, until a new break slide is met. */
    s_ptitle.update(title)
    return
  }
 
  /*  If `title` is missing, use saved `title`.
      If you want to avoid this behavior, but still keep the title saved,
      simply make `title` empty - `title: ""` or `title: []`. */
  if title == none { s_ptitle.display() } else { title }
  
  block(body)
  return
}

#slide(title: none, br: true)[]
#slide(title: [Caca], br: true)[]
#slide(title: none, br: true)[]
#slide(title: [Hello \ Pipi], br: (size: 80pt))[
  #align(horizon)[
    #underline(text(size: 22pt, "Se schimba titlul"))

    #text(size: 20pt, "sub titlu")
  ]
]
#slide(title: "Introduction", br: true)[]
#slide()[music nver stops]
#slide(title: "")[music nver stops]
#slide(title: [])[music nver stops]
#slide(title: "A new chapter")[Text goes here]

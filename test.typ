/*  Static presentation state variables. */
#let s_ptitle = state("presentation_title", "Welcome to ATA!")
#let s_pdate = state("presentation_date", none)
#let s_pauthor = state("presentation_author", none)
#let s_pevent = state("presentation_event", none)
#let s_pformat = state("presentation_format", "presentation-4-3")
#let s_pnumbers = state("presentation_numbers", false)
#let s_pnumbers_outof = state("presentation_numbers_outof", false)
#let s_pbg_color = state("presentation_bg_color", rgb("fff"))
#let s_pbg_image = state("presentation_bg_image", none)


/*  Set global configuration options for the presentation.

    You MUST call this method with `with`, e.g. `#presentation.with(date: ..., author ...)`.
    Otherwise, each call to presentation will add a new empty slide.
    Please go to `slide` definition below for details about these.
*/
#let presentation(
  date: none,
  author: none,
  event: none,
  format: none,
  bg_color: none,
  bg_image: none,
  header_image: none,
  numbers: none,
) = {
  // TODO: error handling?
  if date != none { s_pdate.update(date) }
  if author != none { s_pauthor.update(author) }
  if event != none { s_pevent.update(event) }
  if format != none { s_pformat.update(format) }
  if bg_color != none { s_pbg_color.update(bg_color) }
  if bg_image != none { s_pbg_image.update(bg_image) }
  if numbers != none {
    if type(numbers) not in ("boolean", "dictionary") {
      panic("`numbers` must be boolean or dictionary: found " + type(numbers))
    }
    if type(numbers) == "dictionary" {
      if "outof" in numbers { s_pnumbers_outof.update(numbers.outof) }
      s_pnumbers.update(true)
    } else {
      s_pnumbers.update(numbers)
    }
  }
}


/*  Main slide function to create slides. */
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

      `br` can also be a dict with any of the following overwritable options:
          align: center + horizon    sets where to place the title
          size: 42pt                 sets the size of the title
          fill: rgb("000")           sets the color of the title
      Note that `br` being a dict is equivalent to `true`.
  */
  br: false,

  // All parameters below can be set globally through `#presentation` function.
  // These have no defaults here, because they are set through the global state at the top.
  // The reason for this is to allow overwriting the defaults at any time during a `#slide`.
  // If you need to set a value for a longer time, you can make another call to `#presentation`
  // with just that value, and it will be kept until you change it again or overwrite it.

  /*  Slide author.
  */
  author: none,

  /*  Slide format.

      Commonly, it is either "presentation-4-3" or "presentation-16-9".
  */
  format: none,

  /*  Fills the background with this `color`.

      Ignored when `bg_image` is set.
  */
  bg_color: none,

  /*  Paints the background with this `image`.

      Overrides `bg_color`.
  */
  bg_image: none,

  /*  Display slide numbers.

      `numbers` is a boolean, but can also be a dict with the following overwritable option:
          outof: false    if `false`, uses "1,2,3" numbering
                          if `true`, uses "1/3,2/3,3/3" numbering
      Note that `numbers` being a dict is equivalent to `true`.
  */
  numbers: none,

  //-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

  /*  Content of the slide.

      Must be present, even if left empty: [].
      If `br` is `true` and `body` is not empty, it overwrites `title`.
      Any text customizations made in `body` overwrite those in `br` when used as dict,
      except for `align` - this should always be set using `br: (align: ...)`.
  */
  body
) = {
  /*  Make some necessary verifications. */
  if type(bg_color) not in ("color", "none") {
    panic("`bg_color` must be of type color: found " + type(bg_color))
  }
  if type(numbers) not in ("boolean", "dictionary", "none") {
    panic("`numbers` must be boolean or dictionary: found " + type(numbers))
  }
  if type(br) not in ("boolean", "dictionary") {
    panic("`br` must be boolean or dictionary: found " + type(br))
  }

  /*  Ensure each slide sits on its own page, leaving no empty pages. */
  pagebreak(weak: true)

  /*  Set page options. */
  set page(
    //paper: if format == none { repr(s_pformat.display()) } else { format },
    fill: bg_color,
    background: bg_image,
  )

  // TODO:
  locate(loc => {
    let numbers_active = s_pnumbers.at(loc)
    let numbers_outof = s_pnumbers_outof.at(loc)
    if numbers != none {
      let numbers_is_dict = type(numbers) == "dictionary"
      if numbers_is_dict {
        numbers_active = true
        numbers_outof = if "outof" in numbers { numbers.outof }
      } else {
        numbers_active = numbers
      }
    }
    if numbers_active {
      block()[
        #counter(page).display()
        #if numbers_outof { [\/ #counter(page).final(loc).first()] }
      ]
    }
  })

  /*  If we are on a break slide */
  if type(br) == "dictionary" or br {
    /*  Set default values */
    let br_align = center + horizon
    let br_size = 42pt
    let br_fill = rgb("000")

    /*  Deconstruct `br` if given as dict. */
    if type(br) == "dictionary" {
      if "align" in br { br_align = br.align }
      if "size" in br { br_size = br.size }
      if "fill" in br { br_fill = br.fill }
    }

    let doc = body
    /*  If `body` is missing, use `title` instead. */
    if body == [] {
      /*  In case the first slide title is `none`, use a placeholder static title.
          Be aware that, as a result, whenever `title == none and br == true`,
          the previous title will be used for break slides.
          This should not happen often, unless specifically desired.
      */
      doc = if title == none { s_ptitle.display() } else { title }
    }

    /*  Paint break slide body. */
    align(br_align, text(size: br_size, fill: br_fill, doc))

    /*  Save `title` for future slides, until a new break slide is met. */
    s_ptitle.update(title)

    return
  }
 
  /*  If `title` is missing, use saved `title`.
      If you want to avoid this behavior, but still keep the title saved,
      simply make `title` empty - `title: ""` or `title: []`. */
  if title == none { s_ptitle.display() } else { title }
  
  block(body)


  // DEBUG
  block(if author == none { s_pauthor.display() } else { author })

  return
}

//-=-=-=-==--=-=-=-=-==-=-=-=-=-=--==-=-=-=-=-=--


#presentation.with(
  date: "2023",
  author: "Andrei N. Onea",
  event: "PIMS PRESENTATION",
  format: "presentation-16-9",
  bg_color: rgb("012345"),
  numbers: (outof: true),
)


#slide(title: none, br: true)[]
#slide(title: [Caca], br: true)[]
#slide(title: none, br: true)[]
#slide(title: [Hello \ Pipi], br: (size: 80pt, fill: rgb("fae")))[
  #align(horizon)[
    #underline(text(size: 22pt, "Se schimba titlul"))

    #text(size: 20pt, fill: rgb("aac"), "sub titlu")
  ]
]
#slide(title: "Introduction", br: true)[]
#slide()[1 music nver stops]

#presentation.with(author: "caca")

#slide(title: "")[2 music nver stops]

#presentation.with(author: "pipilica")

#slide(title: [])[4 music nver stops]
#slide(title: "A new chapter", bg_color: rgb("fed"))[Text goes here #counter(page).display()]

#repr([presentation-4-3])


#let myfunc(a: none, b: none, c: false) = {
  repr(a)
  repr(b)
  repr(c)
}

#myfunc(a: "a")

#myfunc()

#let myfunc = myfunc.with(a: "a")

#myfunc(b: "b")
#myfunc(a: "A")
#myfunc(b: "b")

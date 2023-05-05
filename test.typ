/*  Static presentation state variables. */
#let s_ptitle = state("presentation_title", "Welcome to ATA!")
#let s_pdate = state("presentation_date", none)
#let s_pauthor = state("presentation_author", none)
#let s_pevent = state("presentation_event", none)
#let s_pformat = state("presentation_format", "presentation-4-3")
#let s_pnumbers = state("presentation_numbers", false)
#let s_pnumbers_outof = state("presentation_numbers_outof", false)


/*  Set global configuration options for the presentation.
    Please go to `slide` definition below for details about these.
*/
#let presentation(
  date: none,
  author: none,
  event: none,
  format: none,
  bg_image: none,
  header_image: none,
  numbers: none,
) = {
  if date != none { s_pdate.update(date) }
  if author != none { s_pauthor.update(author) }
  if event != none { s_pevent.update(event) }
  if format != none { s_pformat.update(format) }
  if numbers != none {
    let numberstype = type(numbers)
    if numberstype not in ("boolean", "dictionary") {
      panic("`numbers` must be boolean or dictionary: found " + numberstype + ".")
    }
    if numberstype == "dictionary" {
      if "outof" in numbers {
        s_pnumbers_outof.update(numbers.outof)
      }
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

  /*  Slide author.

      Can be set globally through `#presentation`.
  */
  author: none,

  /*  Insert as break slide to move to a new section in the presentation.

      `br` can also be a dict with any of the following overwritable options:
          align: center + horizon    sets where to place the title
          size: 42pt                 sets the size of the title
          fill: rgb("000")           sets the color of the title
      Note that `br` being a dict is equivalent to `true`.
  */
  br: false,

  /*  Display slide numbers.

      Can be set globally through '#presentation'.

      `numbers` is a boolean, but can also be a dict with the following overwritable option:
          outof: false    if `false`, uses "1,2,3" numbering
                          if `true`, uses "1/3,2/3,3/3" numbering
      Note that `numbers` being a dict is equivalent to `true`.
  */
  numbers: none,

  /*  Content of the slide.

      Must be present, even if left empty: [].
      If `br` is `true` and `body` is not empty, it overwrites `title`.
      Any text customizations made in `body` overwrite those in `br` when used as dict,
      except for `align` - this should always be set using `br: (align: ...)`.
  */
  body
) = {
  /*  Check that `numbers` is valid. */
  let numberstype = type(numbers)
  if numberstype not in ("boolean", "dictionary", "none") {
    panic("`numbers` must be boolean or dictionary: found " + numberstype + ".")
  }

  // TODO:
  locate(loc => {
    let numbers_active = s_pnumbers.at(loc)
    let numbers_outof = s_pnumbers_outof.at(loc)
    if numbers != none {
      let numbers_is_dict = numberstype == "dictionary"
      if numbers_is_dict {
        numbers_active = true
        numbers_outof = if "outof" in numbers { numbers.outof }
      } else {
        numbers_active = numbers
      }
    }
    if not numbers_active {
      return
    }
    block()[
      #counter(page).display()
      #if numbers_outof { [\/ #counter(page).final(loc).first()] }
    ]
  })

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

    /*  Ensure each slide sits on its own page, leaving no empty pages. */
    pagebreak(weak: true)
    return
  }
 
  /*  If `title` is missing, use saved `title`.
      If you want to avoid this behavior, but still keep the title saved,
      simply make `title` empty - `title: ""` or `title: []`. */
  if title == none { s_ptitle.display() } else { title }
  
  block(body)


  // DEBUG
  block(if author == none { s_pauthor.display() } else { author })

  /*  Ensure each slide sits on its own page, leaving no empty pages. */
  pagebreak(weak: true)
  return
}

//-=-=-=-==--=-=-=-=-==-=-=-=-=-=--==-=-=-=-=-=--


#presentation(
  date: "2023",
  author: "Andrei N. Onea",
  event: "PIMS PRESENTATION",
  format: "presentation-16-9",
  numbers: (outof: true),
)


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
#slide()[1 music nver stops]
#presentation(author: "caca")
#slide(title: "")[2 music nver stops]
#presentation(author: "pipilica")
#slide(title: [])[4 music nver stops]
#slide(title: "A new chapter")[Text goes here #counter(page).display()]

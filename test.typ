/*  Get the content to display for the slide numbers.
    Turn to the `numbers` parameter of `#slide` for detailed information.
*/
#let _get_page_numbering(numbers) = {
  locate(loc => {
    let numbers_active = numbers
    let numbers_outof = false
    let numbers_is_dict = type(numbers) == "dictionary"
    if type(numbers) == "dictionary" {
      numbers_active = true
      if "outof" in numbers { numbers_outof = numbers.outof }
    }
    if numbers_active {
      block()[
        #counter(page).display()
        #if numbers_outof { [\/ #counter(page).final(loc).first()] }
      ]
    }
  })
}


/*  Main slide function to create slides. */
#let slide(
  /*  Slide title.

      If `br` is `true`, appears enlarged and centered, and
                         is overriden by `body`, if present.
      If `br` is `false`, appears in the header, top-left.
  */
  title: "Welcome to ATA!",

  /*  Insert as break slide to move to a new section in the presentation.

      `br` can also be a dict with any of the following overwritable options:
          align: center + horizon    sets where to place the title
          size: 42pt                 sets the size of the title
          fill: rgb("000")           sets the color of the title
      Note that `br` being a dict is equivalent to `true`.
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

  /*  Display slide numbers.

      `numbers` is a boolean, but can also be a dict with the following overwritable option:
          outof: false    if `false`, uses "1,2,3" numbering
                          if `true`, uses "1/3,2/3,3/3" numbering
      Note that `numbers` being a dict is equivalent to `true`.
  */
  numbers: false,

  //-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

  /*  Content of the slide.

      Must be present, even if left empty: [].
      If `br` is `true` and `body` is not empty, `title` is ignored.
      Any text customizations made in `body` overwrite those in `br` when used as dict,
      except for `align` - this should always be set using `br: (align: ...)`.
  */
  body
) = {
  /*  Make some necessary verifications for custom parameters. */
  if type(numbers) not in ("boolean", "dictionary") {
    panic("`numbers` must be boolean or dictionary: found " + type(numbers))
  }
  if type(br) not in ("boolean", "dictionary") {
    panic("`br` must be boolean or dictionary: found " + type(br))
  }

  /*  Ensure each slide sits on its own page, leaving no empty pages. */
  pagebreak(weak: true)

  /*  Set page options. */
  set page(
    paper: format,
    fill: bg_color,
    background: bg_image,
  )

  _get_page_numbering(numbers)

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

    /*  If `body` is missing, use `title` instead. */
    if body == [] { body = title }

    /*  Paint break slide body. */
    align(br_align, text(size: br_size, fill: br_fill, body))
    return
  }
  
  block(body)
  block(date)
  block(author)
  block(event)

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
  numbers: (outof: true),
)


#slide(br: true)[]
#slide(title: none, br: true)[]
#slide(title: [Caca din titlu], br: true)[]
#slide(title: none, br: true)[Caca din body]
#slide(title: [Caca din titlu desi ambele], br: true)[Caca din body desi ambele]

#slide(title: [Hello \ Pipi], br: (size: 80pt, fill: rgb("fae")))[
  #align(horizon)[
    #underline(text(size: 22pt, "Se schimba titlul"))

    #text(size: 20pt, fill: rgb("aac"), "sub titlu")
  ]
]
#slide()[1 music nver stops]

#let slide = slide.with(author: "caca")

#slide(title: "")[2 music nver stops]

#let slide = slide.with(author: "pipilica")

#slide(title: [])[4 music nver stops]
#slide(title: "A new chapter", bg_color: rgb("fed"))[Text goes here #counter(page).display()]

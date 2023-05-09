#let atatheme_br(body, ..extras) = {
  let extras = extras.named()

  set text(
    size: if "size" in extras { extras.size } else { 42pt },
    fill: if "fill" in extras { extras.fill } else { rgb("000") },
    font: if "font" in extras { extras.font } else { "default" },
  )
  
  align(
    if "align" in extras { extras.align } else { center + horizon },
    if body == [] [Welcome to ATA!] else [#body]
  )
}

#let atatheme_header(body, ..extras) = {
  let extras = extras.named()

  set text(
    size: if "size" in extras { extras.size } else { 16pt },
    fill: if "fill" in extras { extras.fill } else { rgb("000") },
    font: if "font" in extras { extras.font } else { "default" },
  )

  // TODO: grid
  if body == [] [
    #grid(
      columns: (1fr, 1fr),
      if extras.br { none } else {
        align(horizon + left)[
          #smallcaps(extras.title)
        ]
      },
      align(horizon + right, extras.image)
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
    font: if "font" in extras { extras.font } else { "default" },
  )

  // TODO: numbers
  if body == [] [
    \@ #extras.date #extras.author #h(1fr) #extras.event #text(14pt)[*| #counter(page).display("1 / 1", both: true)*]
  ] else [
    #body
  ]
}

#let atatheme_rest(body, ..extras) = {
  let extras = extras.named()

  set text(
    size: if "size" in extras { extras.size } else { 14pt },
    fill: if "fill" in extras { extras.fill } else { rgb("000") },
    font: if "font" in extras { extras.font } else { "default" },
  )

  if body == [] [Welcome to ATA!] else [#body]
}

#let atatheme = (
  br: atatheme_br,
  header: atatheme_header,
  footer: atatheme_footer,
  rest: atatheme_rest,
)

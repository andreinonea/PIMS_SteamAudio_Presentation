// Use presentation layout for larger screens (suitable for screen sharing).
#set page(
  paper: "presentation-16-9",
)

// Enable dark mode
#set page(fill: rgb("012345"))
#set text(12pt, fill: rgb("aaa"), font: "Times New Roman")



// Heading customization
#show heading: it => [
  #set align(top + left)
  #set text(fill: rgb("fff"))
  #block(it.body)
]

// Page margins
#set page(margin: (
    x: 5%,
    top: 20%,
    bottom: 15%
  )
)

// Page numbering
#set page(numbering: "1")

// Page header and footer
#set page(
  header: [
    #grid(
      columns: (1fr, 1fr),
      align(horizon + left)[
        #set text(16pt, fill: rgb("fff"))
        #smallcaps("Introduction")
      ],
      align(horizon + right, image(
        "static/steam-audio-logo.png",
        width: 30%,
        height: 50%,
        fit: "contain",
      ))
    )
  ],
  footer: [
    #set text(8pt, fill: rgb("fff"))
    \@ 2023 Andrei N. Onea #h(1fr) PIMS PRESENTATION #text(14pt)[*| #counter(page).display()*]
  ],
  header-ascent: 50%,
  footer-descent: 42%,
) 

// Background image taken from SteamAudio
#set page(
  background: image(
    "static/steam-audio-landing-background3_150pct_cropped.png",
    width: 100%,
    height: 100%,
    fit: "cover",
  )
)

= Introduction 2

Some text it works very fine. But just how fine? Ok, very fine.

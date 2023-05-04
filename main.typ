// Use presentation layout for larger screens (suitable for screen sharing).
#set page(
  paper: "presentation-16-9",
)

// Enable dark mode
#set page(fill: rgb("012345"))
#set text(12pt, fill: rgb("aaa"))



// Heading customization
#show heading: it => [
  #set align(top + left)
  #set text(fill: rgb("fff"))
  #block(it.body)
]

// Page margins
#set page(margin: (
    x: 10%,
    y: 15%,
  )
)

// Page header and footer
#set page(
  header: [
    #set text(10pt, fill: rgb("fff"))
    Introduction #h(1fr) #pad(left: 80%, image(
        "static/steam-audio-logo.png",
        width: 100%,
        height: 60%,
        fit: "contain",
      ))
  ],
  footer: [
    #set text(10pt, fill: rgb("fff"))
    \@ 2023 Andrei N. Onea #h(1fr) PIMS PRESENTATION | 13
  ]
) 

// Background image taken from SteamAudio
/*#set page(
  background: image(
    "static/steam-audio-landing-background3_150pct_cropped.png",
    width: 100%,
    height: 100%,
    fit: "cover",
  )
)*/

= Introduction 2

Some text it works very fine. But just how fine? Ok, very fine.

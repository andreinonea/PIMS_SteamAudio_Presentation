#import "atatheme.typ": *
#import "presentation.typ": slide


#set document(title: "Vizualizarea volumetrică a atmosferei. VDVAC 2023", author: "Andrei N. Onea")
#set text(lang: "ro")
#show heading: body => {
  set text(weight: "medium")
  body
  v(0.8em)
}

// Construct theme using 'atatheme' as base.
#let theme = atatheme

#theme.insert("br",
  atatheme_br.with(
    fill: rgb("fff"),
    allow_empty: true,
  )
)

#theme.insert("header",
  atatheme_header.with(
    fill: rgb("fff"),
    size: 12pt,
    logo: text(size: 8pt, "Vizualizarea datelor volumetrice și animație pe calculator"),
  )
)

#theme.insert("footer",
  atatheme_footer.with(
    fill: rgb("fff"),
    numbers_fill: rgb("fff"),
  )
)

#theme.insert("rest",
  atatheme_rest.with(
    fill: rgb("fff"),
    size: 18pt,
    formatter: body => {
      set par(leading: 0.5em)
      show par: set block(spacing: 1.2em)
      set list(marker: ([➢], [•], [◦], [--]), spacing: 1.5em)

      body
    }
  )
)

// Start presentation
#let slide = slide.with(
  date: "2023",
  author: "Andrei N. Onea",
  format: "presentation-16-9",
  bg_color: rgb("000"),
  margin: (x: 5%, top: 20%, bottom: 15%),
  padding: (header: 50%, footer: 42%),
  numbers: (outof: true),
  theme: theme,
)

#show cite: super

/*
Buna ziua! Numele meu este Andrei si astazi va voi vorbi despreeeee
*/
#slide(br: true,
  bg_image: image(
    "static/01_first-off.png",
    width: 100%,
    height: 100%,
    fit: "cover",
  ),
)

/*
Vizualizarea volumetrica a atmosferei!
*/
#slide(title: [Vizualizarea volumetrică a atmosferei], br: true,
  bg_image: image(
    "static/01_first-on.png",
    width: 100%,
    height: 100%,
    fit: "cover",
  ),
)

/*
Pentru a ajunge sa imbogitam astfel o planeta, vom discuta urmatoarele etape
Setarea post-procesarii - vedem cum putem avea access, in shader, la toti pixelii de pe ecran si nu doar la fragmente
Generarea atmosferei - partea in care se defineste static atmosfera din jurul planetei
Calculul transmiterii luminii - imbunatatim versiunea precedenta prin calculul dinamic al luminii si al absorptiei sale pana la ochi; partea aceasta va fi cea mai stufoasa dar ne va da forma pe care o vedem si la planeta din dreapta

Dupa cum indica si separarea de catre sageata, pasii de mai sunt suficienti pentru a ne da forma finala a atmosferei.
totusi, pentru a realiza o imagine convingatoare, o sa discutam si despre

Puterea de imprastiere a lungimilor de unda ce explica fenome precum "de ce e cerul albastru", "apus" sau "rasarit"
Ca un mic bonus, vom vedea si cum putem adauga stele dinamice ce apar doar noaptea
Si, la final, vom prezenta o optimizare ce se poate aduce pasului de calcul al luminii. Sa incepem.
*/
#slide(
  title: "Introducere",
  bg_image: image(
      "static/02_cuprins.png",
    width: 100%,
    height: 100%,
    fit: "cover",
  ),
  body: [
#block(inset: (left: 5%))[= Cuprins]
#align(center)[
#block(inset: (top: -70%))[
#underline()[Setarea post-procesării]

Generarea atmosferei

Calculul transmiterii luminii
] // block
#block(inset: (top: 40%))[
Lungimi de undă: #text(fill: red, "c")#text(fill: orange, "u")#text(fill: yellow, "l")#text(fill: green, "o")#text(fill: blue, "r")#text(fill: rgb("5040FF"), "i")

Alte corpuri cerești: #text(fill: gray, "s") *t* #text(fill: gray, "e") *l* *e*

Optimizări
] // block
] // align
]) // body and slide


/*
Si vom incepe cu setarea 
*/
#slide(
  title: "Setarea post-procesării",
  bg_image: image(
      "static/03_framebuffers.png",
    width: 100%,
    height: 100%,
    fit: "cover",
  ),
  body: [
#block(inset: (left: 5%))[
= Framebuffers

- double-buffering
  - schimbările se fac pe un „backbuffer”
  - la final, se înlocuiește cu „frontbuffer”-ul
  - permite împrospătarea imaginii \ înainte de a apărea pe ecran

- double-buffering și off-screen buffer
  - schimbările se fac pe un nou buffer \ ce are ca output o textură
  - textura este aplicată peste un quad pe tot ecranul
  - permite post-procesarea texturii \ înainte de a fi scrisă în „backbuffer” #cite("framebuffers")
] // block
])

#slide(
  title: "Setarea post-procesării — Framebuffers",
  body: [
#block(inset: (left: 5%))[
- setarea este completă atunci când putem obține același rezultat al scenei, folosind textura generată

- având control asupra tuturor pixelilor, putem să
  - inversăm culorile
  - transformăm imaginea în grayscale
  - folosi diverse kernele pentru filtrare (ex. blur)
  - calcula densitatea atmosferei din perspectiva poziției curente a camerei
] // block
])

#slide(
  title: "Cuprins",
  bg_image: image(
      "static/02_cuprins.png",
    width: 100%,
    height: 100%,
    fit: "cover",
  ),
  body: [
#block(inset: (left: 5%))[= #text(fill: black, "Cuprins")]
#align(center)[
#block(inset: (top: -70%))[
Setarea post-procesării

#underline()[Generarea atmosferei]

Calculul transmiterii luminii
] // block
#block(inset: (top: 40%))[
Lungimi de undă: #text(fill: red, "c")#text(fill: orange, "u")#text(fill: yellow, "l")#text(fill: green, "o")#text(fill: blue, "r")#text(fill: rgb("5040FF"), "i")

Alte corpuri cerești: #text(fill: gray, "s") *t* #text(fill: gray, "e") *l* *e*

Optimizări
] // block
] // align
]) // body and slide

/*
Si vom incepe cu setarea 
*/
#slide(
  title: "Generarea atmosferei",
  bg_image: image(
      "static/04_raysphere.png",
    width: 100%,
    height: 100%,
    fit: "cover",
  ),
  body: [
#block(inset: (left: 5%))[
= Raycasting

- se calculează punctele de intersecție \
  ale razei $R_o + R_d * t$ cu sfera atmosferei

- densitatea acumulată a atmosferei întoarsă prin \
  pixelul văzut de cameră este calculată ca \
  $ (#text(fill: red)[$"far"$] - #text(fill: red)[$"near"$]) / (#text(fill: yellow)[$A_"radius"$] * 2) $ \
  adică, proporția distanței parcurse de rază \
  prin atmosferă față de diametrul acesteia
] // block
])

#slide(
  title: "Generarea atmosferei — Raycasting",
  bg_image: image(
      "static/04_rayresult.png",
    width: 100%,
    height: 100%,
    fit: "cover",
  ),
  body: [
#block(inset: (left: 5%))[
- densitatea acumulată de rază crește cu distanța parcursă prin atmosferă

- atmosferă înconjoară planeta și marimea ei poate fi configurată
  - absolut $ #text(fill: yellow)[$A_"radius"$] = x $
  - relativ $ #text(fill: yellow)[$A_"radius"$] = #text(fill: yellow)[$P_"radius"$] + "offset" $

- modelului îi lipsește, desigur, aportul soarelui #cite("seb")
] // block
])



#slide(title: none, body: [
#block(inset: (left: 5%))[
#bibliography("vdvac.bib", title: "Bibliografie")
] // block
])


#slide(
  br: true,
  title: "Vizualizarea volumetrică a atmosferei",
  body: "Mulțumesc pentru atenție!",
  bg_image: image(
    "static/final.png",
    width: 100%,
    height: 100%,
    fit: "cover",
  ),
)

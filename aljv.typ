#import "atatheme.typ": *
#import "presentation.typ": slide


#set document(title: "Inteligența artificială în jocurile Shadow Tactics. ALJV 2023", author: "Andrei N. Onea")
#set text(lang: "ro")
#show heading: body => {
  set text(weight: "medium")
  body
  v(0.8em)
}

// Construct theme using 'atatheme' as base.
#let theme = atatheme

#theme.insert("br",
  atatheme_br.with(fill: rgb("000"))
)

#theme.insert("header",
  atatheme_header.with(
    fill: rgb("000"),
    size: 12pt,
    logo: text(size: 8pt, "Algoritmi pentru logica jocurilor video"),
  )
)

#theme.insert("footer",
  atatheme_footer.with(fill: rgb("000"))
)

#theme.insert("rest",
  atatheme_rest.with(
    fill: rgb("000"),
    size: 18pt,
    formatter: body => {
      set par(leading: 0.5em)
      show par: set block(spacing: 1.2em)
      set list(marker: ([➢], [•], [◦], [--]), spacing: 1.5em)

      block(inset: (left: 5%))[#body]
    }
  )
)

// Start presentation
#let slide = slide.with(
  date: "2023",
  author: "Andrei N. Onea",
  format: "presentation-16-9",
  bg_image: image(
    "static/shadow-tactics-bg.jpg",
    width: 100%,
    height: 100%,
    fit: "cover",
  ),
  margin: (x: 5%, top: 20%, bottom: 15%),
  padding: (header: 50%, footer: 42%),
  numbers: (outof: true),
  theme: theme,
)

/*
Buna seara! Numele meu este Andrei si voi vorbi despre perceptia sunetului 3D in relatie cu Steam Audio
*/
// TODO: BUG. Applying any styling to title below ends up being applied to all text on br slide. Nasty.
#slide(title: [Inteligența artificială în jocurile \ Shadow Tactics], br: true)
//#slide(title: text(fill: rgb("08f"), [#text(spacing: 200%, [Inteligența artificială în jocurile \ Shadow Tactics])]), br: true)
//#slide(title: text([#text(spacing: 200%, [Inteligența artificială în jocurile \ Shadow Tactics])]), br: true)

#let slide = slide.with(
  title: "Inteligența artificială în jocurile Shadow Tactics",
  bg_image: image(
    "static/shadow-tactics-bg3.jpg",
    width: 100%,
    height: 100%,
    fit: "cover",
  ),
)

#slide(body: [
= Scurtă descriere

- serie de jocuri _stealth_ cu accent pe aplicarea de \ tactici co-operative în timp real

- jucătorul (_single-player_) poate comanda cei cinci agenți \ la dispoziția Shogunului în două feluri:
  - secvențial, luând controlul asupra unui personaj \ și executând acțiuni
  - concomitent, orchestrând o serie de acțiuni pe care, apoi, \ agenții le vor executa în paralel

- scopul este parcurgerea nivelelor și \ eliminarea/evitarea soldaților inamici, \ cărora le vom examina comportamentul în continuare
])

#slide(body: [
#grid(
  columns: (1fr, 1fr),
  [
    = Conul de vedere

    - agenții inamici pot detecta pericolele aflate în partea plină a conului, partea liniată fiind obstrucționată de diverse obstacole

    - zonele cu obstacole sunt zone sigure pentru jucător, atât timp cât se mișcă tactic, pe vine

    - agenții patrolează zona lor de influență neîncetat, iar micile momente de neatenție devin sanșele jucătorului de a se infiltra 
  ],
  [
    #image(
      "static/aljv-view-cone.png",
      width: 100%,
      height: 100%,
      fit: "contain",
    )
  ]
)
])

#slide(body: [
#grid(
  columns: (1fr, 1fr),
  [
    = Atenția la evenimentele

    - inamicii sunt receptivi și la sunetele făcute de mediu sau de jucător

    - în imagine, cercul albastru indică raza în care aliații gărzii pot auzi moartea acestuia, în urma aruncării _shurikenului_ de către jucător

    - deși garda de mai sus nu va auzi uciderea, totuși va detecta instantaneu moartea gărzii deoarece se afla în conul său de vedere
  ],
  [
    #image(
      "static/aljv-shuriken.png",
      width: 100%,
      height: 85%,
      fit: "contain",
    )
  ]
)
])

#slide(body: [
#grid(
  columns: (1fr, 1fr),
  [
    = Comunicarea

    - atunci când o gardă zărește o siluetă, conul se colorează în galben, arătând faptul că este conștientă de prezența acesteia, iar garda începe să inspecteze

    - odată ce se convinge de apartenența siluetei la tabăra inamică, comunică și fuge spre țintă

    - în urma uciderii gărzii, cea de sus alertează imediat alți soldați din apropiere

    - aceștia neutralizează cu ușurință jucătorul, deoarece nu a aplicat tactici prin învăluire
  ],
  [
    #align(center)[
    #image(
      "static/aljv-react.png",
      width: 100%,
      height: 90%,
      fit: "contain",
    )
    ]
  ]
)
])

#slide(body: [
#grid(
  columns: (1fr, 1fr),
  [
    = Distragerea gărzilor

    - inamicii pot fii ademeniți într-o zonă avantajoasă pentru jucător

    - în imagine, gărzile ce se afla în raza cercului albastru vor fii atrași de sunetul produs de jucător, urmând să investigheze sursa lui

    - cu cât se apropie mai mult, cu atât crește nivelul de alertă, îndicat, din nou, de culoarea galbenă
    
    - alte metode de distragere sunt aruncarea de pietre sau momeala cu o sticlă de _sake_
  ],
  [
    #align(center)[
      #image(
        "static/aljv-distract.png",
        width: 50%,
        height: 40%,
        fit: "stretch",
      )

      #image(
        "static/aljv-investigate.png",
        width: 50%,
        height: 50%,
        fit: "contain",
      )
    ]
  ]
)
])

#slide(
  br: true,
  title: "Mulțumesc pentru atenție!",
  bg_image: image(
    "static/shadow-tactics-bg.jpg",
    width: 100%,
    height: 100%,
    fit: "cover",
  ),
)

#import "atatheme.typ": *
#import "presentation.typ": slide


#set document(title: "Steam Audio. PIMS 2023", author: "Andrei N. Onea")
#set text(lang: "ro")

// Construct theme using 'atatheme' as base.
#let theme = atatheme

#theme.insert("br",
  atatheme_br.with(fill: rgb("fff"))
)

#theme.insert("header",
  atatheme_header.with(
    fill: rgb("fff"),
    image: image(
      "static/steam-audio-logo.png",
      width: 30%,
      height: 50%,
      fit: "contain",
    ),
  )
)

#theme.insert("footer",
  atatheme_footer.with(fill: rgb("aaa"))
)

#theme.insert("rest",
  atatheme_rest.with(
    fill: rgb("fff"),
    size: 22pt,
    formatter: body => {
      set par(leading: 0.6em)
      show par: set block(spacing: 1.2em)
      set list(marker: ([➢], [•], [◦], [--]), spacing: 1.5em)

      block(inset: (left: 5%))[#body]
    }
  )
)

#let slide = slide.with(
  date: "2023",
  author: "Andrei N. Onea",
  event: "PIMS PRESENTATION",
  format: "presentation-16-9",
  bg_image: image(
    "static/steam-audio-landing-background3_150pct_cropped.png",
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
#slide(title: "Steam Audio", br: true)

/*
Bun. Plecam din start de la ideea ca Steam Audio este "solutia".
*/
#slide(br: true, body: [
Steam Audio \ #text(size: 26pt)["Soluția"]
])

/*
Atunci, sa definim si sa anallizam care este "problema".
*/
#slide(br: true, body: [
\ #text(size: 26pt)["Problema"]
])

/*
Problema este spatializarea sunetului, cunoscuta si sub numele de...
*/
#slide(br: true, body: [
#text(size: 30pt)[Spațializarea sunetului, sau...] \ #text(size: 26pt)["Problema"]
])

/*
sunet tri-dimensional, sau in termeni populari...
*/
#slide(br: true, body: [
#text(size: 34pt)[Sunet 3D, sau...] \ #text(size: 26pt)["Problema"]
])

/*
Nu aud de unde vine inamicul!
*/
#slide(br: true, body: [
Nu aud de unde vine inamicul!\ #text(size: 26pt)["Problema"]
])

/*
Pentru a construi o imagine mai clara despre relatia problema-solutie, intram un pic in sfera audio si punctam ca exista mai multe formaturi de redare si inregistrare audio.

Pentru redare, ne amintim de mono si stereo.

Mono, adica ce se aude in casca stanga se aude si in casca dreapta, sau poate e de la inceput o singura casca sau un singur difuzor.

Stereo, adica continut diferit in fiecare casca sau difuzor.

Inca nu s-a inventat perechea de casti cu 5 difuzoare in jurul capului, asa ca aici vorbim doar de configuratii de difuzuare: 5 difuzoare si un subwoofer, 7 difuzoare si un subwoofer, 7 difuzoare, un subwoofer si alte 4 difuzoare in podea, 7 difuzoare, un subwoofer, alte 4 difuzoare in podea si inca 100 in jurul casei etc.

De obicei, aceste configuratii se numesc surround, si cu cat creste numarul de difuzoare, creste si perceptia tri-dimensionala a sunetului, desigur, atat timp cat continutul care iese prin difuzoare este adaptat.

De asemenea, diverse casti de gaming incearca sa sintetizeze un sunet surround virtual, dar rezultatul poate fi mai slab calitativ decat in modul stereo.

Formatul mono, in cazul inregistrarilor, inseamna folosirea unui singur microfon, fie ca e unidirectional, adica capteaza predominant dintr-o singura directie, sau omnidirectional, capteaza egal din toate directiile.

Daca e vorba de microfoane, atunci e clar ca stereo inseamna doua microfoane iar termenul multi-array denota folosirea a mai multor microfoane.
*/
#let slide = slide.with(title: "Analiza \"problemei\"")
#slide(body: [
Formaturi de

#grid(
  columns: (1fr, 1fr),
  [
    - redare audio
      - mono
      - stereo
      #block()[
        #v(-0.7em)
        #grid(
          columns: 3,
          column-gutter: (1.5em, 0.5em),
          [
            - 5.1
            - 7.1
            - 7.1.4 etc.
          ],
          line(length: 3em, stroke: 2pt + white, angle: 90deg),
          align(left + horizon, "surround"),
        )
      ]
      - virtual surround
  ],
  [
    - înregistrare audio
      - mono (monoauricular)
        - unidirecțional
        - omnidirecțional
      - stereo (binauricular)
      - multi-array (extraterestru)
  ]
)
])

/*
In regula. Si atunci, de ce nu auzim inamicul de unde vine?

Din cauza ca ascultam in format mono?

Atunci ori e ceva ciudat la noi, ori vorbim cu cineva si lasam o casca jos.
*/
#slide(body: [
Formaturi de

#grid(
  columns: (1fr, 1fr),
  [
    - redare audio
      - mono
      - #text(fill: rgb("888"))[stereo]
      #block()[
        #v(-0.7em)
        #grid(
          columns: 3,
          column-gutter: (1.5em, 0.5em),
          [
            - #text(fill: rgb("888"))[5.1]
            - #text(fill: rgb("888"))[7.1]
            - #text(fill: rgb("888"))[7.1.4 etc.]
          ],
          line(length: 3em, stroke: 2pt + rgb("888"), angle: 90deg),
          align(left + horizon, text(fill: rgb("888"), "surround")),
        )
      ]
      - #text(fill: rgb("888"))[virtual surround]
  ],
  [
      - #text(fill: rgb("888"))[înregistrare audio]
        - #text(fill: rgb("888"))[mono (monoauricular)]
          - #text(fill: rgb("888"))[unidirecțional]
          - #text(fill: rgb("888"))[omnidirecțional]
        - #text(fill: rgb("888"))[stereo (binauricular)]
        - #text(fill: rgb("888"))[multi-array (extraterestru)]
  ]
)

De ce nu auzim de unde vine inamicul?
])

/*
Din cauza ca avem redare stereo sau chiar mai complexa?

Omul are doua urechi si aude foarte bine. Nu e nici acest lucru.
*/
#slide(body: [
Formaturi de

#grid(
  columns: (1fr, 1fr),
  [
    - redare audio
      - #text(fill: rgb("888"))[mono]
      - stereo
      #block()[
        #v(-0.7em)
        #grid(
          columns: 3,
          column-gutter: (1.5em, 0.5em),
          [
            - 5.1
            - 7.1
            - 7.1.4 etc.
          ],
          line(length: 3em, stroke: 2pt + white, angle: 90deg),
          align(left + horizon, "surround"),
        )
      ]
      - virtual surround
  ],
  [
      - #text(fill: rgb("888"))[înregistrare audio]
        - #text(fill: rgb("888"))[mono (monoauricular)]
          - #text(fill: rgb("888"))[unidirecțional]
          - #text(fill: rgb("888"))[omnidirecțional]
        - #text(fill: rgb("888"))[stereo (binauricular)]
        - #text(fill: rgb("888"))[multi-array (extraterestru)]
  ]
)

De ce nu auzim de unde vine inamicul?
])

/*
Am ajuns corect la concluzia ca modul in care sunt inregistrate efectele sonore sunt principala problema, majoritatea fiind inregistrate mono.
*/
#slide(body: [
Formaturi de

#grid(
  columns: (1fr, 1fr),
  [
    - #text(fill: rgb("888"))[redare audio]
      - #text(fill: rgb("888"))[mono]
      - #text(fill: rgb("888"))[stereo]
      #block()[
        #v(-0.7em)
        #grid(
          columns: 3,
          column-gutter: (1.5em, 0.5em),
          [
            - #text(fill: rgb("888"))[5.1]
            - #text(fill: rgb("888"))[7.1]
            - #text(fill: rgb("888"))[7.1.4 etc.]
          ],
          line(length: 3em, stroke: 2pt + rgb("888"), angle: 90deg),
          align(left + horizon, text(fill: rgb("888"), "surround")),
        )
      ]
      - #text(fill: rgb("888"))[virtual surround]
  ],
  [
    - înregistrare audio
      - mono (monoauricular)
        - unidirecțional
        - omnidirecțional
      - stereo (binauricular)
      - multi-array (extraterestru)
  ]
)

De ce nu auzim de unde vine inamicul?
])

/*
Doar pentru ca un sunet e inregistrat in mono, inseamna neaparat ca si redarea e tot in mono?

Raspunsul e, poate dezamagitor, da.

Inregistrarea mono nu contine destule informatii pentru spatializarea sunetului, efectul fiind nulificat de faptul ca urechea stanga si urechea dreapta aud acelasi lucru.

In schimb, omul poate localiza cu aproximatie un sunet in spatiu, chiar si avand ochii inchisi. 

Acest lucru este posibil deoarece are doua urechi si fiecare proceseaza individual o sursa sonora, rezultand intr-un auz tri-dimensional, la fel cum o pereche de ochi rezulta intr-un vaz tri-dimensional.

In cazul ingregistarilor, dispunem de mai multe microfoane si putem capta si apoi reda piste diferite pe canale diferite. Melodiile incluse in Apple Spatial Audio sunt inregistrate astfel si se adapteaza la mediul de redare. Chiar si stereo, rezultatele sunt impresionante.

Pe cale digitala, totusi, putem modifica o inregistrare mono astfel incat sa dea impresia spatialitatii.

Artificial, un continut sonor poate fi copiat pe mai multe canale si apoi procesat astfel incat fiecare canal sa ofere o experienta putin diferita, cu scopul de a pacali urechile in a interpreta sunetul tri-dimensional.

Desi ajuta, exista o cale sintetica ce ofera rezultate mai bune, desi are si ea limitarea ei. Head related transfer functions
*/
#slide(body: [
- Înregistrarea mono
  - nu conține destule informații pentru spațializarea sunetului
  - este limitată în mod natural

- Sunetul tri-dimensional poate fi obținut
  - natural: omul, înregistrări binauriculare/multi-array (ex: Apple Spatial Audio)
  - artificial: post-procesare
  - sintetizat: #text(weight: "bold", "H")ead-#text(weight: "bold", "R")elated #text(weight: "bold", "T")ransfer #text(weight: "bold", "F")unctions

])

#let slide = slide.with(title: "HRTFs")
#slide(br: true)

/*
Citind in DEX, gasim ca binauricular inseamna care implica ambele urechi. Si, intr-adevar, termenul in sine, imprumutat din engleza, cu origine in limba latina, inseamna pur si simplu "doua urechi".

Fiecare ureche proceseaza diferit sunetul in functie de localizarea si propagarea acestuia pana la organ. Forma urechii, dimensiunea externa atat cat si cea interna precum si alte variabile fac ca fiecare om sa aiba o perceptie unica asupra sunetelor.

De aceea, in cadrul unei inregistrari binauriculare, este folosit cate un microfon pentru fiecare ureche, puse ori pe un om real, ori pe un manechin modelat 1:1 cu un om, care au rolul de a interpreta sunetul cat mai realist posibil.

Datele de la aceste inregistrari sunt folosite pentru construirea unui HRTF al persoanei testate.

HRTF este o functie ce filtreaza un semnal sonor, pe baza originii lui si a drumului lui prin mediu pana la fiecare ureche a unui auditor, pentru a simula un sunet 3D. Este foarte important de notat ca fiecare om are un HRTF ideal, si exista sansa ca sunetele redate de o aplicatie care foloseste un set HRTFs mai comune, sa nu aiba acelasi impact pentru anumite persoane cu caractersitici diferite.
*/
#slide(body: [
- Înregistrări binauriculare
  - binauricular = #text(size: 14pt, "(adj. (anat.) Care se referă la ambele urechi, care implică prezența ambelor urechi)")
  - două microfoane sunt amplasate înauntru urechilor unui om/manechin
  - răspunsul este un conținut audio cu două canale, asemenea celui receptat de sistemul auditiv uman

- HRTFs
  - funcție de transfer a unui semnal sonor de la sursă la receptor
  - modelează particularitățile unui individ și rolul lor în procesarea sunetului
  - având date precum poziția sursei și mediul înconjurător, aplică semnalului un filtru de spațializare
])

/*
In final, ne intoarcem la solutia propusa initial. Steam Audio.

Este o biblioteca, sau un SDK, in functie de utilizare, pentru procesare audio.

A fost creata de Valve, compania din spatele magazinului Steam sau a jocului Counter Strike.

Din pacate, nu este open source asa ca detaliile de implementare lipsesc din aceasta prezentare.

Este potrivita pentru jocuri 3D ce isi doresc o reprezentare cat mai realista a sunetelor.

Este deja integrata in engine-uri pentru Unreal sau Unity, dar ofera si un API in C pentru integrarea in aplicatii proprii.
*/
#slide(br: true, body: [
Steam Audio \ #text(size: 26pt)["Soluția"]
])

#let slide = slide.with(title: "Soluția")

#slide(body: [
- Steam Audio
  - bibliotecă software pentru spațializarea audio
  - creată de Valve
  - closed-source
  - țintește la acuratețe fizică, rămânând rapidă și eficientă
  - oferă integrări cu cele mai comune motoare de jocuri, în forma unui SDK
  - API în C pentru integrări cu aplicații proprii
])

/*
Steam Audio este o solutie ideala pentru jocuri deoarece procesarea se face complet in timp real.

biblioteca este optimizata astfel incat rezista la schimbari continue ale geometriei scenei.

Scopul ei este sa preia semnalul sonor si sa calculeze propagarea sunetului, luand in considerare si filtrarea printr-un HRTF.

Astfel, sunetele pasiilor inamicilor pot fi pozitionate destul de corect, precum si alte efecte sonore ce cresc imersivitatea jocului.
*/
#slide(body: [
- Soluția pe care o oferă
  - proceseaza semnale sonore în timp real, cărora le aplică HRTFs pentru a obține sunete tri-dimensionale în aplicații precum jocuri sau experiențe RA/RV
  - analizează geometria scenei și calculează cu acuratețe traiectoria semnalului prin mediu
  - ține cont de proprietățile fizice ale scenei pentru procesarea reflexiilor, reverberațiilor etc.
  - se actualizează dinamic, dacă, de exemplu, obiecte sunt mutate prin scenă
])

/*
In concluzie, am pus in ghilimele "problema" inca de la inceput deoarece nu este in esenta o problema, avand in vedere ca majoritatea continutului audio pe care il consumam este inregistrat in acest fel si este multumitor.

Dar pentru anumite categorii de consumatori, precum amatorii de jocuri video sau muzica ascultata la casti, acest lucru poate fi o limitare, o lipsa, pe care tehnicile ce folosesc HRTFs, precum Steam Audio, o pot elimina.
*/
#slide(br: true, body: [
Concluzie
])

/*
Multumesc pentru atentie! Daca aveti intrebari?
*/
#slide(title: "Mulțumesc pentru atenție!", br: true)

/*
Daca aveti intrebari?
*/
#slide(title: "Întrebări?", br: true)

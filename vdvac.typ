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
#set rect(stroke: white)

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

Puterea de imprastiere a lungimilor de unda care explica fenome precum "de ce e cerul albastru", "apus" sau "rasarit"
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
#rect[Setarea post-procesării]

Generarea atmosferei

Calculul transmiterii luminii
] // block
#block(inset: (top: 40%))[
Lungimi de undă: #text(fill: red, "c")#text(fill: orange, "u")#text(fill: yellow, "l")#text(fill: green, "o")#text(fill: blue, "r")#text(fill: rgb("5040FF"), "i")

Alte corpuri cerești: #text(fill: gray, "s") *t* #text(fill: gray, "e") *l* *e*

Optimi#text(fill: yellow, "z")ări
] // block
] // align
]) // body and slide


/*
Pentru a putea aplica efecte de post-procesare, trebuie sa iesim din modul implicit de randere si sa adoptam o solutie cu un buffer aditional

Framebufferul default are indicele 0. In cazul bibliotecii GLFW, acesta este initializat automat si putem, cu minimum de efort, sa desenam primul triunghi pe ecran.

OpenGL ne permite sa creem mai multe buffere si prin ele sa scriem in texturi.
O astfel de textura poate fi chiar rezultatul scenei.

Daca schimbam framebufferul curent intr-unul custom, scriem rezultatul desenarii intr-o textura,
apoi punem la loc framebufferul default unde desenam un simplu quad care sa acopere tot ecranul,
obtinem practic acelasi rezultat pe ecran, doar ca acum vedem o textura, pe care o putem manipula intr-un shader.

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

/*
Spre exemplu, sa zicem ca vrem sa aplicam un efect de ceata. Cu procesarea obisnuita a fragmentelor, ar trebui sa ne asiguram ca fiecare obiect diferit din scena implementeaza un efect de ceata, desi nu depinde de obiect ceata, ci de mediul in sine. In etapa de post-procesare, avand access la toti pixelii, putem pur si simplu sa aplicam global efectul de ceata.

Alte exemple...
*/
#slide(
  title: "Setarea post-procesării — Framebuffers",
  body: [
#block(inset: (left: 5%))[
- setarea este completă atunci când putem obține același rezultat al scenei, folosind textura generată

- având control asupra tuturor pixelilor, putem să
  - inversăm culorile
  - transformăm imaginea în grayscale
  - folosim diverse kernele pentru filtrare (ex. blur)
  - calculăm densitatea atmosferei din perspectiva poziției curente a camerei
] // block
])

/*
Mergem mai departe la generarea atmosferei
*/
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

#rect[Generarea atmosferei]

Calculul transmiterii luminii
] // block
#block(inset: (top: 40%))[
Lungimi de undă: #text(fill: red, "c")#text(fill: orange, "u")#text(fill: yellow, "l")#text(fill: green, "o")#text(fill: blue, "r")#text(fill: rgb("5040FF"), "i")

Alte corpuri cerești: #text(fill: gray, "s") *t* #text(fill: gray, "e") *l* *e*

Optimi#text(fill: yellow, "z")ări
] // block
] // align
]) // body and slide

/*
La baza acesteia, sta procesul de raycasting.
Se t rimite o raza din punctul Ro, in directia Rd si se calculeaza intersectiile cu atmosfera.
Cele doua puncte sunt date de solutiile ecuatiei de gradul doi a punctului cu coordonate x,y,z pe o sfera cu origine O si raza Aradius.
Cateva observatii sunt
Daca discriminantul e negativ, raza si sfera nu se intersecteaza
Daca discriminantul este egal cu 0, raza este tangenta la sfera
Daca discriminantul este pozitiv, inseamna ca se itnersecteaza in doua pozitii
Daca cele doua pozitii au semne opuse, atunci raza pleaca din interiorul sferei.

In final, putem imparti distanta parcursa prin sfera la diametrul acesteia pentru a obtine incarcarea atmosferei prin raza.
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
  ale razei $R_o + R_d * t$ cu atmosfera rezolvând \
  ecuația sferei $x^2 + y^2 + z^2 = R^2$ #cite("raysphere")

- densitatea acumulată a atmosferei întoarsă prin \
  pixelul văzut de cameră este calculată ca \
  $ (#text(fill: red)[$"far"$] - #text(fill: red)[$"near"$]) / (#text(fill: yellow)[$A_"radius"$] * 2) $ \
  adică, proporția distanței parcurse de rază \
  prin atmosferă față de diametrul acesteia
] // block
])

/*
Rezultatul este o bila in jurul planetei, in deosebita cautare de lumina.
Totusi, ne lipsesc detalii importante. Vedem ca sfera este uniforma si doar pe margini culoarea este mai inchisa deoarece lungimea razei prin sfera este mai mica. Acest model nu ia inca deloc in calcul soarele si nici transmiterea luminii.
*/
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

- atmosfera pare uniformă deoarece nu sunt modelate
  - aportul soarelui
  - absorpția energiei până ajunge la cameră #cite("seb")
] // block
])

/*
Asadar, sa aducem in lumina subiectul.
*/
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

Generarea atmosferei

#rect[Calculul transmiterii luminii]
] // block
#block(inset: (top: 40%))[
Lungimi de undă: #text(fill: red, "c")#text(fill: orange, "u")#text(fill: yellow, "l")#text(fill: green, "o")#text(fill: blue, "r")#text(fill: rgb("5040FF"), "i")

Alte corpuri cerești: #text(fill: gray, "s") *t* #text(fill: gray, "e") *l* *e*

Optimi#text(fill: yellow, "z")ări
] // block
] // align
]) // body and slide

/*
In primul rand, e important sa cunoastem fenomenul de imprastiere a energiei prin campuri de particule: atat directia de imprastiere cat si cantitatea ce se imprastie

Doua tipuri des intalnite sunt cele de la atmosfera si de la nori.
Atmosfera trece printr-o imprastiere Rayleigh, ce se produce atunci cand marimea particulei este mult mai mica ca lungimea de unda.
Avem aceasta forma de aluna, deoarece razele se imprastie predominant inainte si inapoi.
O caracteristica importanta este ca puterea de imprastiere este invers proportionala cu a patra putere a lungimii de unda.
Asta inseamna ca, de exemplu, lumina violet se imprastie de 10 ori mai mult ca lumina rosie, deci o concentratie mai mare ajunge la observator in sfera de vedere.
Si totusi, de ce e cerul albastru si nu violet? Se pare ca soarele nu emite atat de multa lumina violet iar ochiul uman percepe cel mai accentuat lumina albastra, asa ca pe aceasta o vedem pe cer

Norii au parte de o imprastiere Mie, ce se caracterizeaza prin asemanarea dintre marimea particulei si lungimea de unda, imprastierea predominant spre inainte si lipsa de corespondenta dintre puterea de imprastiere si lungimea de unda.
Prin urmare, deoarece toate lungimile de unda ajung in mod egal in nor, acestia au nuante de gri, spre alb in centru, unde se acumuleaza mai multe energie, si spre gri deschis la margini, de unde si efectul de silver lining, iar atunci cand ploua si densitatea norilor creste, se reduce si mai mult aportul de energie rezultand in ce numin noi nori de ploaie, adica gri inchis.
*/
#slide(
  title: "Calculul transmiterii luminii",
  bg_image: image(
        "static/05_scattering.png",
    width: 100%,
    height: 100%,
    fit: "cover",
  ),
  body: [
#block(inset: (left: 5%))[
= Împrăștierea undelor de lumină la interacțiunea cu particule

- Rayleigh
  - mărimea particulei este mult mai mică ca lungimea de undă
  - razele se împrăștie mai mult spre înainte și înapoi, \
    și mai puțin pe diagonală sau perpendiculară
  - puterea de împrăștiere este invers proporțională cu $lambda^4$
  - ex. atmosfera: lumina violetă este împrăștiată de aproape 10 ori mai mult ca lumina roșie

- Mie
  - mărimea particulei este aproximativ la fel ca lungimea de undă
  - razele tind să se împrăștie înainte, unde acumulează mai multă energie
  - puterea de împrăștiere este independentă de lungimea de undă
  - ex. norii: efectul de „silver lining”
] // block
])

/*
Pe planeta noastra, atmosfera e formata din foarte multe particule mici, precum de nitrogen si oxigen.
Acestea sunt grupate foarte strans la suprafata pamantului, dar se rarefiaza din ce in ce mai mult odata ce urca in atmosfera deoarece forta de gravitatie devine mai mica si este mai putin gaz care sa le impinga.
Lumina interactioneaza cu aceste particule si se resfrange in forma Rayleigh, in functie de fiecare lungime de unda.
*/
#slide(
  title: "Calculul transmiterii luminii: împrăștierea undelor de lumină",
  bg_image: image(
      "static/06_imprastiere.png",
    width: 100%,
    height: 100%,
    fit: "cover",
  ),
  body: [
#block(inset: (left: 5%))[
- Atmosfera
  - formată din foarte multe particule mici, strâns grupate aproape de suprafață, \
    dar din ce în ce mai răsfirate în depărtare
  - lumina de la soare intră în atmosferă și este împrăștiată \
    în urma interacțiunii cu moleculele
] // block
])

/*
Ochiul uman are conuri ce detecteaza cel mai bine luminiile rosii verzi si albastre.
Amintim ca puterea de transmisie se calculeaza ca 1 supra lungimea de unda la puterea a patra.
Deoarece lumina rosie are lungimea de unda cea mai mare, urmata de verde si in final albastra, avem parte de un cer albastru si daca ne indreptam ochii spre soare, pentru putin, putem vedea si putin rosu.
Acesta este cazul in care observatorul se afla, ca in desen, sub soare.
*/
#slide(
  title: "Calculul transmiterii luminii: împrăștierea undelor de lumină",
  bg_image: image(
        "static/07_deasupra.png",
    width: 100%,
    height: 100%,
    fit: "cover",
  ),
  body: [
#block(inset: (left: 5%))[
- principalele lungimi de undă detectate de ochiul uman se împrăștie astfel
  - #text(size: 12pt)[_cel mai puțin_] $1 / (lambda_#text(fill: red, "R") ^ 4) < 1 / (lambda_#text(fill: green, "G") ^ 4) < 1/ (lambda_#text(fill:blue, "B") ^ 4)$ #text(size: 12pt)[_cel mai mult_]
- ex. soarele deasupra observatorului
  - lumina albastră ajunge în cea mai mare proporție în atmosferă,\
    și dă culoare cerului
  - lumina roșie se pierde \
    și ar putea fi văzută doar dacă privim direct spre soare
] // block
])

/*
Dar haideti sa vedem si urmatorul caz, in care observatorul este plasat departe de soare
*/
#slide(
  title: "Calculul transmiterii luminii: împrăștierea undelor de lumină",
  bg_image: image(
        "static/08_departe.png",
    width: 100%,
    height: 100%,
    fit: "cover",
  ),
  body: [
#block(inset: (left: 5%))[
- ex. soarele văzut la orizontul observatorului
  - odată cu distanța crește semnificativ și absorpția de energie
  - lumina albastră este risipită în mare parte până ajunge la ochi
  - lumina verde este și ea risipită
  - predomină lumina roșie, care se va împrăștia mai aproape de observator \
    și ne va dărui un frumos apus sau răsărit
] // block
])

/*
caca
*/
#slide(
  title: "Calculul transmiterii luminii",
  bg_image: image(
        "static/09_explicatie.png",
    width: 100%,
    height: 100%,
    fit: "cover",
  ),
  body: [
#block(inset: (left: 5%))[
= Algoritmul de calcul

- se #text(fill: red, "discretizează") parcursul razei $R$ prin atmosferă, apoi pentru fiecare punct $i$
- se calculează energia primită de la soare de la limita atmosferei până la punct, tot printr-o #text(fill: yellow, "discretizare") a segmentului $E_i_"soare"$
- se calculează energia pe drumul de întoarcere de la punct până la observator $E_i_"întoarcere"$
- se calculează densitatea locală a atmosferei extrasă la punct $D_i$
- în final, $L = sum_(i=0)^n D_i * e^(-(E_i_"soare" + E_i_"întoarcere")) * (||R|| / (n - 1))$, unde
  - ultimul termen este distanța dintre două puncte discrete
  - exponențiala descrie absorpția energiei față de distanță\
    conform legii lui Beer:
] // block
])

/*
Si rezultatul este acesta
*/
#slide(
  title: "Calculul transmiterii luminii: algoritmul de calcul",
  bg_image: image(
        "static/10_rez.png",
    width: 100%,
    height: 100%,
    fit: "cover",
  ),
  body: [
#block(inset: (left: 5%))[
- Rezultat
] // block
])

/*
Vom trece rapid si prin celelalte trei capitole
*/
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

Generarea atmosferei

Calculul transmiterii luminii
] // block
#block(inset: (top: 40%))[
#rect[Lungimi de undă: #text(fill: red, "c")#text(fill: orange, "u")#text(fill: yellow, "l")#text(fill: green, "o")#text(fill: blue, "r")#text(fill: rgb("5040FF"), "i")]

Alte corpuri cerești: #text(fill: gray, "s") *t* #text(fill: gray, "e") *l* *e*

Optimi#text(fill: yellow, "z")ări
] // block
] // align
]) // body and slide

/*
Modificarea ce trebuie adusa la algoritm pentru a avea culori este sa intoarca 3 valori in loc de una singura, alb-negru
Valorea primita este inmultita cu cate un coeficient pentru fiecare lungime de unda, rosu, verde si albastru, iar coeficentul se calculeaza cu formula puterii de imprastiere a lungimilor de unda.
*/
#slide(
  title: "Lungimi de undă: culori",
  body: [
#block(inset: (left: 5%))[
= Coeficientul de împrăștiere

- $C_#text(fill: red)[$R$] = (S_"factor" / lambda_#text(fill: red)[$R$]) ^ 4 * S_"putere"$
- $C_#text(fill: green)[$G$] = (S_"factor" / lambda_#text(fill: green)[$G$]) ^ 4 * S_"putere"$
- $C_#text(fill: blue)[$B$] = (S_"factor" / lambda_#text(fill: blue)[$B$]) ^ 4 * S_"putere"$
- $S_"factor" = 1$ în mod normal, dar se recomandă o valoare mai apropiată de lungimile de undă alese (ex. $400$)
- $S_"putere"$ amplifică contribuția culorilor
- se înmulțește rezultatul de la algoritmul pentru lumină cu fiecare coeficient în parte
] // block
])

/*
Stele!
*/
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

Generarea atmosferei

Calculul transmiterii luminii
] // block
#block(inset: (top: 40%))[
Lungimi de undă: #text(fill: red, "c")#text(fill: orange, "u")#text(fill: yellow, "l")#text(fill: green, "o")#text(fill: blue, "r")#text(fill: rgb("5040FF"), "i")

#rect[Alte corpuri cerești: #text(fill: gray, "s") *t* #text(fill: gray, "e") *l* *e*]

Optimi#text(fill: yellow, "z")ări
] // block
] // align
]) // body and slide

#slide(
  title: "Alte corpuri cerești: stele",
  body: [
#block(inset: (left: 5%))[
= Instanțierea sporită a unui mesh de cerc

- se creează un număr ridicat de cercuri în jurul planetei

- în shader, se citește luminozitatea pixelului unde s-ar suprapune steaua, și se estompează stele acolo unde este destulă lumină

- în esență, acest lucru permită apariția stelor doar noaptea, când e întuneric, și în plus la hotarul dintre zi și noapte
] // block
])

/*
Optimizari
*/
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

Generarea atmosferei

Calculul transmiterii luminii
] // block
#block(inset: (top: 40%))[
Lungimi de undă: #text(fill: red, "c")#text(fill: orange, "u")#text(fill: yellow, "l")#text(fill: green, "o")#text(fill: blue, "r")#text(fill: rgb("5040FF"), "i")

Alte corpuri cerești: #text(fill: gray, "s") *t* #text(fill: gray, "e") *l* *e*

#rect[Optimi#text(fill: yellow, "z")ări]
] // block
] // align
]) // body and slide

#slide(
  title: "Optimizări",
  body: [
#block(inset: (left: 5%))[
= Pre-calcularea densitățiilor din atmosferă

- se rulează un număr mare de calcule din toate zonele din atmosferă

- se salvează rezultatul într-o textură 2D

- în algoritm, în loc să se calculeze densitatea pentru fiecare punct, se ia o mostră din textură
] // block
])

#slide(
  body: [Rezultate],
  bg_image: image(
      "static/gatabre.png",
    width: 100%,
    height: 100%,
    fit: "cover",
  ),
)

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

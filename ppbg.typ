#import "atatheme.typ": *
#import "presentation.typ": slide


#set document(title: "Signed distance functions. PPBG 2023", author: "Andrei N. Onea")
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
    logo: text(size: 8pt, "Signed distance functions | PPBG"),
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
Buna ziua! Numele meu este Andrei si astazi va voi vorbi despre Signed distance functions.
*/
#slide(title: [Signed Distance Functions], br: true,
)

/*
Vom incepe prin a descrie succint ce este o astfel de functie si de ce se numeste asa,
apoi vom defini cateva astfel de functii foarte des intalnite,
urmand sa si derivam una dintre ele, mai interesanta,
si, in final, sa aratam de ce sunt utile.
*/
#slide(
  title: "Introducere",
  body: [
#block(inset: (left: 5%))[
= Cuprins

#block(inset: (left: 5%))[
Scurtă introducere

Funcții de bază

Derivarea funcției pentru cutii

Exemple și aplicații
] // block
] // block
]) // body and slide


/*
*/
#slide(
  title: "Scurtă introducere",
  body: [
#block(inset: (left: 5%))[
= Signed distance functions

- un _SDF_ este o _funcție_ ce returnează _distanța_ de la un punct la o suprafață

- se cheamă _signed_ deoarece returnează o distanță $d$ unde
  - $d > 0$, când punctul se află in exteriorul suprafeței
  - $d < 0$, când punctul se află in interiorul suprafeței
] // block
])

/*
*/
#slide(
  title: "Funcții de bază",
  body: [
#block(inset: (left: 5%))[
= Funcții de bază ale funcțiilor de bază

- lungimea (magnitudinea) unui vector

#block(inset: (left: 15%))[
  ```C
  float length(float2 v)
  {
    sqrt(v.x * v.x + v.y * v.y);
  }
  ```
] // block

- vectorul care pleaca din $A$ în $B$ este obținut prin $B - A$
  - ceea ce înseamnă ca putem calcula distanța de la $A$ la $B$ prin funcția _length_ de mai sus

#block(inset: (left: 22%))[
  ```C
  ab = length(B - A);
  ```
] // block
] // block
])

/*
*/
#slide(
  title: "Funcții de bază",
  body: [
#block(inset: (left: 5%))[
= Funcții de bază

```C
float signed_dst_to_circle(float2 p, float2 center, float radius)
{
  return length(p - center) - radius;
}

float signed_dst_to_box(float2 p, float2 center, float2 size);
```

- alte forme mai mult sau mai puțin complicate precum
  - plan, cilindru, capsulă, con, torus, prismă
  - _SDF_-urile se pot combina între ele pentru a obține forme mai complexe
] // block
])

/*
*/
#slide(
  title: "Derivarea funcției de distanță de la punct la cutie",
  body: [
#block(inset: (left: 5%))[
= Derivarea pentru _unsigned_dst_to_box_

```C
float unsigned_dst_to_box(float2 p, float2 center, float2 size)
{
  float2 anchor = abs(p) - (center + size / 2.0);
  float unsigned_dst = length(max(anchor, 0.0));
  return unsigned_dst;
}
```

_pe tablă_...
] // block
])

/*
*/
#slide(
  title: "Derivarea funcției de distanță de la punct la cutie",
  bg_image: image(
      "static/ppbg_sdf_unsigned.png",
    width: 100%,
    height: 100%,
    fit: "cover",
  ),
  body: [
#block(inset: (left: 5%))[
= Derivarea pentru _unsigned_dst_to_box_

```C
float unsigned_dst_to_box(float2 p, float2 center, float2 size)
{
  float2 anchor = abs(p) - (center + size / 2.0);
  float unsigned_dst = length(max(anchor, 0.0));
  return unsigned_dst;
}
```
] // block
])

/*
*/
#slide(
  title: "Derivarea funcției de distanță de la punct la cutie",
  body: [
#block(inset: (left: 5%))[
= Derivarea pentru _signed_dst_to_box_

```C
float signed_dst_to_box(float2 p, float2 center, float2 size)
{
  float2 anchor = abs(p) - (center + size / 2.0);
  float unsigned_dst = length(max(anchor, 0.0));
  float dst_inside_box = max(min(anchor, 0.0));
  return unsigned_dst + dst_inside_box;
}
```

_pe tablă_...
] // block
])

/*
*/
#slide(
  title: "Derivarea funcției de distanță de la punct la cutie",
  bg_image: image(
      "static/ppbg_sdf_signed.png",
    width: 100%,
    height: 100%,
    fit: "cover",
  ),
  body: [
#block(inset: (left: 5%))[
= Derivarea pentru _signed_dst_to_box_

```C
float signed_dst_to_box(float2 p, float2 center, float2 size)
{
  float2 anchor = abs(p) - (center + size / 2.0);
  float unsigned_dst = length(max(anchor, 0.0));
  float dst_inside_box = max(min(anchor, 0.0));
  return unsigned_dst + dst_inside_box;
}
```
] // block
])

/*
*/
#slide(
  title: "Exemple și aplicații",
  body: [
#block(inset: (left: 5%))[
= Exemple

#grid(columns: (1fr, 1fr, 1fr),
image(
  "static/ppbg_sphere.png",
  width: 80%,
  height: 80%,
  fit: "contain",
), // image
image(
  "static/ppbg_bool.png",
  width: 80%,
  height: 80%,
  fit: "contain",
), // image
image(
  "static/ppbg_morph.png",
  width: 80%,
  height: 80%,
  fit: "contain",
) // image
) // grid
] // block
])

/*
*/
#slide(
  title: "Exemple și aplicații",
  body: [
#block(inset: (left: 5%))[
= Aplicații

- Ray Marching

- randare la un DPI înalt a fonturilor folosind GPU pentru jocuri video (implementarea aparține Valve)

- _SDFGI_ -- model de iluminare globală în timp real folosit de motorul de jocuri video Godot (din versiunea 4.0)

- _GPUI_ -- framework UI pentru randarea tuturor elementelor pe GPU, în stilul jocurilor video
  - creat pentru a dezvolta un editor text numit _Zed_ care țintește să randeze la 120 FPS
] // block
])

#slide(
  br: true,
  title: "Signed Distance Functions",
  body: "Mulțumesc pentru atenție!",
)

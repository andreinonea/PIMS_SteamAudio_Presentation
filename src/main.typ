#import "templates/slide.typ": slide

#set slide(
  date: "2023",
  author: "Andrei N. Onea",
  event: "PIMS PRESENTATION",
  format: "presentation-16-9",
  bg_image: image(
    "../static/steam-audio-landing-background3_150pct_cropped.png",
    width: 100%,
    height: 100%,
    fit: "cover",
  ),
  header_image: image(
    "../static/steam-audio-logo.png",
    width: 30%,
    height: 50%,
    fit: "contain",
  ),
)


#slide(title: [Steam Audio], page_break: true)
#slide
#include "01_Introduction.typ"
#slide(title: [Thank you! Questions?], page_break: true)

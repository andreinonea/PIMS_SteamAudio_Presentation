#set document(
  title: "Binaural audio demo scene",
  author: "Andrei N. Onea",
)

#set text(size: 12pt)

#set par(justify: true)

#let makelink(term) = {
  text(blue, underline(term))
}

#show link: underline
#show link: makelink

#align(center + horizon)[
#set text(size: 21pt)
*Binaural audio demo scene* \
#set text(size: 18pt)
Andrei N. Onea
]

#align(center + top)[
#image(
  "static/scene.png",
  width: 50%,
  height: 50%,
  fit: "contain",
)
]

#align(center + bottom)[
#set text(size: 15pt)
PIMS 2023
]

#pagebreak()

#outline(depth: 1)

#pagebreak()

= Overview

_Binaural audio demo scene_ is an interactive 3D virtual environment where the user can explore the benefits of spatial audio.
The demo scene is made up from several rooms of various sizes, where audio sources are placed.

There can be only one source in each room for this demo, but, at any point, the user can open a menu by pressing a key and select which audio track is playing in each room.

The user can freely walk around the scene and experience the way sound changes as they turn their head around, change elevation, step away from the source or let it be obstructed by a wall.

Alternatively, they can teleport to any room by pressing a key to cycle through them, which enables the free movement of the audio source around the user. It can be rotated or panned and reset to its initial position within a sphere. Moving the virtual character disables this mode.

= Core concepts

Let us briefly describe a few core concepts and the technology required for this project.

A _binaural recording_ is a method of recording sound using two microphones with the goal of best approximating how would each ear of an individual perceive a sound.
It should not be mistaken for stereo audio, which means that there are two audio channels, but still only one microphone was used during recording. Binaural literally means "two ears".  

A _head-related transfer function (HRTF)_ is a function that synthesizes a binaural sound by appling filters to an incoming sound, based on the location and the direction of the audio source.
It says how a sound from a specific place reaches each ear of the listener.
As a digital filter, it can be applied in real-time in applications such as video games in order to achieve 3D audio.
It is important to note that the particularities of each individual's ears make the perception of sound unique to everyone.
There are large datasets of HRTFs collected from many subjects, and several have been found to work nicely for the general population, but it will always be the case that the most accurate results you would get would be given by measuring your own HRTF.

By _spatial audio_ we mean a physically-accurate sound experience that takes into account all the geometry and physical properties of the space around the listener.
Size, shape, layout and material properties of rooms and objects in the scene, existence of doors, windows in the walls and their current state, all play a role in the propagation of sound.

=== Software

Our goal is to provide a true-to-life demonstration of the capabilities of sound processing in virtual environments.
Because most applications are real-time simulations, such as video games, we require an eficient real-time solution for processing the physics of sound.
Meet _Steam Audio_.

= Steam Audio

Developed by Valve, makers of the Steam Store and Counter-Strike games, Steam Audio is a software library for spatial audio.
It is fast, efficient and, most importantly, physically-accurate.
It offers integrations with game engines, such as Unreal Engine or Unity Engine, as well as a C API for custom engine integrations.
We have chosen this toolkit because, having played Counter-Strike games where this very solution is implemented, we believe it stands true to its purpose and our goals.

*Binaural sound:* Steam Audio renders sound binaurally by applying HRTFs to model the place of a sound relative to the listener.

*Sound propagation:* By analyzing the scene geometry and casting rays, it can physically model the way sound travels through the environment, taking into account occlusion of sources, reflection, attenuation, room reverberation etc. 

*Real-time:* Its efficienty allows for dynamically recalculating sound effects whenever an object in the scene moves.
This is crucial for our demonstration, as we want to allow the user to freely move and explore for an impressive and immersive experience.

= Demo controls

The application defines the following general keybindings.

- *H*: show this help menu with available keybindings
- *M*: show menu for controlling audio sources in each room; a mouse pointer becomes available and allows to easily switch between sources or muting them.
- *N*: teleport to next room and start lock-in experience
- *P*: teleport to previous room and start lock-in experience
- *WASD*: move forward, left, backward and right; disabled lock-in experience
- *Mouse*: look around

The next keybindings are only available in the lock-in experience.

- *R*: reset audio source to initial position
- *IJKL*: move source up, left, down, right on a sphere centered around the listener
- *UO*: pan source left and right
- *-+*: increase/decrease radius of the sphere around the listener
- *V*: view the sphere around the listener

= Feedback

We would like to hear your feedback about this document.
We apologize for not having started this project earlier to achieve the standard of quality that you may expect from us and, surely, that we expect from ourselves.

#align(bottom)[
Thank you for reading this and best regards,

ANO Team

#align(right, text(size: 6pt)[
made with #link("https://typst.app/")[Typst]
])
]

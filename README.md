OpenSCAD Dovetails
==================
A library for generating dovetail tails and pins in OpenSCAD.

`dovetail_pins()` will generate just the pins of a dovetail joint.

`dovetail_tails()` will generate just the tails of a dovetail joint.

`board_with_dovetail_tails()` and `board_with_dovetail_pins()` are much more useful; they will generate boards with pins or tails cut into each end.

The default output of `dovetails.scad` is just a pair of boards with pins and tails.

![A pair of boards with pins and tails](/boards.png)

`dovetail-box.scad` demonstrates how four boards would fit together and is also an example of pins and tails of different thicknesses.

![A dovetailed box frame](/box.png)
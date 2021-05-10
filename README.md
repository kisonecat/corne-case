# 3D printed case for Corne

Here are models for a 3D printed case for the wonderful [Corne
keyboard](https://github.com/foostan/crkbd) designed by
[@foostan](https://github.com/foostan).  The top piece in this model
covers up the OLED, so this isn't a good choice if you are using
underlighting or the OLED.

![Photo of the right half as viewed from the left hand side](./photo1.jpg)

![Photo of the right half as viewed from the right hand side](./photo2.jpg)

## Structure of project

The top of the case is defined in [top.scad](./top.scad), which I
printed upside down.  The bottom of the case is
[bottom.scad](./bottom.scad).  Both these are built from
[case.scad](./case.scad), which depends on [screw.scad](./screw.scad)
which provides the cutout for a fastener between the two pieces.  One
side of the case has an M3-sized screwhole, and the other has a holder
for a nut.  Melting a small spacer into the plastic would probably be
better.

In this version, the clearance for the TRRS and USB-C cable are both
quite low, so it is a tight fit.  I like the snug fit (since I don't
want the TRRS cable to slip out!) but you may want to make those
cutouts a bit wider.

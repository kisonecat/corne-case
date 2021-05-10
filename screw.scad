module fastener() {
tol = 1.01;
nut_diameter = 6.3*tol;
nut_height = 3*tol;
screw_diameter = 3.4*tol;
head_diameter = 7.4;
screw_height = 5.0 - nut_height;
head_height = 3;
cut_depth = 3.1;


translate([0,0,screw_height+head_height]) {
/*linear_extrude(nut_height,scale=0)
circle(nut_diameter/2,$fn = 6);*/

    
hull() {
translate([0,0,2*nut_height])
  scale([1,1,-1])
linear_extrude(2*nut_height,scale=0.5)
circle(nut_diameter/2,$fn = 6);
    
translate([0,0,2*nut_height])
  scale([1,1,-1])
linear_extrude(nut_height)
circle(nut_diameter/2,$fn = 6);


translate([-nut_diameter/2,0,nut_height])
cube([nut_diameter,cut_depth,nut_height]);
}
/*
translate([0,cut_depth,2*nut_height])
linear_extrude(5,scale=0.6)
translate([0,-cut_depth,0])
projection()
union() {
    translate([0,0,nut_height])
    linear_extrude(nut_height)
circle(nut_diameter/2,$fn = 6);
translate([-nut_diameter/2,0,nut_height])
cube([nut_diameter,cut_depth,nut_height]);
}
*/

translate([0,0,-screw_height])
cylinder(r1=screw_diameter/2,r2=screw_diameter/2,h=screw_height,$fn=32);


translate([0,0,-screw_height-head_height])
cylinder(r1=head_diameter/2,r2=screw_diameter/2,h=head_height,$fn=32);
}
}

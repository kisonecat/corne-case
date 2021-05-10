include <screw.scad>

W = 133.75066;
H = 92.18542;
$fn=32;

module bottom() {
    translate([0,-H,0])
    import("bottom.svg");
}

S = 1.15;
SS = 1.06;
layer_thickness = 0.4;
margin=7;

plate_thickness = 3;
spacer_height = 12;
spacer_diameter = 5;

screw_diameter = 2.5;
screwhead_diameter = 5;
screwhead_height = 3;
keyswitch_bottom = 7;
pcb_thickness = 1.7;
case_thinness = 1.0;

module spacer(x,y) {
    translate([x+4.950/2,-y-4.950/2,0])
    cylinder(h=spacer_height,r=spacer_diameter/2);
}

elitec_offset = 6.972;
elitec_height = 34;
elitec_width = 19;
elitec_thickness = 7.6 - pcb_thickness; 

trrs_offset = 51.7;
trrs_height = 6.2;
trrs_width = 14;
trrs_thickness = 7 - pcb_thickness; 

keyswitch_height = 10;

module keyswitches() {
    translate([0,0,spacer_height])
    translate([W/2,-H/2])
    scale([0.99,0.99,1])
    translate([-W/2,H/2])
    linear_extrude(keyswitch_height) translate([0,-91.39875]) import("top.svg");
}


module elitec() {
       translate([W-elitec_width,-elitec_height-elitec_offset,plate_thickness + spacer_height - keyswitch_bottom]) cube([elitec_width,elitec_height,elitec_thickness]); 
}

module trrs() {
        translate([W-trrs_width,-trrs_height-trrs_offset,plate_thickness + spacer_height - keyswitch_bottom]) cube([trrs_width,trrs_height,trrs_thickness]); 
}

jack_offset = 51.7;
jack_height = 8;
jack_width = 24;
jack_thickness = 8; 
jack_protrusion = 2.5;
inset = 1;

module jack() {
       translate([W-jack_width+20,-jack_height/2 - trrs_height/2 -jack_offset, spacer_height - keyswitch_bottom + pcb_thickness])
   
   hull() {
        translate([0,inset,0])
    cube([jack_width,jack_height-2*inset,jack_thickness]);
       
        translate([0,0,0])
    cube([jack_width,jack_height,jack_thickness-2*inset]);
   }
   
    translate([W,-trrs_height-trrs_offset]) cube([jack_protrusion,trrs_height, spacer_height - keyswitch_bottom + jack_thickness]); 
}


module components() {
        hull() union() { trrs(); elitec(); };
}





usbc_width = 14;
usbc_center = 19 / 2 - 0.5;
usbc_thickness = 5.7; 
inset = 0.8;

module usbc() {
         translate([W-usbc_center - usbc_width/2,-elitec_height+27,plate_thickness + spacer_height - keyswitch_bottom + pcb_thickness-1])
    
   hull() {
        translate([inset,0,0])
    cube([usbc_width-2*inset,elitec_height,usbc_thickness+1]); 
        
        translate([0,0,inset])
    cube([usbc_width,elitec_height,usbc_thickness+1-2*inset]); 
    }
}


module parts() {
    translate([0,0,spacer_height])
    linear_extrude(plate_thickness) translate([0,-91.39875]) import("top.svg");
    spacer(16.100,23.375);
spacer(16.100,42.125);
spacer(59.350,59.375);
spacer(105.850,67.125);
spacer(92.100,19.625);
    
    translate([0,0,plate_thickness + spacer_height - keyswitch_bottom]) linear_extrude(pcb_thickness) bottom();
    
}

module screwhole(x,y) {
    translate([x+4.950/2,-y-4.950/2,-case_thinness - screwhead_height])
    union() {
    cylinder(h=10,r=screw_diameter/2);
        
    cylinder(h=screwhead_height,r2=screw_diameter/2,r1=screwhead_diameter/2);
    }
}

module screwholes() {
screwhole(16.100,23.375);
screwhole(16.100,42.125);
screwhole(59.350,59.375);
screwhole(105.850,67.125);
screwhole(92.100,19.625);
}

case_top = case_thinness + spacer_height + plate_thickness;


module core() {
minkowski()
{  
bottom();
circle(r=margin);
};
}

module basic() {
translate([0,0,-case_bottom])

intersection() {
translate([W/2,-H/2])
linear_extrude(case_top+case_bottom,scale=S)
translate([-W/2,H/2])
core();

translate([W/2,-H/2,case_top+case_bottom])
scale([1,1,-1])
linear_extrude(case_top+case_bottom,scale=S)
translate([-W/2,H/2])
core();
    
translate([W/2,-H/2,case_top+case_bottom])
scale([SS,SS,-1])
linear_extrude(case_top+case_bottom)
translate([-W/2,H/2])
core();
}
}

module basic2() {
    difference() {
basic();
 
 translate([W/2,-H/2,0])
scale([1.03,1.03,1])
linear_extrude(spacer_height + plate_thickness)
translate([-W/2,H/2])
bottom();
        
        //usbc();
        jack();
        keyswitches();
        parts();
        screwholes();
        
        rotate([0,0,180+45])
        translate([6.5,2.5,-case_bottom-0.1])
fastener();
        
    translate([W+2.5,-4.6,-case_bottom-0.1])
rotate([0,0,180-45])
fastener();

  translate([W-14,-H-2.5,-case_bottom-0.1])
rotate([0,0,0])
fastener();

 translate([-2,-65,-case_bottom-0.1])
rotate([0,0,-45])
fastener();
    }
}

  

case_bottom = case_thinness + screwhead_height;

module case() {
translate([0,0,case_top])
scale([1,1,-1])
translate([W/2,-H/2])
linear_extrude(case_top + case_bottom,scale=S)
    scale(1.05)
    translate([-W/2,H/2])
hull() bottom();
}


module final() {
difference() {
    case();
    keyswitches();
    screwholes();
    components();
    usbc();
    jack();
    hull() parts();

}
}

//parts(); 
//final();

//basic2();

slice = 4.9;

module separation() {
      translate([-W,-3*H/2,-case_bottom-1]) 
    cube([3*W,3*H,slice+1]);
    
    translate([W-jack_width+10,-jack_height/2 - trrs_height/2 -jack_offset,-17]) cube([2*jack_width,jack_height,30]); 
    /*
     translate([W-usbc_center - usbc_width/2,-elitec_height+27,-19]) cube([usbc_width,elitec_height,30]);*/
}

/*
intersection() {
 separation();
 basic2();
}
*/


difference() {
 basic2();
     separation();
}

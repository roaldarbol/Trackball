$fa = 1;
$fs = 0.6;
$fn = 60;

// ==== VARIABLES === //

makerbeam=10;
wall=2;
bolt_diameter = 3;
wall_height = 4;
neopixel_outer = 36.8 + 0.5;
neopixel_inner = 23.3 - 0.5;
neopixel_height = 6.7 + 0.5;


// === GENERATE THE DAMN THING === //
translate([-35,0,0])
rotate([0,90,0])
makerbeam_led_ring(
    makerbeam = makerbeam,
    wall = wall,
    bolt_diameter = bolt_diameter
    );


// === MODULES === //

module makerbeam_led_ring(
    makerbeam,
    wall,
    bolt_diameter,
    ring_diameter
    ){
        difference(){
            minkowski(){
                cube([makerbeam+2*wall,makerbeam+2*wall, 2*makerbeam], center=true);
                sphere(r=1);
            }
            cube([makerbeam,makerbeam,3*makerbeam], center=true);
            translate([-(makerbeam+2*wall)/2,0,0])
            rotate([0,90,0])
            #cylinder(d=bolt_diameter, h=wall, center=true);
        }
    }
    translate([0,0,-((makerbeam+2*wall+2))/2+wall_height-1])
    difference(){
        difference(){
            cylinder(h=neopixel_height+wall, d=neopixel_outer + wall, center=true);
            cylinder(h=neopixel_height+wall, d=neopixel_inner - wall, center=true);
        }
        translate([0,0,wall])
        difference(){
            cylinder(h=neopixel_height,d=neopixel_outer, center=true);
            cylinder(h=neopixel_height, d=neopixel_inner, center=true);
        }
    }
    
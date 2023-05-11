$fa = 1;
$fs = 0.6;
$fn = 30;

// ==== VARIABLES === //

makerbeam=10.1;
wall=2;
bolt_diameter = 3;


// === GENERATE THE DAMN THING === //
makerbeam_crossmount(
    makerbeam = makerbeam,
    wall = wall,
    bolt_diameter = bolt_diameter
    );


// === MODULES === //

module makerbeam_crossmount(
    makerbeam,
    wall,
    bolt_diameter
    ){
    difference(){
        minkowski(){
            cube([2*makerbeam+3*wall,makerbeam+wall,makerbeam+wall], center=true);
            sphere(r=1);
        }
        translate([wall+makerbeam/2,0,0])
        cube([makerbeam,makerbeam,2*makerbeam], center=true);
        
        translate([-(wall+makerbeam/2),0,0])
        rotate([90,0,0])
        cube([makerbeam,makerbeam,2*makerbeam], center=true);
        
        for (i=[-1,1]){
            translate([i*(makerbeam+2*wall),0,0])
            rotate([0,90,0])
            cylinder(d=bolt_diameter, h=makerbeam+2*wall, center=true);
        }
    }
}
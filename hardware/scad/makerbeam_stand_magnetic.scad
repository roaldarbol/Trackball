$fa = 1;
$fs = 0.6;
$fn = 200;

// ==== VARIABLES === //

base_diameter = 50; //22
base_height = 4;
stand_height = 20;
magnet_size = [6.2,3];


// === GENERATE THE DAMN THING === //
makerbeam_stand(
    base_diameter = base_diameter,
    base_height = base_height,
    stand_height = stand_height,
    magnet_size = magnet_size
    );


// === MODULES === //



module rounded_box(points, radius, height){
    hull(){
        for (p = points){
            translate(p) cylinder(r=radius, h=height);
        }
    }
}

module makerbeam_stand(
    base_diameter,
    base_height,
    stand_height,
    magnet_size
){
    corner_radius = base_diameter/4;
    corner_coord = base_diameter/2 - corner_radius;
    bolt_diameter = 3;
    mb = 10.2;
    
    points = [  [corner_coord,corner_coord,0], 
                [corner_coord,-corner_coord,0], 
                [-corner_coord,corner_coord,0], 
                [-corner_coord,-corner_coord,0] ];
    difference(){
        union(){
            
            // Base
//            translate([0,1,0])
            rounded_box(points, corner_radius, base_height);
            translate([0,0,base_diameter/4+corner_radius/8+base_height/2])
            cube([mb+2, mb+2, base_diameter/2+corner_radius/4], center=true);
            
            // Walls
            for (i=[-1,1]){
                intersection(){
                    rounded_box(points, corner_radius, base_diameter);
                    translate([0,1.5,0]) 
                    rotate([90,45,45*i]) 
                    translate([-i*0.5,-i*0.5,0]) 
                    rounded_box(points, corner_radius, 2);
                }
            }
        }
        
        // Makerbeam cut-out
        translate([0,0,base_diameter/2+2])
        cube([10,10,base_diameter], center=true);
        
        // Bottom screw
        hull(){
            translate([0,0,2])cylinder(h=0.1, d=bolt_diameter, $fn=30);
            cylinder(h=0.1, d=bolt_diameter*2, $fn=30);
        }
        
        // Magnets
        for (i=points){
            translate(i)
            cylinder(d=magnet_size[0], h=magnet_size[1]-1);
        }
    } 
}
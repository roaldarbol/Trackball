$fn= $preview ? 60 : 100;
ball_diameter = 50;
ball_coverage = 1/3;
cylinder_diameter = 70;
cylinder_thickness = 2;
hose_connector = 9.8;
magnet_size = [6.1,3];
opening_d = 35;


// Metabolic rate chamber parts
// rotate([180,0,0])
// translate([0,0,-80])
// trackball_metabolic_top(
//     cylinder_diameter = cylinder_diameter,
//     cylinder_thickness = cylinder_thickness,
//     hose_connector = hose_connector
//     );
//translate([100,0,0])
// tether_inner(
//    cylinder_diameter = cylinder_diameter,
//    cylinder_thickness = cylinder_thickness,
//    magnet_size = magnet_size
//    );
//translate([0,100,0])
//tether_outer(
//    cylinder_diameter = cylinder_diameter,
//    cylinder_thickness = cylinder_thickness,
//    magnet_size = magnet_size
//    );
//    translate([0,0,-ball_diameter/2-10])
trackball_floor(
   ball_diameter = ball_diameter,
   ball_coverage = ball_coverage,
   cylinder_diameter = cylinder_diameter,
   cylinder_thickness = cylinder_thickness,
   opening_d = opening_d
);

// -------- TOP -------- //
module trackball_metabolic_top(
    cylinder_diameter = 70,
    cylinder_thickness = 3,
    hose_connector = 10,
    airduct_diameter = 5,
    extra_height = 15,
    hose_on_side = true
){

    outer_height = 10;
    inner_height = 20;
    base_height = 10;
    
    cylinder_inner_d = cylinder_diameter - (2*cylinder_thickness) - 0.5;
    outer_d = cylinder_diameter + 5;
    
    
    // Main piece
    difference(){
        union(){
            cylinder(h=base_height + inner_height, d=cylinder_inner_d);
            difference(){
                translate([0,0,base_height/2])
                rounded_cube(
                    [cylinder_diameter+5,cylinder_diameter+5,base_height], 
                    radius=4, 
                    outside=true);
//                cylinder(h=base_height, d=outer_d);
                // Acrylic cylinder for metabolic rate
                translate([0,0,base_height])
                cylinder(d=cylinder_inner_d, h=100);
                
            }
            
            // Extra width around hose connector
            translate([0,-outer_d/2+10,base_height/2]){
                sphere(d=hose_connector+10);
                rotate([90,0,0])
                cylinder(h=(cylinder_diameter+5)/2-(outer_d/2+10)/2,d=hose_connector+10);
            }
        }
        
        // Remove stuff around cylinder
        translate([0,0,base_height])
        difference(){
            cylinder(d=cylinder_diameter+5, h=100);
            cylinder(d=cylinder_inner_d, h=100);
        }
        
        // Screw holes
        for (i=[-1,1]){
            for (j=[-1,1]){
                translate([i*(cylinder_diameter/2 - 5),j*(cylinder_diameter/2 - 5),0]){
                    cylinder(h=base_height, d=5);
                    cylinder(h=4, d=9);
                }
            }
        }
            
            
            if (hose_on_side==true){
                
                // Airhole //
                // Funnel
                translate([0,0,base_height/2])
                cylinder(d1=airduct_diameter, d2=cylinder_inner_d-2, h=inner_height+base_height/2);
                
                // Airduct out
                translate([0,airduct_diameter/2,base_height/2])
                rotate([90,0,0])
                cylinder(h=outer_d/2,d=airduct_diameter);
                
                // Hose connector groove
                translate([0,-outer_d/2+10,base_height/2])
                rotate([90,0,0])
                cylinder(h=outer_d,d=hose_connector);
            }
//            else {
//                // Airhole
//                translate([0,0,h])
//                cylinder(h=h,d=airduct_diameter);
//                
//                translate([0,0,h/2])
//                rotate([90,0,0])
//                cylinder(h=outer_d,d=airduct_diameter);
//                
//                translate([0,-outer_d/2+10,h/2]){
//                    rotate([90,0,0]){
//                        cylinder(h=outer_d,d=hose_connector);
//                        translate([0,0,8])
//                        cylinder(h=outer_d,d=hose_connector+7);
//                    }
//                }
//            }
            
    }
}


module tether_inner(
    cylinder_diameter = 70,
    cylinder_thickness = 3,
    magnet_size = [6.1,3],
){
    cylinder_inner_d = cylinder_diameter - (2*cylinder_thickness) - 0.5;
    sphere_thickness = magnet_size[0]+4;
    base_height = (magnet_size[0]+4)/2;
    
    difference(){
        union(){
            intersection(){
                cylinder(h=magnet_size[0]*2, d=cylinder_inner_d);
                for (i=[150:120:390]){
                    difference(){
                        rotate([0,0,i])
                        translate([0,cylinder_inner_d/2,magnet_size[0]-1])
                        rotate([90,0,0])
                        cylinder(h=magnet_size[0], d=magnet_size[0]+4);
                        translate([0,0,base_height])
                        sphere(d=cylinder_inner_d - sphere_thickness);
                        cylinder(d=cylinder_inner_d - sphere_thickness, h=base_height);
                    }
                }
            }
            
            // Scaffold
            translate([0,0,base_height])
            difference(){
                union(){
                    for (i=[150:60:390]){
                        intersection(){
                            sphere(d=cylinder_inner_d);
                            rotate([0,0,i])
                            translate([-(sphere_thickness)/2,0,0])
                            cube([sphere_thickness,cylinder_inner_d,cylinder_inner_d]);
                        }
                    }
                    
                    // Handle
                    translate([0,0,(cylinder_diameter)/2])
                    rotate([90,0,90])
                    cylinder(d=15, h=4, center=true);
                    
                    intersection(){
                        sphere(d=cylinder_inner_d);
                        cylinder(d=20, h=100);
                    }
                        
                }
                sphere(d=cylinder_inner_d - sphere_thickness);
                translate([0,0,-cylinder_diameter/2])
                cube(cylinder_diameter, center=true);
            }
            
            // Bottom rim
            difference(){
                cylinder(h=base_height, d=cylinder_inner_d);
                cylinder(h=base_height, d=cylinder_inner_d-sphere_thickness);
                
                // Remove front
                translate([-cylinder_diameter/2,0,0])
                cylinder(d=cylinder_diameter, h=cylinder_diameter/4, $fn=6);
            }
            

        }
        
        // Magnets
        for (i=[150:120:390]){
            rotate([0,0,i])
            translate([0,cylinder_inner_d/2,magnet_size[0]-1])
            rotate([90,0,0])
            cylinder(h=magnet_size[1]+0.1, d=magnet_size[0]+0.2);
        }
        cylinder(d=9,h=8);
        
    }
    
    // Attachment
    attach_d1 = 9;
    attach_d2 = 4.2;
    attachment_l = 4;
    donut_r = (attach_d1 - attach_d2) /2;
    translate([0,0,cylinder_diameter/2-base_height])
    union(){
        difference(){
            cylinder(d=attach_d1, h=donut_r);
            rotate_extrude(convexity = 10)
            translate([attach_d1/2, 0, 0])
            circle(r = donut_r, $fn = 100);
        }
        translate([0,0,-attachment_l])
        cylinder(d=attach_d2, h=attachment_l);
    }
}

module tether_outer(
    cylinder_diameter = 70,
    cylinder_thickness = 3,
    magnet_size = [6.2,3],
){
    
    cylinder_diameter = cylinder_diameter + 0.5;
    tether_thickness = magnet_size[1]+3;
    tether_outer_d = cylinder_diameter + tether_thickness;
    
    difference(){
        union(){
//            cylinder(h=magnet_size[0]*2, d=cylinder_diameter);
            for (i=[150:120:390]){
                rotate([0,0,i])
                translate([0,cylinder_diameter/2+magnet_size[0],(magnet_size[0]+4)/2])
                rotate([90,0,0])
                cylinder(h=magnet_size[0], d=magnet_size[0]+4);
            }
            difference(){
                cylinder(h=magnet_size[0]+4, d=tether_outer_d);
                // Remove front
                translate([-cylinder_diameter,0,0])
                cylinder(d=cylinder_diameter*2, h=cylinder_diameter/4, $fn=6);
            }
        }
        translate([0,0,-1])
        cylinder(h=magnet_size[0]+6+2, d=cylinder_diameter);
        
        for (i=[150:120:390]){
            rotate([0,0,i])
            translate([0,cylinder_diameter/2+magnet_size[1],magnet_size[0]-1])
            rotate([90,0,0])
            cylinder(h=magnet_size[1]+0.5, d=magnet_size[0]+0.2);
        }
    }
    
}

module trackball_floor(
    ball_diameter = 50,
    ball_coverage = 1/3,
    cylinder_diameter = 70,
    cylinder_thickness = 3,
    opening_d = 40
){  
    ball_diameter = ball_diameter + 4.5;
    cylinder_inner_d = cylinder_diameter - (2*cylinder_thickness) - 0.5;
    floor_height = ball_diameter - (ball_diameter*ball_coverage) - (ball_diameter*0.12);
    
    translate([0,0,ball_diameter/2-ball_diameter*ball_coverage])
    sphere(d=ball_diameter-4.5);

    difference(){
        cylinder(d=cylinder_inner_d, h=floor_height);
        translate([0,0,ball_diameter/2-ball_diameter*ball_coverage])
        sphere(d=ball_diameter);
        
        translate([0,0,ball_diameter/2-ball_diameter*ball_coverage])
        rotate([0,90,0])
        cylinder(d=cylinder_inner_d/2, h=cylinder_inner_d/2);
    }

    // Make smaller top
    translate([0,0,0.5*ball_diameter])
    difference(){
        cylinder(h=2, d=cylinder_inner_d);
        #cylinder(h=2, d=opening_d);
    }
    
}
    


// ====== MISC HELPERS ======= //
    
module rounded_cube(
    dims, 
    radius=1, 
    outside=false, 
    $fn=60
) {

    new_dims = dims / 2;
    if (outside==true){
        new_dims = [new_dims[0] - radius, new_dims[1] - radius, new_dims[2]];
        points = [  [new_dims[0],-new_dims[1],0], 
                [new_dims[0],new_dims[1],0], 
                [-new_dims[0],new_dims[1],0], 
                [-new_dims[0],-new_dims[1],0] ];
        translate([0,0,-dims[2]/2])
        hull(){
            for (p = points){
                translate(p) cylinder(r=radius, h=dims[2]);
            }
        }
    } else {
        points = [  [new_dims[0],-new_dims[1],0], 
                [new_dims[0],new_dims[1],0], 
                [-new_dims[0],new_dims[1],0], 
                [-new_dims[0],-new_dims[1],0] ];
        translate([0,0,-dims[2]/2])
        hull(){
            for (p = points){
                translate(p) cylinder(r=radius, h=dims[2]);
            }
        }
    }
    
}
    
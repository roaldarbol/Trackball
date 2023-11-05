use <trackball_misc.scad>;

module tether_inner(
    cylinder_diameter = 70,
    cylinder_thickness = 3,
    field_of_view = 120,
    n_magnets = 4,
    magnet_size = [6.1,3],
    adjustment = 0
){
    fov_margin = 20;
    not_fov = 360 - field_of_view - 2*fov_margin;
    cylinder_inner_d = cylinder_diameter - (2*cylinder_thickness) - 0.3;
    sphere_thickness = magnet_size[0]+2;
    base_height = 6;

    difference(){
        union(){
            difference(){
                cylinder(d=cylinder_inner_d, h=base_height, center=true);
                translate([0,0,-(base_height+1)/2])
                pie_slice(field_of_view, cylinder_inner_d, base_height+1);
            }
            //Cylinder around the insert
            cube([15,7,base_height], center=true);
            // cylinder(d=10, h=base_height, center=true);
        }
        // Syringe tip attachment
        translate([0,adjustment,0]){
            cylinder(d=3.2, h=base_height+1, center=true);
            cube([7,1.4,base_height*2], center=true);
        }

        // Magnets
        for (i=[-not_fov/2:not_fov/(n_magnets-1):not_fov/2]){
            rotate([0,0,i])
            translate([0,cylinder_inner_d/2,0])
            rotate([90,0,0])
            cylinder(h=magnet_size[1]+0.1, d=magnet_size[0]+0.2);
        }
        

    }
    
    // difference(){
    //     union(){
    //         // intersection(){
    //         //     cylinder(h=magnet_size[0]*2, d=cylinder_inner_d);
    //         //     for (i=[0:100:200]){
    //         //         difference(){
    //         //             rotate([0,0,i])
    //         //             translate([0,cylinder_inner_d/2,magnet_size[0]-1])
    //         //             rotate([90,0,0])
    //         //             cylinder(h=magnet_size[1]+2, d=sphere_thickness);
    //         //             translate([0,0,base_height])
    //         //             sphere(d=cylinder_inner_d - sphere_thickness);
    //         //             cylinder(d=cylinder_inner_d - sphere_thickness, h=base_height);
    //         //         }
    //         //     }
    //         // }
            
    //         // Scaffold
    //         // translate([0,0,base_height])
    //         // difference(){
    //         //     union(){
    //         //         for (i=[150:120:390]){
    //         //             intersection(){
    //         //                 sphere(d=cylinder_inner_d);
    //         //                 rotate([0,0,i])
    //         //                 translate([-(sphere_thickness)/2,0,0])
    //         //                 cube([sphere_thickness,cylinder_inner_d/2,cylinder_inner_d]);
    //         //             }
    //         //         }
                    
    //         //         // Handle
    //         //         // translate([0,0,(large_cylinder_diameter)/2])
    //         //         // rotate([90,0,90])
    //         //         // cylinder(d=15, h=4, center=true);
                    
    //         //         // intersection(){
    //         //         //     sphere(d=cylinder_inner_d);
    //         //         //     cylinder(d=20, h=100);
    //         //         // }
                        
    //         //     }
    //         //     sphere(d=cylinder_inner_d - sphere_thickness);
    //         //     translate([0,0,-cylinder_diameter/2])
    //         //     cube(cylinder_diameter, center=true);
    //         // }
            
    //         // Bottom rim
    //         translate([0,0,1]){
    //             // Inner
    //             difference(){
    //                 cylinder(h=base_height, d=cylinder_inner_d-sphere_thickness); // THE MINUS PART IS ONLY FOR TESTING THE SYRINGE TIP
    //                 // cylinder(h=base_height, d=cylinder_inner_d-sphere_thickness);
                    
    //                 // Remove front
    //                 rotate([0,0,190])
    //                 translate([-cylinder_diameter,0,0])
    //                 cylinder(d=cylinder_diameter*2, h=cylinder_diameter/4, $fn=6);

    //                 // Make hole for syringe tip
    //                 // #rotate([180,0,0])
    //                 cylinder(d=3, h=base_height);
    //                 rotate([0,0,100])
    //                 #cube([7,1,base_height*2], center=true);
    //             }
    //             // Outer
    //             // difference(){
    //             //     cylinder(h=base_height, d=cylinder_inner_d); // THE MINUS PART IS ONLY FOR TESTING THE SYRINGE TIP
    //             //     // cylinder(h=base_height, d=cylinder_inner_d-sphere_thickness);
                    
    //             //     // Remove front
    //             //     rotate([0,0,190])
    //             //     translate([-cylinder_diameter,0,0])
    //             //     cylinder(d=cylinder_diameter*2, h=cylinder_diameter/4, $fn=16);

    //             //     // Make hole for syringe tip
    //             //     // #rotate([180,0,0])
    //             //     cylinder(d1=8, d2=7, h=base_height);
    //             // }
    //         }
            

    //     }
        
    //     // Magnets
    //     for (i=[0:100:200]){
    //         rotate([0,0,i])
    //         translate([0,cylinder_inner_d/2,magnet_size[0]-1])
    //         rotate([90,0,0])
    //         cylinder(h=magnet_size[1]+0.1, d=magnet_size[0]+0.2);
    //     }
    //     // #cylinder(d=magnet_size[0]+3,h=8);
        
    // }
    
    // Attachment
    // attach_d1 = 9;
    // attach_d2 = 4.2;
    // attachment_l = 4;
    // donut_r = (attach_d1 - attach_d2) /2;
    // translate([0,0,cylinder_diameter/2-base_height])
    // union(){
    //     difference(){
    //         cylinder(d=attach_d1, h=donut_r);
    //         rotate_extrude(convexity = 10)
    //         translate([attach_d1/2, 0, 0])
    //         circle(r = donut_r, $fn = 100);
    //     }
    //     translate([0,0,-attachment_l])
    //     cylinder(d=attach_d2, h=attachment_l);
    // }
}

module tether_outer(
    cylinder_diameter = 70,
    cylinder_thickness = 3,
    field_of_view = 120,
    n_magnets = 4,
    magnet_size = [6.2,3],
){
    fov_margin = 20;
    not_fov = 360 - field_of_view - 2*fov_margin;
    cylinder_diameter = cylinder_diameter + 0.5;
    tether_thickness = magnet_size[1]+3;
    tether_outer_d = cylinder_diameter + tether_thickness;
    extra_height = 5;
    o_ring_d = 3;
    
    difference(){
        union(){
//            cylinder(h=magnet_size[0]*2, d=large_cylinder_diameter);
            for (i=[-not_fov/2:not_fov/(n_magnets-1):not_fov/2]){
                rotate([0,0,i])
                translate([0,cylinder_diameter/2+magnet_size[0],0])
                rotate([90,0,0])
                cylinder(h=magnet_size[0], d=magnet_size[0]+4);
            }
            difference(){
                translate([0,0,extra_height/2])
                cylinder(h=magnet_size[0]+4+extra_height, d=tether_outer_d, center=true);
                translate([0,0,(magnet_size[0]+4+extra_height)/2])
                o_ring(outer_diam = tether_outer_d, ring_diam = o_ring_d);
                // Remove front
                translate([0,0,-(magnet_size[0]+5)/2])
                pie_slice(field_of_view, cylinder_diameter, magnet_size[0]+5+extra_height);
            }
        }

        // Remove center
        cylinder(h=magnet_size[0]+6+2+extra_height*2, d=cylinder_diameter, center=true);
        
        for (i=[-not_fov/2:not_fov/(n_magnets-1):not_fov/2]){
            rotate([0,0,i])
            translate([0,cylinder_diameter/2+magnet_size[1],0])
            rotate([90,0,0])
            cylinder(h=magnet_size[1]+0.5, d=magnet_size[0]+0.2);
        }
    }
    
}
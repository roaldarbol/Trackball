$fn= $preview ? 60 : 200;
ball_diameter = 50;
ball_coverage = 1/3;
large_cylinder_diameter = 70;
large_cylinder_thickness = 2;
small_cylinder_diameter = 30;
small_cylinder_thickness = 2;
hose_connector = 9.8;
magnet_size = [6.1,3];


// -------- TOP -------- //
module trackball_metabolic_top(
    large_cylinder_diameter = 70,
    small_cylinder_diameter = 40,
    small_cylinder_thickness = 2,
    hose_connector = 10,
    airduct_diameter = 5,
    extra_height = 15,
    hose_on_side = true
){

    outer_height = 10;
    inner_height = 5;
    base_height = hose_connector+5;
    
    cylinder_inner_d = small_cylinder_diameter - (2*small_cylinder_thickness) - 0.2;
    outer_d = large_cylinder_diameter + 5;
    
    
    // Main piece
    difference(){
        union(){
            cylinder(h=base_height + inner_height, d=cylinder_inner_d);
            difference(){
                translate([0,0,(base_height-5)/2])
                rounded_cube(
                    [large_cylinder_diameter+5,large_cylinder_diameter+5,hose_connector+5], 
                    radius=4, 
                    outside=true);
//                cylinder(h=base_height, d=outer_d);

                // Acrylic cylinder for metabolic rate
                translate([0,0,base_height])
                cylinder(d=cylinder_inner_d, h=100);

                // Field of view
                for (i=[-90,0,90]){
                    rotate([0,0,i])
                    translate([0,(large_cylinder_diameter+5)*0.92,(base_height-5)/2])
                    rotate([0,0,45])
                    rounded_cube(
                        [large_cylinder_diameter+5,large_cylinder_diameter+5,hose_connector+5], 
                        radius=4, 
                        outside=true);
                }
                
            }
            
            // Extra width around hose connector
            translate([0,-outer_d/2+5,base_height/2]){
                sphere(d=hose_connector+10);
                rotate([90,0,0])
                cylinder(h=(large_cylinder_diameter)/2-(outer_d/2+15)/2,d=hose_connector+10);
            }
        }
        
        // Remove stuff around cylinder
        // translate([0,0,base_height])
        // difference(){
        //     cylinder(d=large_cylinder_diameter+5, h=100);
        //     cylinder(d=cylinder_inner_d, h=100);
        // }
        
        // Screw holes
        for (i=[-1,1]){
            for (j=[-1,1]){
                translate([i*(large_cylinder_diameter/2 - 5),j*(large_cylinder_diameter/2 - 5),-5/2]){
                    cylinder(h=base_height, d=5);
                    cylinder(h=5, d=9);
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
    
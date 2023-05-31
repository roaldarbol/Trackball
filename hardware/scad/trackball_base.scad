$fa = 1;
$fs = 0.6;
$fn = $preview ? 50 : 200;

// ==== VARIABLES === //

ball_diameter = 50; //22
ball_coverage = 1/3;
hose_connector = 9.8;
airduct_diameter = 3;
extra_height = 20;
magnet_size = [6.2,3];

// Metabolic chamber variables
metabolic_chamber = true;
cylinder_diameter = 70;
cylinder_thickness = 2;

// Non-metabolic chamber variables
sensor_dist = 15;






// === MODULES === //

module rounded_box(points, radius, height){
    hull(){
        for (p = points){
            translate(p) cylinder(r=radius, h=height);
        }
    }
}

module trackball_v1(
        ball_diameter = 22,
        ball_coverage = 1/3,
        sensor_dist = 20,
        hose_connector = 10,
        airduct_diameter = 5,
        extra_height = 15,
        magnet_size = [6,3],
        metabolic_chamber = false,
        cylinder_diameter = 70,
        cylinder_thickness = 2
) {
    ball_diameter = ball_diameter + 1;
    ball_radius = ball_diameter/2;
    top_height = ball_diameter * ball_coverage;
    breakout_corner_radius = 2;
    base_diameter = ball_diameter + sensor_dist + 2*1; //Makes space for the breakout and and edge
    corner_radius = 4;
    tyre_diameter = base_diameter/1.5;
    tyre_radius = tyre_diameter/2;
    
    clearance = 1;
    
    // STANDARD MODEL 
    if (metabolic_chamber==false){
        corner_coord = base_diameter/2 - corner_radius/2;
        points = [  [corner_coord,corner_coord,0], 
                [corner_coord,-corner_coord,0], 
                [-corner_coord,corner_coord,0], 
                [-corner_coord,-corner_coord,0] ];

        echo(height+extra_height);
        difference(){
            union(){
                translate([0,0,extra_height])
                rounded_box(points=points, radius=corner_radius, height=top_height);
                rounded_box(points=points, radius=corner_radius, height=extra_height);
            } // union
            translate([0,0,extra_height+top_height])
            sphere(d = ball_diameter);
            
            // Airflow 
            translate([0,0,extra_height])
            cylinder(d=airduct_diameter, h=base_diameter);
            
            rotate([90,0,-3*360/8]) 
            translate([0,extra_height,-airduct_diameter/2])
            cylinder(d=airduct_diameter, h=base_diameter);
            
            #rotate([90,0,-3*360/8]) 
            translate([0,extra_height,-airduct_diameter/2 + base_diameter/3])
            cylinder(d=hose_connector, h=base_diameter);
            
            // Clearance around hose connector
            rotate([90,0,-3*360/8]) 
            translate([0,extra_height,-airduct_diameter/2 + base_diameter/3 + 30])
            cylinder(d=hose_connector+15, h=base_diameter);
            
            // Acrylic cylinder for metabolic rate
            translate([0,0,height-5])
            difference(){
                cylinder(d=ball_diameter+sensor_dist*2, h=100);
                cylinder(d=ball_diameter+sensor_dist*2-2*3-clearance, h=100);
            }
            
            // Magnets
            for (i=points){
                translate(i)
                cylinder(d=magnet_size[0], h=magnet_size[1]);
            }
        }
    
    // METABOLIC RATE VERSION
    } else {
        corner_coord = cylinder_diameter/2 - corner_radius + 2*1;
        points = [  [corner_coord,corner_coord,0], 
                    [corner_coord,-corner_coord,0], 
                    [-corner_coord,corner_coord,0], 
                    [-corner_coord,-corner_coord,0] ];
        difference(){
            union(){
                translate([0,0,extra_height+10])
                rounded_box(points=points, radius=corner_radius, height=top_height);
                translate([0,0,extra_height])
                rounded_box(points=points, radius=corner_radius, height=10);
                rounded_box(points=points, radius=corner_radius, height=extra_height);
            } // union
            translate([0,0,extra_height+ball_radius+10])
            sphere(d = ball_diameter);
            
            // Airflow 
            translate([0,0,extra_height])
            cylinder(d=airduct_diameter, h=base_diameter);
            
            rotate([90,0,0]) 
            translate([0,extra_height,-airduct_diameter/2])
            cylinder(d=airduct_diameter, h=base_diameter);
            
            // Corner based on Pythagoras
            corner = sqrt((cylinder_diameter/2)^2*2);
            echo(corner);
            
            rotate([90,0,0]) 
            translate([0, extra_height, cylinder_diameter/2-12])
            cylinder(d=hose_connector, h=base_diameter);
            
//            // Clearance around hose connector
//            rotate([90,0,0]) 
//            translate([0,extra_height,corner-10])
//            cylinder(d=hose_connector+18, h=base_diameter);
            
            // Acrylic cylinder for metabolic rate
            translate([0,0,top_height+extra_height])
            difference(){
                cylinder(d=cylinder_diameter+clearance/2, h=100);
                cylinder(d=cylinder_diameter-cylinder_thickness*2, h=100);
            }
            
            // Screw holes
            m4_width = 8.6;
            m4_height = 3.5;
            for (i=[-1,1]){
                for (j=[-1,1]){
                    translate([i*(cylinder_diameter/2 - 5),j*(cylinder_diameter/2 - 5),extra_height+10]){
                        cylinder(h=top_height+1, d=5);
                        translate([0,0,top_height - m4_height - 3])
                        cylinder(d=m4_width, h=m4_height,$fn=6);
                        
                    }
                }
            }
            
            magnet_corner_coord = corner_coord - 4;
            magnet_points = [  [magnet_corner_coord,magnet_corner_coord,0], 
                    [magnet_corner_coord,-magnet_corner_coord,0], 
                    [-magnet_corner_coord,magnet_corner_coord,0], 
                    [-magnet_corner_coord,-magnet_corner_coord,0] ];
            
            // Magnets
            for (i=magnet_points){
                translate(i)
                cylinder(d=magnet_size[0], h=magnet_size[1]);
            }
        } // difference
    }
        
} // END BASE



module trackball_v2(
        ball_diameter = 22, 
        sensor_dist = 20,
        hose_connector = 10,
        airduct_diameter = 5,
        extra_height = 15,
        magnet_size = [6,3]
) {
    ball_diameter = ball_diameter + 1;
    ball_radius = ball_diameter/2;
    breakout_corner_radius = 2;
    base_diameter = ball_diameter + sensor_dist;// + 2*sensor_dist;
    corner_radius = base_diameter/4;
    corner_coord = base_diameter/2 - corner_radius;
    tyre_diameter = base_diameter/1.5;
    tyre_radius = tyre_diameter/2;
    height = tyre_diameter/2;
    sensor_height = height + 21;

    points = [  [corner_coord,corner_coord,0], 
                [corner_coord,-corner_coord,0], 
                [-corner_coord,corner_coord,0], 
                [-corner_coord,-corner_coord,0] ];
    
    // MODEL 
    echo(height+extra_height);
    difference(){
        union(){
            translate([0,0,extra_height])
                intersection(){
                
                    // Rounded box, container
                    rounded_box(points=points, radius=corner_radius, height=height);
                    
                    // Donut, gives the nice curve
                    union(){
                        rotate_extrude(angle=360) {
                        translate([(airduct_diameter + tyre_diameter) / 2, 0])
                            circle(d=tyre_diameter); 
                        } // rotate_extrude
                    
                        difference() {
                            cylinder(h=tyre_diameter,r=tyre_diameter+airduct_diameter,center=true);
                            cylinder(h=tyre_diameter + 1,d=airduct_diameter+tyre_diameter,center=true);
                        } // difference   
                    } // union
                } // intersection
                
        rounded_box(points=points, radius=corner_radius, height=extra_height);
        } // union
        
        // Airflow 
        rotate([90,0,-3*360/8]) 
        translate([0,extra_height,-airduct_diameter/2])
        cylinder(d=airduct_diameter, h=base_diameter);
        
        rotate([90,0,-3*360/8]) 
        translate([0,extra_height,-airduct_diameter/2 + base_diameter/3])
        cylinder(d=airduct_diameter*2, h=base_diameter);
        
        // Magnets
        for (i=points){
            translate(i)
            cylinder(d=magnet_size[0], h=magnet_size[1]);
        }
    } // difference
} // END BASE

            




module trackball_floor(
    ball_diameter = 50,
    ball_coverage = 1/3,
    large_cylinder_diameter = 70,
    large_cylinder_thickness = 2,
    small_cylinder_diameter = 30,
    small_cylinder_thickness = 2
){  
    ball_diameter = ball_diameter + 10;
    floor_height = ball_diameter - (ball_diameter*ball_coverage) - (ball_diameter*0.12);
    
    large_cylinder_inner_d = large_cylinder_diameter - (2*large_cylinder_thickness) - 0.3;
    small_cylinder_inner_d = small_cylinder_diameter - (2*small_cylinder_thickness) - 0.5;
    
    // translate([0,0,ball_diameter/2-ball_diameter*ball_coverage])
    // sphere(d=ball_diameter-4.5);

    difference(){
        cylinder(d=large_cylinder_inner_d, h=floor_height);
        translate([0,0,ball_diameter/2-ball_diameter*ball_coverage])
        sphere(d=ball_diameter);
        
        translate([0,0,ball_diameter/2-ball_diameter*ball_coverage])
        rotate([0,90,0])
        cylinder(d=large_cylinder_inner_d/2, h=large_cylinder_inner_d/2);
    }

    // Make smaller top
    translate([0,0,0.5*ball_diameter+2])
    difference(){
        cylinder(h=2, d=large_cylinder_inner_d);
        translate([0,0,-1])
        cylinder(d1=small_cylinder_diameter+4, d2=small_cylinder_inner_d, h=3);
    }

    // Extra height to surround the new smaller cylinder
    // Make smaller top
    translate([0,0,0.5*ball_diameter+4])
    difference(){
        cylinder(h=2, d=large_cylinder_inner_d);
        translate([0,0,-0.5])
        cylinder(h=3, d=small_cylinder_diameter+0.4);
    }
    
}
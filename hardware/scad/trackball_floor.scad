module trackball_floor(
    ball_diameter = 50,
    ball_coverage = 1/3,
    large_cylinder_diameter = 70,
    large_cylinder_thickness = 2,
    small_cylinder_diameter = 30,
    small_cylinder_thickness = 2
){  
    ball_diameter = ball_diameter + 4;
    ball_radius = ball_diameter / 2;
    floor_height = ball_diameter - (ball_diameter*ball_coverage) - (ball_diameter*0.12);
    
    large_cylinder_inner_d = large_cylinder_diameter - (2*large_cylinder_thickness) - 0.3;
    small_cylinder_inner_d = small_cylinder_diameter - (2*small_cylinder_thickness) - 0.5;
    
    // translate([0,0,ball_diameter/2-ball_diameter*ball_coverage])
    // sphere(d=ball_diameter-4);
    h_extra = ball_radius - ball_diameter*ball_coverage;
    h_cut = h_extra + sqrt((ball_radius)^2 - (small_cylinder_inner_d/2)^2);
    echo(h_cut);

    difference(){
        // cylinder(d=large_cylinder_inner_d, h=floor_height);
        cylinder(d=large_cylinder_inner_d, h=h_cut);
        translate([0,0,ball_diameter/2-ball_diameter*ball_coverage])
        sphere(d=ball_diameter);
        
        translate([0,0,ball_diameter/2-ball_diameter*ball_coverage])
        rotate([0,90,0])
        cylinder(d=large_cylinder_inner_d/2, h=large_cylinder_inner_d/2);
    }
    // %cylinder(h=100, d=26);

    // Make smaller top
    // #translate([0,0,h_cut])
    // difference(){
    //     cylinder(h=2, d=large_cylinder_inner_d);
    //     translate([0,0,-1])
    //     cylinder(d1=ball_diameter*0.8, d2=small_cylinder_inner_d, h=3);
    // }

    // Extra height to surround the new smaller cylinder
    // Make smaller top
    translate([0,0,h_cut])
    difference(){
        cylinder(h=2, d=large_cylinder_inner_d);
        translate([0,0,-0.5])
        cylinder(h=3, d=small_cylinder_diameter+0.4);
    }
    
}
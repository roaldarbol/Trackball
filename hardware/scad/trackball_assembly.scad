use <trackball_base.scad>;
use <trackball_floor.scad>;
use <trackball_lid.scad>;
use <trackball_tether.scad>;

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
small_magnet = [2.2,1.1];

// Metabolic chamber variables
metabolic_chamber = true;
large_cylinder_diameter = 70;
large_cylinder_thickness = 2;
small_cylinder_diameter = 30;
small_cylinder_thickness = 2;
field_of_view = 120;
n_magnets = 3;


// Non-metabolic chamber variables
sensor_dist = 15;

// === GENERATE THE DAMN THING === //
// trackball_v1(
//     ball_diameter = ball_diameter, 
//     ball_coverage = ball_coverage,
//     sensor_dist = sensor_dist,
//     metabolic_chamber = metabolic_chamber,
//     cylinder_diameter = large_cylinder_diameter,
//     cylinder_thickness = large_cylinder_thickness,
//     hose_connector = hose_connector,
//     airduct_diameter = airduct_diameter,
//     extra_height = extra_height,
//     magnet_size = magnet_size
// );

// Metabolic rate chamber parts
// rotate([180,0,0])
// translate([0,0,-120])
// trackball_metabolic_top(
//     large_cylinder_diameter = large_cylinder_diameter,
//     small_cylinder_diameter = small_cylinder_diameter,
//     small_cylinder_thickness = small_cylinder_thickness,
//     hose_connector = hose_connector
//     );
//translate([100,0,0])
// tether_inner(
//     cylinder_diameter = small_cylinder_diameter,
//     cylinder_thickness = small_cylinder_thickness,
//     field_of_view = field_of_view,
//     n_magnets = n_magnets,
//     magnet_size = small_magnet
//     );
// tether_outer(
//     cylinder_diameter = small_cylinder_diameter,
//     cylinder_thickness = small_cylinder_thickness,
//     field_of_view = field_of_view,
//     n_magnets = n_magnets,
//     magnet_size = magnet_size
//     );

// translate([0,0,80+(-ball_diameter/2-10)])
intersection(){
    rotate([180,0,0])
    trackball_floor(
   ball_diameter = ball_diameter,
   ball_coverage = ball_coverage,
   large_cylinder_diameter = large_cylinder_diameter,
   large_cylinder_thickness = large_cylinder_thickness,
   small_cylinder_diameter = small_cylinder_diameter,
   small_cylinder_thickness = small_cylinder_thickness
    );
    cylinder(h=200, d=55, center=true);
}
// trackball_floor(
//    ball_diameter = ball_diameter,
//    ball_coverage = ball_coverage,
//    large_cylinder_diameter = large_cylinder_diameter,
//    large_cylinder_thickness = large_cylinder_thickness,
//    small_cylinder_diameter = small_cylinder_diameter,
//    small_cylinder_thickness = small_cylinder_thickness
// );

// Imaginary parts
// %translate([0,0, ball_diameter/2 + 10 + extra_height])
// sphere(d=ball_diameter);
// %translate([0,0,38])
// difference(){
//     cylinder(d=large_cylinder_diameter, h=40);
//     cylinder(d=large_cylinder_diameter-2*large_cylinder_thickness, h=30);
// }
// %translate([0,0,38+30])
// difference(){
//     cylinder(d=small_cylinder_diameter, h=40);
//     cylinder(d=small_cylinder_diameter-2*small_cylinder_thickness, h=30);
// }
module pie_slice(a, r, h){
  // a:angle, r:radius, h:height
  rotate([0,0,-a/2-90])
  rotate_extrude(angle=a) square([r,h]);
}
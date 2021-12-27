

module box(width, depth, case_height, radius, thickness) {
  difference() {
    union() {
      // 4 top corner spheres
      translate([radius,radius,case_height-radius]) sphere(r=radius,$fn=100);
      translate([width-radius,radius,case_height-radius]) sphere(r=radius,$fn=100);
      translate([radius,depth-radius,case_height-radius]) sphere(r=radius,$fn=100);
      translate([width-radius,depth-radius,case_height-radius]) sphere(r=radius,$fn=100);

      // 4 bottom rectangular prisms
      translate([radius,0*radius,0*radius]) cube([width-2*radius,radius*2,radius*2]);
      translate([radius,depth-2*radius,0*radius]) cube([width-2*radius,radius*2,radius*2]);
      translate([0*radius,radius,0*radius]) cube([2*radius,depth-2*radius,radius*2]);
      translate([width-2*radius,radius,0*radius]) cube([2*radius,depth-2*radius,radius*2]);

	  // top 4 cylinders
      translate([radius,radius,case_height-radius]) rotate([0,90,0]) cylinder(r=radius,h=width-2*radius,$fn=100);
      translate([radius,depth-radius,case_height-radius]) rotate([0,90,0]) cylinder(r=radius,h=width-2*radius,$fn=100);
      translate([radius,radius,case_height-radius]) rotate([-90,0,0]) cylinder(r=radius,h=depth-2*radius,$fn=100);
      translate([width-radius,radius,case_height-radius]) rotate([-90,0,0]) cylinder(r=radius,h=depth-2*radius,$fn=100);

      // 4 corner cylinders going to the base
      translate([radius,radius,0*radius]) cylinder(r=radius,h=case_height-radius,$fn=100);
      translate([radius,depth-radius,0*radius]) cylinder(r=radius,h=case_height-radius,$fn=100);
      translate([width-radius,radius,0*radius])  cylinder(r=radius,h=case_height-radius,$fn=100);
      translate([width-radius,depth-radius,0*radius])  cylinder(r=radius,h=case_height-radius,$fn=100);

      // back
      translate([radius,0,radius]) cube([width-2*radius,thickness,case_height-2*radius]);
      // front
      translate([radius,depth-thickness,radius]) cube([width-2*radius,thickness,case_height-2*radius]);
      // right
      translate([0,radius,radius]) cube([thickness,depth-2*radius,case_height-2*radius]);
      // left
      translate([width-thickness,radius,radius]) cube([thickness,depth-2*radius,case_height-2*radius]);
      // bottom
      translate([radius,radius,0]) cube([width-2*radius,depth-2*radius,thickness]);
      // top
      translate([radius,radius,case_height-thickness]) cube([width-2*radius,depth-2*radius,thickness]);

    }

	union() {
      // cut out the inner quadrants of the corner edge cylinders/prisms
      // bottom
      translate([radius,radius,radius])            cube([width-2*radius,radius*2,radius*2]);
      translate([radius,depth-3*radius,radius]) cube([width-2*radius,radius*2,radius*2]);
      translate([radius,radius,radius])            cube([2*radius,depth-2*radius,radius*2]);
      translate([width-3*radius,radius,radius]) cube([2*radius,depth-2*radius,radius*2]);
      // top
      translate([radius,radius,case_height-3*radius])            cube([width-2*radius,radius+0.01,radius*2]);
      translate([radius,depth-3*radius,case_height-3*radius]) cube([width-2*radius,radius*2,radius*2]);
      translate([radius,radius,case_height-3*radius])            cube([2*radius,depth-2*radius,radius*2]);
      translate([width-3*radius,radius,case_height-3*radius]) cube([2*radius,depth-2*radius,radius*2]);
      // corners
      translate([radius,radius,radius])            cube([2*radius,radius*2,case_height-radius*2]);
      translate([width-3*radius,radius,radius])            cube([2*radius,radius*2,case_height-radius*2]);
      translate([radius,depth-3*radius,radius])            cube([2*radius,radius*2,case_height-radius*2]);
      translate([width-3*radius,depth-3*radius,radius])            cube([2*radius,radius*2,case_height-radius*2]);
    }
  }
}


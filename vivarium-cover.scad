t = 1/10; // thickness unit
h = 45/16; // height
lw = 9/8; // leg-width
bh = 3/2; // bridge height
bo = h - bh; // bridge-vertical offset

in2mm = 100;

module Lip() {
  cube([2*t, t, 6*t], center=true);
}

module Holes() {
  rotate([0, 90, 90]) cylinder(h=t, r=t/4, center=true);
}

module Cutaway() {
  color("tan") {
    translate([0, t/4, bo + t]) cube([3 + t, t, bh - 2*t]);
    translate([3 + t, t/4, t]) cube([1 - 2*t, t, h - 2*t]);
  }
}

module HalfCover() {
  Holes();
  difference() {
    union() {
      translate([0, -t/2, bo]) cube([3, t, bh]);
      translate([3, -t/2, 0]) cube([1, t, h]);
    }
    Cutaway();
    mirror([0, 90, 0]) Cutaway();
  }
  color("green") {
    translate([4, t, 11/8]) scale([1, 1, 3]) Lip();
    translate([3.5, -t, 0]) rotate([0, 90, 0]) Lip();
    translate([3*t, -t, h]) rotate([0, 90, 0]) Lip();
  }
}

scale([in2mm, in2mm, in2mm]) {
  union() {
    HalfCover();
    mirror([90, 0, 0]) HalfCover();
  }
}
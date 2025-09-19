opening_hole_width = 4.8;
opening_hole_length = 3.3;
flange_radius = 8/2;
flange_thickness = 3.0;
cable_radius = 1.45/2;
cable_length = 50;

module wire() {
    // I'm making this as a replacement, so the wire is different
    // from the original design.
    union() {
        translate([cable_radius, 0, 0]) {
            cylinder(r=cable_radius, h=cable_length, center=true, $fn=32);
        }
        translate([-cable_radius, 0, 0]) {
            cylinder(r=cable_radius, h=cable_length, center=true, $fn=32);
        }
    }
}

module plug() {
    union() {
        cube([opening_hole_width, opening_hole_width, opening_hole_length], center=true);
        translate([0, 0, opening_hole_length/2 + flange_thickness/2]) { 
            cylinder(r=flange_radius, h=flange_thickness, center=true, $fn=32);
        }
        // Slight issue with z-fighting, so move it down a bit less
        translate([0, 0, - 0.985* (opening_hole_length/2 + flange_thickness/2)]) {
            difference() {
                cylinder(r=flange_radius, h=flange_thickness, center=true, $fn=32);
                translate([0, flange_radius + opening_hole_width/2 + 0.25, 0]) {
                    cube([flange_radius*2, flange_radius*2, flange_thickness +1], center=true);
                }
            }
        }
    };
}

plug();
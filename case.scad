$fn=100;

// Group of 4 standoffs spaced by dx and dy
module standOffSquare(dx, dy, h, d){
  union(){
    translate([-dx/2,-dy/2,0]) cylinder(h=h, r=d/2);
    translate([ dx/2,-dy/2,0]) cylinder(h=h, r=d/2);
    translate([-dx/2, dy/2,0]) cylinder(h=h, r=d/2);
    // translate([ dx/2, dy/2,0]) cylinder(h=h, r=d/2);
  }
}

module oRings(angle, depth, width) {
    translate([0, 48 / 2, 13]) rotate([-angle, 0, 0]) cube(size=[width, 20, depth], center=true);
    translate([0, -48 / 2, 13]) rotate([angle, 0, 0]) cube(size=[width, 20, depth], center=true);
    translate([0, 48 / 2, -1]) rotate([angle, 0, 0]) cube(size=[width, 20, depth], center=true);
    translate([0, -48 / 2, -1]) rotate([-angle, 0, 0]) cube(size=[width, 20, depth], center=true);
}

module display() {
    color("white") translate([-60 / 2, -43 / 2, 0]) cube(size=[60, 43, 3]);
}

w_pcb = 53;
h_pcb = 37.7;
module pcb() {
    union() {
        // PCB with 3 mounting holes
        difference() {
            color("green") cube(size=[w_pcb, h_pcb, 1], center=true);
            translate([0, 0, -2]) standOffSquare(45.75, 31.1, 5, 3);
        }
        // Camera
        color("black") translate([-w_pcb / 2 + 20.86, h_pcb / 2 - 10.5, 6.5 / 2 + 0.5]) cylinder(h=6.5, r=8.25 / 2, center=true);
        // USB socket
        color("red") translate([7 / 2 - w_pcb / 2 - 1.5, 0, -3.2 / 2 - 1 / 2]) cube(size=[7, 9, 3.2], center=true);
    }
}

tolScale = 1.01;

module box(){
    // ----------
    //  Mockups
    // ----------
    // display();
    // translate([0, 0, -1 / 2 + 8.4]) pcb();
    union() {
        difference() {
            translate([0, 0, 14 / 2 - 1]) cube(size=[65, 48, 14], center=true);
            // Extrusions
            translate([0, 0, -2]) scale(tolScale) cube(size=[60, 43, 10], center=true);
            translate([0, 0, -20 / 2 + 8.4]) scale(tolScale) cube(size=[w_pcb, h_pcb, 20], center=true);
            cavityWidth = 30;
            translate([0, 0, -20 / 2 + 12]) scale(tolScale) cube(size=[37, cavityWidth, 20], center=true);
            // Cutout
            stepWidth = (h_pcb - cavityWidth) / 2;
            translate([22.25, stepWidth / 2 + 1, -20 / 2 + 12]) scale(tolScale) cube(size=[16, cavityWidth + stepWidth - 2, 20], center=true);
            // USB
            translate([-26, 0, 4]) minkowski() {
                cube(size=[5, 9-1.5, 5], center=true);
                sphere(r=1, $fn=20);
            }
            translate([-38.5, 0, 6]) minkowski() {
                cube(size=[20 - 4, 12 - 4, 7 - 4], center=true);
                sphere(r=2.5, $fn=20);
            }
            // CAM
            translate([-w_pcb / 2 + 20.86, h_pcb / 2 - 10.5, 10]) scale(1.02) cylinder(h=20, r=8.25 / 2, center=true);
            // O rings
            translate([27, 0, 0]) oRings(30, 5, 3);
            translate([-28.8, 0, 0]) oRings(30, 5, 3);
        }
        translate([0, 0, 6]) standOffSquare(45.75, 31.1, 7, 3 * 0.98);
    }
}

// Cross - sectional view
// intersection() {
//     box();
//     translate([-100, -50, -50]) cube(size=[100, 100, 100], center=false);
// }

// For export (disable mockups!)
translate([0, 0, 13]) rotate([180, 0, 0]) box();


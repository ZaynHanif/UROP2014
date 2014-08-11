 use <Spiff.scad>;

// Viewport translation -
// the whole model was rotated to catch the light,
// then the viewport was rolled around for a good angle
rotate([ 94.50, 0.00, 113.40 ]) translate([ 8.48, -1.12, 15.65 ])
{
	translate([-150,-100,37]) rotate([25,30,90]){
		translate([0,24, 10]) rotate([45,0,0])
			linear_extrude(height=4) write("Simple");
		translate([0,13, 4]) rotate([30,0,0])
			linear_extrude(height=3) write("variable");
		translate([0,1, 0])  rotate([20,0,0])
			linear_extrude(height=2.5) write("width");
		translate([0,-12, -1])  rotate([5,0,0])
			linear_extrude(height=2) write("text.");
	}
	scale(0.8)translate([6,-36, 2]) rotate([80,0,105])
		# linear_extrude(height=4) write("Spiff.scad");
}

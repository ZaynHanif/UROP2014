$fn = 50;

mount_width = 40;
mount_length = 40;
material_thickness = 6;

mounting_screw_hole_radius = 2;
motor_hole_radius = 5;
hole_radius = 3;

difference(){
	cube([mount_width,mount_length,material_thickness]);

	union(){
		for (i = [[5,5,0],[35,5,0],[35,15,0],[35,35,0]]) {
			translate(i) cylinder (r=mounting_screw_hole_radius, h=material_thickness);
		}	
	
	translate ([8,25,0]) cylinder (r=motor_hole_radius, h=material_thickness);

	translate ([25,25,0]) cylinder (r=hole_radius, h=material_thickness);
	
	}
}
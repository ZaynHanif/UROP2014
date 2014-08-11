$fn = 50;

difference()
{
	union()
	{
		cylinder (r=17, h=10);
		translate([0,20,5]) cube([6,10,10], center=true);
	}
	
	union()
	{
		cylinder (r=15, h=10);
		translate([0,20,5]) cube([1,15,10], center=true);
		translate([-5,21,5]) rotate([0,90,0]) cylinder(r=1.5, h=10);
	}
}

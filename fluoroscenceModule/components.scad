use <box.scad>;
$fn=50;
difference()
{
	union()
	{
		plate(38,40, "top");
	}

	union()
	{
		//bottom plate stuff
		translate([19,20,18]) cylinder(r=13.5, h=5);
		translate([19,20,3]) cylinder(r=9.5, h=20);
	}
}

difference()
{
	union()
	{
		//translate([19,20,21.5])	cylinder(r=12.5,h=2);
	}
	
	union()
	{
	//	translate([19,20,21.5])	cylinder(r=10,h=2);
	}
}
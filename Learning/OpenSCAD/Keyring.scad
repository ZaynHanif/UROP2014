use </home/urop/OpenSCAD/Packages/TextGenerator.scad>;
use </home/urop/OpenSCAD/roundCornersCube.scad>;
use </home/urop/OpenSCAD/Practice/write.scad>;

$fn=30;

module dogTag(FirstName, LastName, Email, Phone)
{
	difference()
	{
		union()
		{
			roundCornersCube(35,50,4,5);
		}

		union()
		{
			translate([0,0,1.5]) roundCornersCube(31,46,1,5);
			translate([0,20,-2]) cylinder(r=2,h=4);
		}
	}

	difference()
	{
		union()
		{
			translate([-14,5,1]) write(FirstName);
			translate([-14,-5,1]) write(LastName);
		}
		union()
		{
			translate([0,0,4]) cube([35,50,4], center=true);
		}
	}

//	translate([-14,5,1]) scale([1,1,1]) drawtext(FirstName);
//	translate([-14,-5,1]) scale([0.8,1,1]) drawtext(LastName);

//	translate([-14,-7,1]) scale([0.4,0.4,1]) drawtext("Email:");
//	translate([-14,-11,1]) scale([0.3,0.4,1]) drawtext(Email);

//	translate([-14,-16,1]) scale([0.4,0.4,1]) drawtext("Phone:");
//	translate([-14,-20,1]) scale([0.4,0.4,1]) drawtext(Phone);
}

dogTag("BNY", "Mellon", "", "");

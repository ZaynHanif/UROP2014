use </home/urop/OpenSCAD/TextGenerator.scad>;
use </home/urop/OpenSCAD/roundCornersCube.scad>;

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

	translate([-14,10,1]) scale([1,1,1]) drawtext(FirstName);
	translate([-14,0,1]) scale([1,1,1]) drawtext(LastName);

	translate([-14,-10,1]) scale([0.4,0.4,1]) drawtext("Email:");
	translate([-14,-14,1]) scale([0.3,0.4,1]) drawtext(Email);

//	translate([-14,-16,1]) scale([0.4,0.4,1]) drawtext("Phone:");
//	translate([-14,-20,1]) scale([0.4,0.4,1]) drawtext(Phone);
}

dogTag("Alex", "Kabla", "ajk61@cam.ac.uk", "");

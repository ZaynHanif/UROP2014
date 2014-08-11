$fn = 50;

// Global Variables
co_radius = 50;
co_height = 30;

module complexObject()
{
	difference()
	{	
		union()
		{
			cylinder (r=co_radius, h=co_height, center=true);
			
			for(r=[0:20])
			{
				rotate([0,0,r*360/20]) translate([co_radius, 0, 0]) cube([10,10,co_height], center=true);
			}
		}

		union()
		{
			for(r=[0:20])
			{
				rotate([0,0,r*360/20]) translate([co_radius*0.75, 0, 0]) cylinder(r=4, h=co_height, center=true);
				rotate([0,0,r*360/20]) translate([co_radius*0.5, 0, 0]) cylinder(r=3, h=co_height, center=true);
			}
		}
	}
}

complexObject();
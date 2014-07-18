/*********************************************************************/
/* 	Modified: 14:25 18/07/2014													*/
/* 	lightingUnit.scad		 														*/
/* 																						*/
/* 	This files contains two modules that create components relating	*/
/* to the filter. They are:														*/
/* 			1. filterPlate - base plate where the filter sits				*/
/* 																						*/
/* 																						*/
/*********************************************************************/


module lighting()
{
	difference()
	{
		union()
		{
			cube([40,12,19]);
			translate([7.5,-5,4]) cube([25,5,11]);
		}

		union()
		{
			translate([8.5,-5,5]) cube([23,5,9]);
			translate([2.5,3,3]) cube([34,12,13]);
			translate([20,5,9.5]) rotate([90,0,0]) cylinder(r=3,h=10);
		}
	}
}

module Lid()
{
	difference()
	{
		union()
		{
			cube([40,2,19]);
			translate([2.75,-5,3.25]) cube([33.5,5,12.5]);
		}

		union()
		{
			translate([3.75,-5,4.25]) cube([31.5,6,10.5]);
			translate([35,3.5,9.5]) rotate([90,0,0]) cylinder(r=1.5, h=9);
			translate([35,-6,8]) cube([7,10,3]);
		}
	}
}
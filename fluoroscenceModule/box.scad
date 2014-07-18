use </home/urop/OpenSCAD/FilterMount.scad>

// Global
$fn=50;
MT = 3; // Material Thickness
Screw = 3; // Screw
ExtraM = 2; //Extra material around screw
ScrewM = Screw+ExtraM; // Thickness of screw support 
CylinderH = 20; // Height of cylinder
CylinderD = 29; // Diameter of optical section
CylinderT = 10; // Thickness of cylinder

/***********************************************************/
/* 																			*/ 
/* END PLATES TO CONNECT ONTO LENS SYSTEM						*/
/* 																			*/
/***********************************************************/
module plate(x,y)
{
	difference()
	{
		union()
		{
			cube([x,y,MT]);
			translate([x/2,y/2,MT]) cylinder(r=CylinderD/2, h=CylinderH);
		}
	
		union()
		{
			translate([x/2,y/2,0]) cylinder(r=(CylinderD-CylinderT)/2,h=CylinderH+MT);

			// Screw Holes
			for (ix = [[(MT+ScrewM)/2,(MT+ScrewM)/2,0],[(MT+ScrewM)/2,y-(MT+ScrewM)/2,0],[x-(MT+ScrewM)/2,(MT+ScrewM)/2,0],[x-(MT+ScrewM)/2,y-(MT+ScrewM)/2,0]])
			{
				translate (ix) cylinder(r=Screw/2, h=MT);
			}
		}
	}
}


module topPlate(x,y)
{
	difference()
	{
		union()
		{
			plate(x,y);
		}

		union()
		{
			translate([x/2,y/2,MT+CylinderH-5]) difference()
			{
				cylinder(r=CylinderD/2,h=5);
				cylinder(r=(CylinderD-5)/2, h=5);
			}
		}
	}
	translate([x/2-16.5,y/2-12,-7]) topFilterSupport();
}


module testtopPlate(x,y)
{
	difference()
	{
		union()
		{
			cube([x,y,2]);
		}
	
		union()
		{
			translate([x/2,y/2,0]) cylinder(r=(CylinderD-CylinderT)/2,h=CylinderH+MT);

			// Screw Holes
			for (ix = [[(MT+ScrewM)/2,(MT+ScrewM)/2,0],[(MT+ScrewM)/2,y-(MT+ScrewM)/2,0],[x-(MT+ScrewM)/2,(MT+ScrewM)/2,0],[x-(MT+ScrewM)/2,y-(MT+ScrewM)/2,0]])
			{
				translate (ix) cylinder(r=Screw/2, h=MT);
			}
		}
	}
	translate([x/2,y/2,-2]) rotate ([180,0,0]) filterPlate();
}


module bottomPlate(x,y)
{
	difference()
	{
		union()
		{
			plate(x,y);
		}

		union()
		{
			translate([x/2,y/2,MT+CylinderH-5]) difference()
			{
				cylinder(r=(CylinderD-4)/2, h=5);
				cylinder(r=(CylinderD-CylinderT)/2,h=5);
			}
			translate([x/2,7.5,20.5]) rotate([90,0,0]) cylinder(r=1.5, h=3);
		}
	}
}

/***********************************************************/
/* 																			*/ 
/* MAIN MODULE WHERE FILTERS SIT									*/
/* 																			*/
/***********************************************************/

module box(x,y,z)
{
	difference()
	{
		union()
		{
			cube([x,y,z]); // Main Body
		}
	
		union()
		{
			// Centre Cutout
			translate([MT,MT,]) cube([x-2*MT, y-2*MT, z]);
			
			// Cut out for screw holes
			for (ix=[[MT/2,MT/2,0],[MT/2,y-(MT/2+ScrewM),0],[x-(MT/2+ScrewM),MT/2,0],[x-(MT/2+ScrewM),y-(MT/2+ScrewM),0]])
			{
				translate(ix) cube([ScrewM,ScrewM,z]);
			}

			// Lighting cutout
			translate([x-MT,y/2 - 12.5,4]) cube([MT,25,11.3]);
		}
	}

	// Screw holes
	for (ix=[[MT/2,MT/2,0],[MT/2,y-(MT/2+ScrewM),0],[x-(MT/2+ScrewM),MT/2,0],[x-(MT/2+ScrewM),y-(MT/2+ScrewM),0]])
	{
		translate(ix) screwHole(z);
	}

	// Groove for filter to slot into
	translate([13,MT-0.5,1]) rotate([0,-45,0]) rightFilterGroove();
	translate([13,y-(MT+4-0.5),1]) rotate([0,-45,0]) leftFilterGroove();

}

module screwHole(z)
{
	difference()
	{
		union()
		{
			cube([ScrewM, ScrewM, z]);
		}
	
		union()
		{	
			for (iz= [0, z*0.75])
			{
				translate([ScrewM/2, ScrewM/2,iz]) cylinder(r=Screw/2, h=z/4);
			}			
		}
	}
}

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


//bottomPlate(40,38);
testtopPlate(40,38);
//box(38,40,30);
//screwHole(30);
//leftFilterGroove();
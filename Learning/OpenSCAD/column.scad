module column(diameter)
{
	module flute()
	{
		union()
		{
			cylinder (r=diameter/20, h=400);
			sphere (r=diameter/20);
		}
	}

	difference()
	{
		cylinder (r=diameter/2, h=600);
		for (i=[1:24])
		{
			rotate([0,0,i*360/24])
			translate([diameter/2,0,200]) flute();
		}
	}
}

column(200);
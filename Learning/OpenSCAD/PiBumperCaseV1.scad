// Globals

difference()
{
	union()
	{
		cube([92,63,5]);
	}

	union()
	{
		translate ([10,10,0]) cube ([72,43,5]);
		translate ([3,3,2]) cube ([85,56,3]);
		translate ([0,18,0]) cube ([10,30,2]); // SD Card
		translate ([88,5,2]) cube ([3,16,3]); // Ethernet Port
		translate ([88,27,2]) cube ([3,15,3]); // USB Ports
		translate ([4,53,1]) cube ([33,4.5,1]); // Soldered Pins
		translate ([61,49,0]) cube ([12,7,2]); // Soldered Pins
		translate ([49,52,0]) cube ([4,3,2]); // Soldered Pins
		translate ([83,25,0]) cube ([5,18,2]); // Soldered Pins
		translate ([76,6,0]) cube ([4.5,4.5,2]); // Soldered Pins
		translate ([17,7,0]) cube ([5,5,2]); // Soldered Pins
	}
}

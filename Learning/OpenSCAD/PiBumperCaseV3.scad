// Globals

difference()
{
	union()
	{
		cube([92,63,5]);
	}

	union()
	{
		translate ([10,10,0]) cube ([71,42,5]);
		translate ([3,3,2]) cube ([86.5,57.5,3]);
		translate ([0,17,0]) cube ([10,32,2]); // SD Card
		translate ([88,5,2]) cube ([3,16,3]); // Ethernet Port
		translate ([88,27,2]) cube ([3,15,3]); // USB Ports
		translate ([4,53,0]) cube ([33,4.5,2]); // Soldered Pins
		translate ([61,52,0]) cube ([12,7,2]); // Soldered Pins
		translate ([49,52,0]) cube ([5,5,2]); // Soldered Pins
		translate ([83,25,0]) cube ([5,19,2]); // Soldered Pins
		translate ([69.5,6,0]) cube ([12,5,2]); // Soldered Pins
		translate ([17,7,0]) cube ([5,5,2]); // Soldered Pins
	}
}

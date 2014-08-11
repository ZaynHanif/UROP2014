difference ()
{
	union()
	{
		translate ([44,29.5,2.5]) difference()
		{
			cube ([88,59,5], center=true);

			union()
			{
				cube ([73,44,5], center=true);
				translate ([0,0,1.5]) cube ([86.5,57.5,2.5], center=true);
			}
		}
	}

	union()
	{
		translate ([0,13,0]) cube ([10,32,2.5]); // SD Card
		translate ([87,3,2.5]) cube ([3,17,2.5]); // Ethernet Port
		translate ([87,25,2.5]) cube ([3,15,2.5]); // USB Ports
		translate ([0,4,4]) cube ([1,10,1]); // Micro USB Port
		translate ([38,0,4]) cube ([15,1,1]); // HDMI Port
		translate ([2,51,0]) cube ([34,6,3]); // Pin Array (Near SD Slot)
		translate ([14,4,0]) cube ([6,3.5,3]); // Chip
		translate ([63,3,0]) cube ([20,10,3]); 
		translate ([77,23,0]) cube ([10,20,3]);
		translate ([42,45,0]) cube ([20,10,3]);
	}
}

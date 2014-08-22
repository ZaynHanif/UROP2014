// OpenSCAD screw thread module
// Produced by Jonathan Waite CUED 2013
// jpw54@cam.ac.uk

/*
      |--h--|

  ~  1|\
  |   | \
  |   |  \
  |   |   \
  |   |    \ 2
  |   |     |   ~
  Z1  |     |   |
  |   |     |   |
  |   |    / 3  |   ~
  |   |   /     Z2  |
  |   |  /      |   Z3
  |   | /       |   |
  ~  0|/        ~   ~
*/

/*		//draw intrenal thread
difference(){
	translate([0,0,1])
		cylinder(8,r=15);
		Thread(8,10,2,36,true);
}
*/
/*		//visualise clearance volume
difference(){
	Thread(8,6,2,36,true);
	translate([0,0,0.1]*1.5)
		Thread(8,6,2,36,false);
}
*/
Thread();

module Thread(radius=10,length=8,pitch=2,steps=36,internal=false,
					threadratio=[0.4,1.0,0.5,0.5],		
					tolerance=0.1){
	
	//convert from ratios to lengths, threaddim=[h, z1, z2, z3]
	threaddim=threadratio*pitch;				
	//add to shaft radius for internal thread
	shaftradius=radius+(internal ? tolerance : 0)*pitch;	
														
	difference(){
		union(){
			//shaft infill
			cylinder(length,r=shaftradius,$fn=steps);		
			//add extra thread to be trimmed for smooth thread ends
			translate([0,0,-pitch])
				DrawThread(radius,length+pitch*2,pitch,threaddim,steps,internal,tolerance);
		}								
		//trim bottom of thread
		translate([0,0,-pitch*1.5])
			cylinder(pitch*1.5,r=(radius+threaddim[0])*1.5);	
		//trim top of thread
		translate([0,0,length])
			cylinder(pitch*1.5,r=(radius+threaddim[0])*1.5);	
	}
}

module DrawThread(radius=10,length=8,pitch=2,
							threaddim=[0.8,2.0,1.0,1.0],
							steps=36,internal=false,tolerance=0.1){

	zinc=pitch/steps;
	stepangle=360/steps;
	//draws thread exactly as long as 'length'
	stepstotal=steps*(length/pitch-1);		

		for (stepscurrent=[0:stepstotal-1]) {
			ThreadElement(radius,threaddim,zinc,stepangle,stepscurrent,tolerance,internal);
		}
}

module ThreadElement(radius=10,threaddim=[0.8,2.0,1.0,1.0],
							zinc=2/360,stepangle=5,stepscurrent=0,
							tolerance=0.1, internal=false){

/* Left-hand face of polyhedron (side A, looking towards thread's centre)

      |--h--|

  ~  1|\
  |   | \
  |   |  \
  |   |   \
  |   |    \ 2
  |   |     |   ~
  Z1  |     |   |
  |   |     |   |
  |   |    / 3  |   ~
  |   |   /     Z2  |
  |   |  /      |   Z3
  |   | /       |   |
  ~  0|/        ~   ~

*/ //Right-hand face (side B) is numbered 4:7

	//add clearances to thread
	thread=threaddim*(1+(internal ? tolerance : -tolerance));	

	thetaA=stepangle*stepscurrent;
	thetaB=thetaA+stepangle;
	z0A=zinc*stepscurrent;
	z0B=z0A+zinc;
	xA=cos(thetaA);
	xB=cos(thetaB);
	yA=sin(thetaA);
	yB=sin(thetaB);
	r=radius;
	R=radius+thread[0];	//thread protrudes from shaft
	
	//draw the element
	polyhedron(		
		points=[
			[r*xA,r*yA,z0A],	   		//0
			[r*xA,r*yA,z0A+thread[1]], //1
			[R*xA,R*yA,z0A+thread[2]], //2
			[R*xA,R*yA,z0A+thread[3]], //3
			[r*xB,r*yB,z0B],    			//4
			[r*xB,r*yB,z0B+thread[1]], //5
			[R*xB,R*yB,z0B+thread[2]],	//6
			[R*xB,R*yB,z0B+thread[3]]	//7
		],
		triangles=[
			[0,1,2],
			[0,2,3],	//left
			[0,4,1],
			[1,4,5],	//back
			[0,3,4],
			[4,3,7],	//bottom
			[2,6,3],
			[3,6,7],	//front
			[1,5,2],
			[2,5,6],	//top
			[4,6,5],
			[4,7,6]	//right
		]
	);
}

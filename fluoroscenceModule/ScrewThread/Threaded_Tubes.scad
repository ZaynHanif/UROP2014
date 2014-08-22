use <connector v1.9.scad>
use <MCAD/regular_shapes.scad>

LensDia=25;
LensSep=25;
LensT=1.5;
WallT=4;
ThreadL=8;

ObD1=26;
ObH1=5;
ObD2=28;
ObH2=9.5;
ObD3=26;	
ObH3=20.5;
ObDMax=max(ObD1,ObD2,ObD3);
gap=2;
flangeT=2;
mountT=3;

render(){

// tube
union(){	
	difference(){
		//outer wall
		cylinder(LensSep-(LensT/2+1),r=LensDia/2+WallT);	
		//bore
		translate([0,0,-1]) 
			cylinder(ThreadL+3,r=LensDia/2);	
		// bottom thread
		screw_connector(LensDia,ThreadL+2,1,1,LensDia+2*WallT);
		// internal slope
		translate([0,0,ThreadL+2])
			cylinder(LensSep-(ThreadL+2+LensT/2+1),r1=LensDia/2+2,r2=LensDia/2-1);
	}
	// top thread
	translate([0,0,LensSep])
		DualThread();
	// bottom lip
	difference(){
		union(){
			cylinder(h=2,r=LensDia/2+WallT+1);
			// chamfer
			translate([0,0,2])
				cylinder(h=2,r1=LensDia/2+WallT+1,r2=LensDia/2+WallT);
		}
		// cut out centre
		cylinder(h=10,r=LensDia/2+WallT);
	}
}



//lens screw
translate([LensDia*1.5,0,0])	
	difference(){
		union(){
			translate([0,0,2])
				screw_connector(LensDia*0.9,ThreadL-4,0,0);
			cylinder(ThreadL,r=LensDia*0.9/2+1);
		}
		//bore
		cylinder(ThreadL,r=LensDia*0.875/2);	
		//grip shape
		translate([0,0,ThreadL]){
			cube([8,LensDia*2,4],true);
			rotate(90,[0,0,1])
				cube([8,LensDia*2,4],true);
		}
	}
	
//locking tool
translate([0,LensDia*1.5,0])
	intersection(){
		translate([0,0,4/2])
			union(){			
				cube([8-0.5,LensDia*2,4],true);
				rotate(90,[0,0,1])
					cube([8-0.5,LensDia*2,4],true);
		}
		difference(){
			cylinder(4,r=LensDia*0.9/2+1,true);
			cube([7,2,4*2],true);
			cube([2,7,4*2],true);
		}
	}


//objective clamp
translate([0,-LensDia*1.5,0])
	translate([0,0,ThreadL+ObH1+ObH2-gap+.5])
	rotate(180,[1,0,0])
	union(){
		// tube thread
		translate([0,0,ObH1+ObH2-gap])
			screw_connector(LensDia,ThreadL,0,1,LensDia+2*WallT);
		//first layer spread compensation
		translate([0,0,ObH1+ObH2-gap+ThreadL])
			difference(){			
				cylinder(.5,r=LensDia/2+1);
				cylinder(.5,r=LensDia/2);
			}
		// hold objective threads
		translate([0,0,ObH2-gap])
			difference(){
				cylinder(ObH1,r=LensDia/2+WallT);
				cylinder(ObH1,r=ObD1/2);
			}
		difference(){
			// clamp thread
			union(){
				translate([0,0,ObH2-gap])
					rotate(180,[1,0,0])
						screw_connector(ObDMax,ObH2-gap,0,1,LensDia+2*WallT);	
				cylinder(ObH2-gap,r=ObDMax/2);	//fill
			}
			// hold objective ring
			cylinder(ObH2,r=ObD2/2);
		}		
	}


//objective nut
translate([-LensDia*1.5,0,0])
	difference(){
		// main body
		cylinder(ObH2-gap+flangeT,r=LensDia/2+WallT+1.5);
		translate([0,0,ObH2-gap+flangeT+.01])
			rotate(180,[1,0,0])
				screw_connector(ObDMax,ObH2-gap,1,1,LensDia+2*WallT);
		// through-hole
		cylinder(ObH2+flangeT,r=ObD3/2);
		// hollow centre
		translate([0,0,flangeT])
			cylinder(ObH2+flangeT,r=ObDMax/2+.1);
	}


//camera mount
translate([LensDia*1.5,LensDia*1.5,0])
	translate([0,0,mountT])
	rotate(180,[0,1,0])
	difference(){
		union(){	
			// top plate shape
			hull(){
				cylinder(mountT,r=35/2);
				translate([13,21/2,0])
					cylinder(mountT,r=3);
				translate([13,-21/2,0])
					cylinder(mountT,r=3);
			}
			translate([0,0,-ThreadL-2])
				cylinder(ThreadL+2,r=LensDia/2+WallT+1);		
		}
		// left holes
		translate([0,21/2,0]){
			cylinder(3,r=1);
			translate([13,0,0])
				cylinder(3,r=1);
		}
		//right holes
		translate([0,-21/2,0]){
			cylinder(3,r=1);
			translate([13,0,0])
				cylinder(3,r=1);
		}
		// camera slot
		translate([18/2-4,0,mountT/2])
			cube([18,9,mountT+.5],true);
		// component slot
		translate([9,5,mountT-1.5])
			cube([4,4,mountT]);
		translate([0,0,-ThreadL-2])
			screw_connector(LensDia,ThreadL+2,1,1,LensDia+2*WallT);
		// hollow centre
		translate([0,0,-ThreadL-2])
			cylinder(ThreadL+2,r=25/2);	
	}


}//end render

//DualThread();


module DualThread(){
	union(){
		difference(){
			screw_connector(LensDia,ThreadL,0,1,LensDia+2*WallT);	//outer thread for tubes
			translate([0,0,ThreadL+0.1])
					rotate(180,[1,0,0])		//invert
						rotate(-90,[0,0,1])	//to synchronise threads after inversion
							screw_connector(LensDia*0.9,ThreadL+0.2,1,0);	
								//inner thread for lens
		}
		rotate(180,[1,0,0])	//rotate below origin
			difference(){
				cylinder(LensT/2+1,r=(LensDia+2*WallT)/2);	//add ring
				cylinder(LensT/2,r=LensDia/2);					// space for lens
				cylinder(LensT/2+1,r=LensDia/2-1);				//
				//translate([0,0,-0.1])
					//cylinder(LensT/2+15,r1=LensDia/2-1.5,r2=LensDia/1.5);
			}
	}
}


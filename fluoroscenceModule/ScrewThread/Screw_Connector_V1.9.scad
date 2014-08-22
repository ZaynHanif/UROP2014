use <OLT_Thread_Module.scad>
use <MCAD/regular_shapes.scad>

//screw_connector(22,30,0,45,4);
dia=25;
base=dia*1.45;
length=8;
h_nut=(length+1.1);
h_bolt=2;
radius=4;
bratio=.5;
cone=0;

//screw_connector(dia,35,0,50,threads);


//Bolt
translate([base/2+1,0,0])
	union(){
		difference(){
			union(){
				rotate(0,[0,0,1])
					hull(){
						translate([(base*bratio-radius),(base*bratio-radius),0])
							cylinder(h_bolt,r=radius);
						translate([(base*bratio-radius),-(base*bratio-radius),0])
							cylinder(h_bolt,r=radius);
						translate([-(base*bratio-radius),(base*bratio-radius),0])
							cylinder(h_bolt,r=radius);
						translate([-(base*bratio-1),-(base*bratio-1),h_bolt/2])
							cube([2,2,h_bolt],true);
					}	
				cylinder(h_bolt,r=base/2);	
			}
			translate([0,0,-1])
				cylinder(h_bolt+2,r=dia/2);
		}
		translate([0,0,h_bolt])
			screw_connector(dia,length,0,cone,base);
	}


//Nut
translate([-(base/2+1),0,0])
	difference(){
		difference(){
			union(){
				rotate(-90,[0,0,1])
					hull(){
						translate([(base*bratio-radius),(base*bratio-radius),0])
							cylinder(h_nut,r=radius);
						translate([(base*bratio-radius),-(base*bratio-radius),0])
							cylinder(h_nut,r=radius);
						translate([-(base*bratio-radius),(base*bratio-radius),0])
							cylinder(h_nut,r=radius);
						translate([-(base*bratio-1),-(base*bratio-1),h_nut/2])
							cube([2,2,h_nut],true);
					}		
				cylinder(h_nut,r=base/2);
			}
			translate([0,0,-1])
				cylinder(h_nut+2,r=dia/2+1);		//cut out centre
		}
		translate([0,0,h_nut+0.5])
			rotate(180,[1,0,0])
				screw_connector(dia,length+2,1,cone,base);
//		translate([0,0,h_nut-3])
	//		cylinder(10,r=dia*0.65);	//clearance ring
	}


module screw_connector(dia=40,height=10,inner=0,angle=1,base=55){
	cone_angle=(angle ? 35 : 0);
	pitch=4;
	tol=0.2;
	r_cone=base/2*(1+(inner ? tol : -tol)/1000);
	threadshape=[0.40,1,0.5,0.5];

	t=dia/20;
	D=dia+2*t;
	alpha=tan(cone_angle);
	h_cone=base/2*alpha;
	z=(base-D)/2*alpha-pitch/2;

	difference(){
		union(){
			Thread(D/2,height,pitch,24,inner,threadshape,tol);
			cone(h_cone,r_cone);
		}
		translate([0,0,-1])
			cylinder(max(height,h_cone)+2,r=dia/2);	//cut out centre
	}
}

//Parametric Thread v0_21
// GPLv2
// (c) 2012 TakeItAndRun

//*************************************************************
//
// 
//
//*************************************************************


// small number, overlap to join adjecent 3D primitives, avoiding paralell faces
e=0.02;

// pi
pi=3.14;

// unit vectors
xaxis=[1,0,0];
yaxis=[0,1,0];
zaxis=[0,0,1];

//*************************************************************
//
// 
//
//*************************************************************

// number of facets of the thread for one revolution
fn=64;

// On an Aver Aspire onenetbook 2*1Ghz, running Windows
// Parametric Thread v0_2 (all module calls removed)
//fn=01 -> rendering time:00min02
//fn=02 -> rendering time:00min06
//fn=04 -> rendering time:00min24
//fn=05 -> rendering time:00min37
//fn=08 -> rendering time:01min29
//fn=64 -> rendering time:1h30min28

// Parametric Thread v0_1
//fn=01 -> rendering time:00min02
//fn=02 -> rendering time:00min06
//fn=04 -> rendering time:00min23
//fn=05 -> rendering time:00min37
//fn=08 -> rendering time:01min30
//fn=10 -> rendering time:02min10
//fn=16 -> rendering time:05min29
//fn=30 -> rendering time:19min24

// F6 (with some processes running in thr background
// without render()
//fn=08 -> rendering time:02min22
// with render()
//fn=08 -> rendering time:02min34

//*************************************************************
//
// dimension of the thread
//
//*************************************************************

// basic diameter
R=10;

// pitch
pitch=1*R;

// height
h=2*pitch;
//h=100;

// trapezeudal thread
// width of th base
h_t=5;
// angle of the faces of the thread
a_t=60;
// deapth of the thread
d_t=2;

//*************************************************************
//
// 
//
//*************************************************************

	for(i=[0:h/pitch*fn-1])
		rotate(360/fn*i,zaxis)translate(pitch/fn*i*zaxis)
		render()
		hull(){
			rotate(90+atan(pitch/(2*pi*R)),xaxis)translate(R*xaxis)
				profile();
			rotate(360/fn,zaxis)translate(pitch/fn*zaxis)rotate(90+atan(pitch/(2*pi*R)),xaxis)translate(R*xaxis)
				profile();
		}
// center 
	translate(-pitch/2*zaxis)cylinder(h=h+pitch,r=R,$fn=fn);


module profile(){
	linear_extrude(height=e,center=true)
		polygon([
			[-e,h_t/2],
			[d_t,(h_t/2-d_t*tan(90-a_t))],
			[d_t,-(h_t/2-d_t*tan(90-a_t))],
			[-e,-h_t/2]
		]);
}









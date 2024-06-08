include <params.scad>
include <util.scad>

use <fingerboard.scad>
use <stabilizer.scad>

BEND_RADIUS = 80;

FINGERBOARD_PCB_LENGTH = FINGERBOARD_FORWARD_EXTENT + FINGERBOARD_REARWARD_EXTENT;
FINGERBOARD_PCB_ANGLE = angleFromLen(BEND_RADIUS, FINGERBOARD_PCB_LENGTH);

PCB_SUPPORT_HEIGHT = 6;
PCB_SUPPORT_MID_HEIGHT = 2;
PCB_SUPPORT_MID_WIDTH = 3;
PCB_SUPPORT_BOTTOM_WIDTH = 8;

BODY_RADIUS = BEND_RADIUS - PCB_SUPPORT_HEIGHT;

BODY_THICKNESS = 8;

ENDHOOK_WIDTH = 8;
ENDHOOK_OVERHANG = 10;
ENDHOOK_PAD_WIDTH = 3;

UNDERCUT_WIDTH = 18;
UNDERCUT_DEPTH = 5;

UNDERCUT_FILL = UNDERCUT_DEPTH + BODY_THICKNESS;

SEPARATION = 15;

module OnArc(x)
{
    RotZ(-angleFromLen(BEND_RADIUS, x)) translate([0,BEND_RADIUS])
        children();
}

module PCBSupport()
{
	ROUNDING_HEIGHT = PCB_SUPPORT_HEIGHT-PCB_SUPPORT_MID_WIDTH/2;
	EXTRA=1;
	pn_pos() {
		translate([0,-PCB_SUPPORT_MID_WIDTH/2]) {
			circle(d=PCB_SUPPORT_MID_WIDTH);
			Rect(PCB_SUPPORT_MID_WIDTH, PCB_SUPPORT_HEIGHT-PCB_SUPPORT_MID_WIDTH/2, ANCHOR_CT);
		}
		polygon([
			[-PCB_SUPPORT_BOTTOM_WIDTH/2,-PCB_SUPPORT_HEIGHT-EXTRA], 
			[PCB_SUPPORT_BOTTOM_WIDTH/2,-PCB_SUPPORT_HEIGHT-EXTRA], 
			[PCB_SUPPORT_MID_WIDTH/2,PCB_SUPPORT_MID_HEIGHT-PCB_SUPPORT_HEIGHT],
			[-PCB_SUPPORT_MID_WIDTH/2,PCB_SUPPORT_MID_HEIGHT-PCB_SUPPORT_HEIGHT]]);
	}
}

module Endhook()
{
	MINOR_HEIGHT = BODY_THICKNESS + PCB_SUPPORT_HEIGHT;
	pn_pos() {
		Rect(ENDHOOK_WIDTH, ENDHOOK_WIDTH + STABILIZER_HEIGHT, ANCHOR_LB, extraY=6);
		translate([0,STABILIZER_HEIGHT]) Rect(ENDHOOK_OVERHANG, ENDHOOK_WIDTH, ANCHOR_RB);
	}

}

module Undercut()
{
LARGE = 1000;
	translate([-UNDERCUT_WIDTH/2, -PCB_SUPPORT_HEIGHT]) RotZ(90) {
		pn_neg() Capsule(UNDERCUT_DEPTH*2, UNDERCUT_WIDTH);
		pn_pos() difference() {
			Capsule(UNDERCUT_FILL*2, UNDERCUT_WIDTH);
			Rect(LARGE, LARGE, ANCHOR_LT);
			translate([-UNDERCUT_DEPTH, 0]) Rect(LARGE, LARGE, ANCHOR_LB);
		}
	}
}

module Clamp()
{
	LARGE = 1000;

	pn_pos() intersection()
	{
		difference() {
			circle(BODY_RADIUS);
			circle(BODY_RADIUS-BODY_THICKNESS);
		}
		polygon([
			[0,0],
			[0, LARGE],
			[-LARGE*tan(FINGERBOARD_PCB_ANGLE), LARGE]]);
	}

	OnArc(-60) PCBSupport();
	OnArc(-40) PCBSupport();
	OnArc(-20) PCBSupport();
	OnArc(0) Endhook();
	OnArc(-FINGERBOARD_PCB_LENGTH + BODY_THICKNESS/2) translate([0,-PCB_SUPPORT_HEIGHT-BODY_THICKNESS/2])
		InterconnectBoltHole();
	OnArc(0) translate([ENDHOOK_WIDTH/2,0])
		InterconnectBoltHole();

	OnArc(0) Undercut();
}

module ClampMain()
{
	color("teal")
	translate([0, -BEND_RADIUS, SEPARATION/2])
		linear_extrude(THICKNESS) pn_top() Clamp();
	color("teal")
	translate([0, -BEND_RADIUS, -SEPARATION/2 - THICKNESS]) 
		linear_extrude(THICKNESS) pn_top() Clamp();

	translate([0, FINGERBOARD_THICKNESS]) 
	RotZ(FINGERBOARD_PCB_ANGLE/2, pivot=[0, -BEND_RADIUS])
	scale([1,-1,1]) pn_top() FingerboardPCB(BEND_RADIUS);

	translate([0,-BEND_RADIUS+FINGERBOARD_THICKNESS]) OnArc(-5) RotZ(180) RotY(90) linear_extrude(THICKNESS) Stabilizer();
}

//ClampMain();

Dekerf() pn_top() Clamp();

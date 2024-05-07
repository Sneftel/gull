// Curved fingerboard PCB shape. Used only by main.scad.

include <util.scad>
include <params.scad>
include <pn.scad>

module TopComponent(radius, x, y, width, height, depth)
{
	EXTRA_HEIGHT = sqrt(pow(radius-FINGERBOARD_THICKNESS, 2) - pow(height/2, 2));
	translate([0,radius,x]) RotZ(angleFromLen(radius, y)) translate([0,-EXTRA_HEIGHT+depth/2,0])
        pn_pos() cube([height, depth, width], center=true);
}

module BottomComponent(radius, x, y, width, height, depth)
{
	translate([0,radius,x]) RotZ(angleFromLen(radius, y)) translate([0,-radius-depth/2,0])
        pn_pos() cube([height, depth, width], center=true);
}

module Components(radius)
{
	TopComponent(radius, -10, 30, 14, 14, 6);
	TopComponent(radius, 10, 30, 14, 14, 6);
	TopComponent(radius, -10, 10, 14, 14, 6);
	TopComponent(radius, 10, 10, 14, 14, 6);
	TopComponent(radius, -10, -10, 14, 14, 6);
	TopComponent(radius, 10, -10, 14, 14, 6);
	TopComponent(radius, -10, -30, 14, 14, 6);
	TopComponent(radius, 10, -30, 14, 14, 6);
	BottomComponent(radius, 0, 35, 10, 2, 5);

}

module FingerboardPCB(radius)
{
	EXTRA = 1;

	REAR_ANGLE = angleFromLen(radius, FINGERBOARD_REARWARD_EXTENT);
	FRONT_ANGLE = angleFromLen(radius, FINGERBOARD_FORWARD_EXTENT);

	color("#FF9209")
	linear_extrude(FINGERBOARD_PCB_WIDTH, center=true)
	translate([0,radius,0])
	RotZ(REAR_ANGLE/2-FRONT_ANGLE/2)
		pn_pos() CocktailSausage(minorRadius=radius-FINGERBOARD_THICKNESS, angle=REAR_ANGLE+FRONT_ANGLE, thickness=FINGERBOARD_THICKNESS);
		
	Components(radius);
}

pn_top() FingerboardPCB(80);

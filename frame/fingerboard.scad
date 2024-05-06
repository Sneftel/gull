// Curved fingerboard PCB shape. Used only by main.scad.

include <util.scad>
include <params.scad>
include <pn.scad>


module FingerboardPCB(radius)
{
	EXTRA = 1;

	REAR_ANGLE = angleFromLen(radius, FINGERBOARD_REARWARD_EXTENT);
	FRONT_ANGLE = angleFromLen(radius, FINGERBOARD_FORWARD_EXTENT);

	color("#FF9209")
	linear_extrude(FINGERBOARD_PCB_WIDTH, center=true)
	translate([0,radius,0])
	RotZ(REAR_ANGLE/2-FRONT_ANGLE/2)
		CocktailSausage(minorRadius=radius-FINGERBOARD_THICKNESS, angle=REAR_ANGLE+FRONT_ANGLE, thickness=FINGERBOARD_THICKNESS);
}

FingerboardPCB(80);
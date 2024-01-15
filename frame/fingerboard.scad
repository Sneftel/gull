include <util.scad>
include <params.scad>
include <pn.scad>

PCB_THICKNESS = 0.8;
PCB_WIDTH = 36;

module FingerboardPCB(radius)
{
	EXTRA = 1;

	REAR_ANGLE = angleFromLen(radius, RIB_REARWARD_EXTENT);
	FRONT_ANGLE = angleFromLen(radius, RIB_FORWARD_EXTENT);

	color("tan")
	linear_extrude(PCB_WIDTH, center=true)
	translate([0,radius,0])
	rotate([0,0,REAR_ANGLE/2-FRONT_ANGLE/2])
	CocktailSausage(minorRadius=radius-PCB_THICKNESS, angle=REAR_ANGLE+FRONT_ANGLE, thickness=PCB_THICKNESS);
}

FingerboardPCB(80);
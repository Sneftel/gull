include <util.scad>
include <params.scad>
include <pn.scad>

LEFT_RIGHT_BOLT_SPACING = 28;
FORWARD_REARWARD_BOLT_SPACING = 16;
CENTERMOST_BOLT_OFFSET = 5;
TAB_PINCH = 10;
TAB_ROUNDING = 10;

module SowPelvis()
{
	TINY = 0.01;
    pn_pos() Rect(4*PELVIS_SPINE_INTERCONNECT_OFFSET, SPINES_OUTER_SPACING, ANCHOR_RC);
    translate([CENTERMOST_BOLT_OFFSET, FORWARD_REARWARD_BOLT_SPACING/2]) InterconnectBoltHole();
    translate([CENTERMOST_BOLT_OFFSET, -FORWARD_REARWARD_BOLT_SPACING/2]) InterconnectBoltHole();
    translate([CENTERMOST_BOLT_OFFSET-LEFT_RIGHT_BOLT_SPACING, 0]) InterconnectBoltHole();

    pn_pos() hull() {
    	translate([CENTERMOST_BOLT_OFFSET, FORWARD_REARWARD_BOLT_SPACING/2]) circle(d=TAB_ROUNDING);
    	translate([CENTERMOST_BOLT_OFFSET, -FORWARD_REARWARD_BOLT_SPACING/2]) circle(d=TAB_ROUNDING);

    	translate([0, SPINES_OUTER_SPACING/2-TAB_PINCH]) circle(d=TINY);
    	translate([0, -SPINES_OUTER_SPACING/2+TAB_PINCH]) circle(d=TINY);
    }

    translate([-4*PELVIS_SPINE_INTERCONNECT_OFFSET, -SPINES_OUTER_SPACING/2]) 
    	Interconnect("front", PELVIS_SPINE_INTERCONNECT_OFFSET) children();
    translate([-4*PELVIS_SPINE_INTERCONNECT_OFFSET, SPINES_OUTER_SPACING/2])
    scale([1,-1])
    	Interconnect("rear", PELVIS_SPINE_INTERCONNECT_OFFSET) children();
}

module SowPelvis_Anchored()
{
	translate([2*PELVIS_SPINE_INTERCONNECT_OFFSET, SPINES_OUTER_SPACING/2-THICKNESS/2])
		SowPelvis() children();
}

Dekerf() pn_top() SowPelvis_Anchored();

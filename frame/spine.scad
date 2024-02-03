// The forward-backward-perpendicular-ish shapes which extend out from the pelvis and support the ribs.

include <util.scad>
include <params.scad>
include <pn.scad>

// PARAMETERS SPECIFIC TO THIS ASSEMBLY

SPINE_RISER_WIDTH = 20;
SPINE_LENGTH = -RIB_C_POS.x + SPINE_RISER_WIDTH/2;

module SpineBase()
{
    LARGE = 1000;

    pn_pos() {
        translate([-SPINE_LENGTH,0])
            square([SPINE_LENGTH, SPINE_BASE_HEIGHT], center=false);
    }

    translate([0,SPINE_BASE_HEIGHT]) rotate([0,0,180]) {
        Interconnect("foo") children();
    }
}

module SpineRiser(name)
{
    LARGE = 1000;
    
    translate([THICKNESS/2, 0])
        pn_pos() Rect(SPINE_RISER_WIDTH, LARGE, ANCHOR_RT, extraY=2*INTER_CONNECTION_OFFSET);

    translate([-SPINE_RISER_WIDTH/2,-5])
        CableGuide();

    translate([THICKNESS/2,2*INTER_CONNECTION_OFFSET]) scale([-1,1,1]) rotate([0,0,-90])
        Interconnect(name) children();
}

module SpineRisers()
{
    LARGE = 1000;

    translate(RIB_A_POS) rotate([0,0,RIB_A_ANGLE]) SpineRiser("riserA") children();
    translate(RIB_B_POS) rotate([0,0,RIB_B_ANGLE]) SpineRiser("riserB") children();
    translate(RIB_C_POS) rotate([0,0,RIB_C_ANGLE]) SpineRiser("riserC") children();

    pn_neg() Rect(LARGE, LARGE, ANCHOR_CT);
}

module Spine()
{
    SpineBase() children();
    SpineRisers() children();
}

module Spine_Anchored()
{
    translate([2*INTER_CONNECTION_OFFSET, -SPINE_BASE_HEIGHT+THICKNESS/2])
        Spine() children();
}

Dekerf() pn_top() Spine_Anchored();

// The forward-backward-perpendicular-ish shapes which extend out from the pelvis and support the ribs.

include <util.scad>
include <params.scad>
include <pn.scad>

SPINE_RISER_WIDTH = 20;
SPINE_LENGTH = -RIB_C_POS.x;
CABLE_TRUNK_HEIGHT = 10;

function trunkX(pos, angle, offset) = pos.x + (pos.y - CABLE_TRUNK_HEIGHT)*tan(angle) + offset;

module SpineBase()
{
    LARGE = 1000;

    pn_pos() Rect(SPINE_LENGTH, SPINE_BASE_HEIGHT, ANCHOR_RB);

    translate([0,SPINE_BASE_HEIGHT]) RotZ(180) {
        Interconnect("foo", PELVIS_SPINE_INTERCONNECT_OFFSET) children();
    }
}

module SpineRiser(name)
{
    LARGE = 1000;
    
    translate([THICKNESS/2, 0])
        pn_pos() Rect(SPINE_RISER_WIDTH, LARGE, ANCHOR_RT, extraY=2*SPINE_RIB_INTERCONNECT_OFFSET);

    translate([-SPINE_RISER_WIDTH/2,0]) RotZ(90)
        CableGuide();

    translate([THICKNESS/2,2*SPINE_RIB_INTERCONNECT_OFFSET]) scale([-1,1,1]) RotZ(-90)
        Interconnect(name, SPINE_RIB_INTERCONNECT_OFFSET) children();
}

module SpineRisers()
{
    LARGE = 1000;

    translate(RIB_A_POS) RotZ(RIB_A_ANGLE) SpineRiser("riserA") children();
    translate(RIB_B_POS) RotZ(RIB_B_ANGLE) SpineRiser("riserB") children();
    translate(RIB_C_POS) RotZ(RIB_C_ANGLE) scale([-1, 1,1]) SpineRiser("riserC") children();

    pn_neg() Rect(LARGE, LARGE, ANCHOR_CT);
}

module SpineTrunks()
{
    TRUNK_X_A = trunkX(RIB_A_POS, RIB_A_ANGLE, -SPINE_RISER_WIDTH/2);
    TRUNK_X_B = trunkX(RIB_B_POS, RIB_B_ANGLE, -SPINE_RISER_WIDTH/2);
    TRUNK_X_C = trunkX(RIB_C_POS, RIB_C_ANGLE, SPINE_RISER_WIDTH/2);

    translate([(TRUNK_X_A+TRUNK_X_B)/2, CABLE_TRUNK_HEIGHT])
        CableGuide();
    translate([TRUNK_X_B, CABLE_TRUNK_HEIGHT])
        CableGuide();
    translate([(TRUNK_X_B+TRUNK_X_C)/2, CABLE_TRUNK_HEIGHT])
        CableGuide();
    translate([TRUNK_X_C, CABLE_TRUNK_HEIGHT])
        CableGuide();
}

module Spine()
{
    SpineBase() children();
    SpineRisers() children();
    SpineTrunks() children();
}

module Spine_Anchored()
{
    translate([2*PELVIS_SPINE_INTERCONNECT_OFFSET, -SPINE_BASE_HEIGHT+THICKNESS/2])
        Spine() children();
}

Dekerf() pn_top() Spine_Anchored();

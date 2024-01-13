include <util.scad>
include <params.scad>
include <pn.scad>

// PARAMETERS SPECIFIC TO THIS ASSEMBLY

SPINE_LENGTH = 160;
SPINE_RISER_WIDTH = 20;

module SpineBase()
{
    LARGE = 1000;

    pn_pos() {
        translate([-SPINE_LENGTH,0,0])
            square([SPINE_LENGTH, SPINE_BASE_HEIGHT], center=false);
    }

    translate([0,SPINE_BASE_HEIGHT]) rotate([0,0,180]) {
        Interconnect("foo") children();
    }
}

module SpineRiser(name)
{
    LARGE = 1000;
    
    pn_pos()
    {
        translate([-SPINE_RISER_WIDTH+THICKNESS/2,-LARGE,0])
            square([SPINE_RISER_WIDTH, LARGE+2*INTER_CONNECTION_OFFSET], center=false);
    }

    translate([THICKNESS/2,2*INTER_CONNECTION_OFFSET]) scale([-1,1,1]) rotate([0,0,-90])
        Interconnect(name) children();
}

module SpineRisers()
{
    translate(RIB_A_POS) rotate([0,0,RIB_A_ANGLE]) SpineRiser("riserA") children();
    translate(RIB_B_POS) rotate([0,0,RIB_B_ANGLE]) SpineRiser("riserB") children();
    translate(RIB_C_POS) rotate([0,0,RIB_C_ANGLE]) SpineRiser("riserC") children();

    pn_neg() {
        LARGE = 1000;
        translate([-LARGE/2, -LARGE]) square([LARGE, LARGE], center=false);
    }
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

pn_top() Spine_Anchored();

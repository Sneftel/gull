include <util.scad>
include <params.scad>

// PARAMETERS SPECIFIC TO THIS ASSEMBLY

SPINE_LENGTH = 160;
SPINE_RISER_WIDTH = 20;



module SpineRiser_Pos()
{
    LARGE = 1000;
    
    translate([-SPINE_RISER_WIDTH+THICKNESS/2,-LARGE,0])
        square([SPINE_RISER_WIDTH, LARGE+2*INTER_CONNECTION_OFFSET], center=false);
}

module SpineRiser_Neg()
{
    LARGE = 1000;
    
    translate([-SPINE_RISER_WIDTH+THICKNESS/2,-LARGE,0]) {
        translate([SPINE_RISER_WIDTH-THICKNESS,LARGE, 0])
            square([THICKNESS,2*INTER_CONNECTION_OFFSET], center=false);
        translate([SPINE_RISER_WIDTH-THICKNESS,LARGE+INTER_CONNECTION_OFFSET,0]) rotate([0,0,-90])
            TSlot();
        translate([SPINE_RISER_WIDTH-THICKNESS/2, LARGE-INTER_CONNECTION_OFFSET, 0])
            circle(d=INTERCONNECT_BOLT_DIAMETER);
    }
}

module SpineRiser()
{
    difference() {
        SpineRiser_Pos();
        SpineRiser_Neg();
    }
}

module SpineBase_Pos()
{
    translate([-SPINE_LENGTH,0,0])
        square([SPINE_LENGTH, SPINE_BASE_HEIGHT], center=false);
}

module SpineBase_Neg()
{
    LARGE = 1000;
    
    translate([-2*INTER_CONNECTION_OFFSET, SPINE_BASE_HEIGHT-THICKNESS, 0])
        square([2*INTER_CONNECTION_OFFSET, LARGE], center=false);
    translate([-INTER_CONNECTION_OFFSET, SPINE_BASE_HEIGHT-THICKNESS, 0])
        TSlot();
    translate([-3*INTER_CONNECTION_OFFSET, SPINE_BASE_HEIGHT-THICKNESS/2, 0])
        circle(d=INTERCONNECT_BOLT_DIAMETER);
}

module SpineBase()
{
    difference() {
        SpineBase_Pos();
        SpineBase_Neg();
    }
}

module Spine_Risers_Pos()
{
    intersection()
    {
        LARGE = 1000;
        translate([-LARGE/2, 0]) square([LARGE, LARGE], center=false);
        union()
        {
            translate(RIB_A_POS) rotate([0,0,RIB_A_ANGLE]) SpineRiser_Pos();
            translate(RIB_B_POS) rotate([0,0,RIB_B_ANGLE]) SpineRiser_Pos();
            translate(RIB_C_POS) rotate([0,0,RIB_C_ANGLE]) SpineRiser_Pos();
        }
    }
}

module Spine_Risers_Neg()
{
    intersection()
    {
        LARGE = 1000;
        translate([-LARGE/2, 0]) square([LARGE, LARGE], center=false);
        union()
        {
            translate(RIB_A_POS) rotate([0,0,RIB_A_ANGLE]) SpineRiser_Neg();
            translate(RIB_B_POS) rotate([0,0,RIB_B_ANGLE]) SpineRiser_Neg();
            translate(RIB_C_POS) rotate([0,0,RIB_C_ANGLE]) SpineRiser_Neg();
        }
    }
}

module Spine_Pos()
{
    SpineBase_Pos();
    Spine_Risers_Pos();
}

module Spine_Neg()
{
    SpineBase_Neg();
    Spine_Risers_Neg();
}

module Spine()
{
    difference()
    {
        Spine_Pos();
        Spine_Neg();
    }
}

Spine();



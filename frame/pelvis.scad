include <util.scad>
include <params.scad>
include <pn.scad>

module PelvisLeftSide()
{
    EXTRA = 1;
    BIG = 100;

    pn_pos() {
        translate([-PELVIS_REAR_HALF_WIDTH,-SPINES_OUTER_SPACING,0])
            square([BIG, SPINES_OUTER_SPACING], center=false);
    }

    pn_neg() {
        translate([-PELVIS_REAR_HALF_WIDTH-EXTRA,-THICKNESS,0])
            square([2*INTER_CONNECTION_OFFSET+EXTRA,THICKNESS+EXTRA], center=false);
        translate([-PELVIS_REAR_HALF_WIDTH+INTER_CONNECTION_OFFSET,-THICKNESS,0])
            TSlot();
        translate([-PELVIS_REAR_HALF_WIDTH+3*INTER_CONNECTION_OFFSET,-THICKNESS/2,0])
            circle(d=INTERCONNECT_BOLT_DIAMETER);
        translate([-PELVIS_REAR_HALF_WIDTH-EXTRA,-SPINES_OUTER_SPACING-EXTRA,0])
            square([2*INTER_CONNECTION_OFFSET+EXTRA,THICKNESS+EXTRA], center=false);
        translate([-PELVIS_REAR_HALF_WIDTH+INTER_CONNECTION_OFFSET,-SPINES_OUTER_SPACING + THICKNESS,0])
        rotate([0,0,180])
            TSlot();        
        translate([-PELVIS_REAR_HALF_WIDTH+3*INTER_CONNECTION_OFFSET,-SPINES_OUTER_SPACING + THICKNESS/2,0])
            circle(d=INTERCONNECT_BOLT_DIAMETER);
    }
}

module ClippedPelvisLeftSide()
{
    BIG = 100;

    difference() {
        rotate([0,0,-PELVIS_HALF_ANGLE])
            PelvisLeftSide();
        translate([0,-BIG,0])
            square([BIG,2*BIG], center=false);
    }
}

module ClippedPelvisRightSide()
{
    scale([-1,1,1])
        ClippedPelvisLeftSide();
}

module Pelvis_Pos()
{
    ClippedPelvisLeftSide();
    ClippedPelvisRightSide();
}

module CenterboardCutout()
{
    
}

module Pelvis()
{
    pn_top() {
        ClippedPelvisLeftSide();
        ClippedPelvisRightSide();
    }
}

Pelvis();

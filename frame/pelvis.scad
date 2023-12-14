include <util.scad>
include <params.scad>

// PARAMETERS SPECIFIC TO THIS ASSEMBLY

module PelvisLeftSide_Pos()
{
    BIG = 100;
    translate([-PELVIS_REAR_HALF_WIDTH,-SPINES_OUTER_SPACING,0])
        square([BIG, SPINES_OUTER_SPACING], center=false);
}

module PelvisLeftSide_Neg()
{
    EXTRA = 1;
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

module PelvisLeftSide()
{
    difference() {
        PelvisLeftSide_Pos();
        PelvisLeftSide_Neg();
    }
}

//PelvisLeftSide();


module ClippedPelvisLeftSide_Pos()
{
    BIG = 100;
    difference() {
        rotate([0,0,-PELVIS_HALF_ANGLE])
            PelvisLeftSide_Pos();
        translate([0,-BIG,0])
            square([BIG,2*BIG], center=false);
    }
}

module ClippedPelvisLeftSide_Neg()
{
    rotate([0,0,-PELVIS_HALF_ANGLE])
        PelvisLeftSide_Neg();
}

module ClippedPelvisLeftSide()
{
    difference() {
        ClippedPelvisLeftSide_Pos();
        ClippedPelvisLeftSide_Neg();
    }
}

module ClippedPelvisRightSide_Pos()
{
    scale([-1,1,1])
        ClippedPelvisLeftSide_Pos();
}

module ClippedPelvisRightSide_Neg()
{
    scale([-1,1,1])
        ClippedPelvisLeftSide_Neg();
}

module ClippedPelvisRightSide()
{
    difference() {
        ClippedPelvisRightSide_Pos();
        ClippedPelvisRightSide_Neg();
    }
}

module Pelvis_Pos()
{
    ClippedPelvisLeftSide_Pos();
    ClippedPelvisRightSide_Pos();
}

module CenterboardCutout()
{
    
}

module Pelvis_Neg()
{
    ClippedPelvisLeftSide_Neg();
    ClippedPelvisRightSide_Neg();
}

module Pelvis()
{
    difference() {
        Pelvis_Pos();
        Pelvis_Neg();
    }
}

Pelvis();
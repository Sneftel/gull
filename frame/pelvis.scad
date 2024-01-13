include <util.scad>
include <params.scad>
include <pn.scad>

module PelvisSide(side)
{
    EXTRA = 1;
    BIG = 100;

    pn_pos() {
        translate([-PELVIS_REAR_HALF_WIDTH,-SPINES_OUTER_SPACING,0])
            square([BIG, SPINES_OUTER_SPACING], center=false);
    }

    translate([-PELVIS_REAR_HALF_WIDTH,0]) scale([1,-1,1])
        Interconnect(str(side, "_", "rear")) children();

    translate([-PELVIS_REAR_HALF_WIDTH, -SPINES_OUTER_SPACING])
        Interconnect(str(side, "_", "front")) children();
}

module ClippedPelvisSide(side)
{
    BIG = 100;

    difference() {
        rotate([0,0,-PELVIS_HALF_ANGLE])
            PelvisSide(side) children();
        translate([0,-BIG,0])
            square([BIG,2*BIG], center=false);
    }
}

module ClippedPelvisLeftSide()
{
    ClippedPelvisSide("left") children();
}

module ClippedPelvisRightSide()
{
    scale([-1,1,1])
        ClippedPelvisSide("right") children();
}

module Pelvis_Pos()
{
    ClippedPelvisLeftSide() children();
    ClippedPelvisRightSide() children();
}

module CenterboardCutout()
{
    
}

module Pelvis()
{
    ClippedPelvisLeftSide() children();
    ClippedPelvisRightSide() children();
}

pn_top() Pelvis();

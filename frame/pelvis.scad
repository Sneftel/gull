// The horizontal center shape, which joins to the four spines and supports the center PCB

include <util.scad>
include <params.scad>
include <pn.scad>

module PelvisSide(side)
{
    EXTRA = 1;
    BIG = 100;

    pn_pos() Rect(BIG, SPINES_OUTER_SPACING, ANCHOR_LT, extraX=PELVIS_REAR_HALF_WIDTH);

    translate([-PELVIS_REAR_HALF_WIDTH,0]) scale([1,-1,1])
        Interconnect(str(side, "_", "rear"), PELVIS_SPINE_INTERCONNECT_OFFSET) children();

    translate([-PELVIS_REAR_HALF_WIDTH, -SPINES_OUTER_SPACING])
        Interconnect(str(side, "_", "front"), PELVIS_SPINE_INTERCONNECT_OFFSET) children();
}

module ClippedPelvisSide(side)
{
    LARGE = 1000;

    difference() {
        rotate([0,0,-PELVIS_HALF_ANGLE])
            PelvisSide(side) children();
        pn_pos() Rect(LARGE, LARGE, ANCHOR_LC);
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

CENTERBOARD_REARWARD_OFFSET = -7;
REAR_MOUNTING_HOLE_DISTANCE = 25;
FRONT_MOUNTING_HOLE_DISTANCE = 22;
FRONT_TO_REAR_MOUNTING_HOLE_DISTANCE = 32;
PCB_MOUNT_MARGIN = 0;

module PCBMount()
{
    translate([0, CENTERBOARD_REARWARD_OFFSET])
    {
        pn_pos() {
        translate([-REAR_MOUNTING_HOLE_DISTANCE/2-PCB_MOUNT_MARGIN, -FRONT_TO_REAR_MOUNTING_HOLE_DISTANCE-PCB_MOUNT_MARGIN])
            square([REAR_MOUNTING_HOLE_DISTANCE+2*PCB_MOUNT_MARGIN, FRONT_TO_REAR_MOUNTING_HOLE_DISTANCE+2*PCB_MOUNT_MARGIN], center=false);
        }
        translate([-REAR_MOUNTING_HOLE_DISTANCE/2, 0])
            InterconnectBoltHole();
        translate([REAR_MOUNTING_HOLE_DISTANCE/2, 0])
            InterconnectBoltHole();
        translate([-FRONT_MOUNTING_HOLE_DISTANCE/2, -FRONT_TO_REAR_MOUNTING_HOLE_DISTANCE])
            InterconnectBoltHole();
        translate([FRONT_MOUNTING_HOLE_DISTANCE/2, -FRONT_TO_REAR_MOUNTING_HOLE_DISTANCE])
            InterconnectBoltHole();
    }
}

module Pelvis()
{
    ClippedPelvisLeftSide() children();
    ClippedPelvisRightSide() children();
    PCBMount() children();
}

Dekerf() pn_top() Pelvis();

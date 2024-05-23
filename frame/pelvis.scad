// The horizontal center shape, which joins to the four spines and supports the center PCB

include <util.scad>
include <params.scad>
include <pn.scad>

// The shift of the PCB towards the rear
CENTERBOARD_REARWARD_OFFSET = -7;

// The distance between the rear PCB mounting hole centers
REAR_MOUNTING_HOLE_DISTANCE = 25;

// The distance between the front PCB mounting hole centers
FRONT_MOUNTING_HOLE_DISTANCE = 22;

// The distance between the front and rear PCB mounting hole centers
FRONT_TO_REAR_MOUNTING_HOLE_DISTANCE = 32;

// Extra "guaranteed" material around the PCB mounting footprint
PCB_MOUNT_MARGIN = 0;

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
        RotZ(-PELVIS_HALF_ANGLE)
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

RotZ(-PELVIS_HALF_ANGLE) Dekerf() pn_top() Pelvis();

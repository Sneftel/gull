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

CENTERBOARD_REARWARD_OFFSET = -7;
REAR_MOUNTING_HOLE_DISTANCE = 22;
FRONT_MOUNTING_HOLE_DISTANCE = 25;
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

pn_top() Pelvis();

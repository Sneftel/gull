// The "neck" of the thumb cluster which extends perpendicularly from the body and holds one key.

include <util.scad>
include <params.scad>
include <tccommon.scad>
include <pn.scad>

NECK_STEM_WIDTH = 30;
NECK_STEM_LENGTH = 14;

// A hack, because the PCB assumes 8mm thickness
TC_THICKNESS = 8;

module TCNeck()
{
    LARGE = 1000;

    translate([-TC_PCB_WIDTH/2,TC_INTER_PADDLE_RADIUS])
    rotate([0,0,-TC_INTER_PADDLE_ANGLE])
    translate([-TC_PCB_WIDTH/2,-TC_INTER_PADDLE_RADIUS]) {
        BodyArm();
        translate([TC_PCB_WIDTH/2,TC_INTER_PADDLE_RADIUS])
        rotate([0,0,TC_INTER_PADDLE_ANGLE/2])
            TCElbow();

        pn_pos() {
            translate([-TC_PCB_WIDTH/2,-TC_ARM_HEIGHT/2])
                circle(d=TC_ARM_HEIGHT);
        }
    }

    BodyHalfArm();
    
    pn_pos() translate([THICKNESS/2, 0]) Rect(NECK_STEM_WIDTH, TC_ARM_HEIGHT + NECK_STEM_LENGTH, ANCHOR_RT);

    pn_neg() Rect(THICKNESS, TC_ARM_HEIGHT, ANCHOR_CT);

    translate([0,-TC_ARM_HEIGHT - TC_INTERCONNECT_OFFSET]) {
        InterconnectBoltHole();
        pn_anchor("TCBody") children();
    }

    translate([-NECK_STEM_WIDTH, 2*TC_INTERCONNECT_OFFSET-TC_PUSHOUT]) rotate([0,0,-90])
        Interconnect("foo", TC_INTERCONNECT_OFFSET, horizontalKeepout=0) children();
}

module TCNeck_Anchored()
{
    translate([NECK_STEM_WIDTH-THICKNESS/2, TC_PUSHOUT])
        TCNeck() children();
}

Dekerf() pn_top() TCNeck_Anchored();
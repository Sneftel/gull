// The "neck" of the thumb cluster which extends perpendicularly from the body and holds one key.

include <util.scad>
include <params.scad>
include <tccommon.scad>
include <pn.scad>

NECK_STEM_WIDTH = 14;
NECK_STEM_LENGTH = 8;

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
    
    translate([-TC_THICKNESS/2, 0])
        pn_pos() Rect(NECK_STEM_WIDTH, TC_ARM_HEIGHT + NECK_STEM_LENGTH, ANCHOR_TR);

    BodyArm();
    
    pn_neg() Rect(LARGE, LARGE, ANCHOR_CL, extraX=TC_THICKNESS/2);

    translate([-TC_THICKNESS/2, -TC_ARM_HEIGHT]) rotate([0,0,-90])
        InterconnectTSlot();
}

module TCNeck_Anchored()
{
    translate([TC_THICKNESS/2, TC_ARM_HEIGHT])
        TCNeck() children();
}

pn_top() TCNeck();
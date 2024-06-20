// The "neck" of the thumb cluster which extends perpendicularly from the body and holds one key.

include <util.scad>
include <params.scad>
include <tccommon.scad>
include <pn.scad>


// A hack, because the PCB assumes 8mm thickness
TC_THICKNESS = 8;

module TCNeckMain()
{
    LARGE = 1000;

    translate([-TC_PCB_WIDTH/2,TC_INTER_PADDLE_RADIUS])
    RotZ(-TC_INTER_PADDLE_ANGLE)
    translate([-TC_PCB_WIDTH/2,-TC_INTER_PADDLE_RADIUS]) {
        BodyArm();
        translate([TC_PCB_WIDTH/2,TC_INTER_PADDLE_RADIUS])
        RotZ(TC_INTER_PADDLE_ANGLE/2)
            TCElbow();

        pn_pos() {
            translate([-TC_PCB_WIDTH/2,-TC_ARM_HEIGHT/2])
                circle(d=TC_ARM_HEIGHT);
        }
    }

    BodyHalfArm();
}

module RibNeckInterconnect()
{
    translate([-THICKNESS/2, 0]) scale([1,-1,1]) RotZ(-90)
        Interconnect("foo", TC_INTERCONNECT_OFFSET, horizontalKeepout=0) children();
}

module NeckBodyInterconnect()
{
    translate([TC_INWARD_SHIFT, TC_REARWARD_SHIFT])
    {
        translate([-THICKNESS/2,-TC_ARM_HEIGHT - TC_INTERCONNECT_OFFSET]) {
            InterconnectBoltHole();
            pn_pos() Rect(TC_INWARD_SHIFT-THICKNESS, TC_INTERCONNECT_OFFSET*2, ANCHOR_RB, extraX=THICKNESS/2, extraY=INTERCONNECT_WASHER_DIAMETER/2);
            pn_anchor("TCBody") children();
        }

        pn_neg() Rect(THICKNESS, TC_ARM_HEIGHT, ANCHOR_RT);
        translate([-THICKNESS, -TC_ARM_HEIGHT]) ClearedCorner(225);
    }
}

module TCNeck()
{
    translate([0,-TC_INTERCONNECT_OFFSET*2]) {
        RibNeckInterconnect();

        translate([TC_INWARD_SHIFT-THICKNESS/2, TC_REARWARD_SHIFT]) TCNeckMain();

        NeckBodyInterconnect() children();
    }
}

Dekerf() pn_top() TCNeck();

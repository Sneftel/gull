// The body of the thumb cluster, including three keys. This shape is not output directly, but
// incorporated into the "A" ribs.

include <util.scad>
include <params.scad>
include <tccommon.scad>

TCBODY_STEM_WIDTH = 14;

module TCBodyLeftSide()
{
    // body arm
    translate([-TC_PCB_WIDTH/2,TC_INTER_PADDLE_RADIUS])
    RotZ(-TC_INTER_PADDLE_ANGLE)
    translate([-TC_PCB_WIDTH/2,-TC_INTER_PADDLE_RADIUS]) {
        BodyArm();

        translate([-TC_PCB_WIDTH/2,-TC_ARM_HEIGHT/2])
            pn_pos() circle(d=TC_ARM_HEIGHT);
    }

    // elbow
    translate([-TC_PCB_WIDTH/2,TC_INTER_PADDLE_RADIUS])
    RotZ(-TC_INTER_PADDLE_ANGLE/2)
        TCElbow();
}

module TCBodyRightSide()
{
    scale([-1,1,1]) TCBodyLeftSide();
}


module TCBody()
{
    translate([0,TC_ARM_HEIGHT+TC_INTERCONNECT_OFFSET]) {
        // Center body arm
        BodyArm();

        TCBodyLeftSide();
        TCBodyRightSide();
    }

    translate([-THICKNESS/2,0]) {
        pn_pos() Rect(TCBODY_STEM_WIDTH,TC_INTERCONNECT_OFFSET,ANCHOR_RT,extraY=TC_ARM_HEIGHT);
        RotZ(-90) InterconnectTSlot();
        translate([0, TC_INTERCONNECT_OFFSET]) ClearedCorner(135, r=0.01);
    }
}

Dekerf() pn_top() TCBody();

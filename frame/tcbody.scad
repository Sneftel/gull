// The body of the thumb cluster, including three keys. This shape is not output directly, but
// incorporated into the "A" ribs.

include <util.scad>
include <params.scad>
include <tccommon.scad>

module TCBodyLeftSide()
{
    // body arm
    translate([-TC_PCB_WIDTH/2,TC_INTER_PADDLE_RADIUS])
    rotate([0,0,-TC_INTER_PADDLE_ANGLE])
    translate([-TC_PCB_WIDTH/2,-TC_INTER_PADDLE_RADIUS]) {
        BodyArm();

        translate([-TC_PCB_WIDTH/2,-TC_ARM_HEIGHT/2])
            pn_pos() circle(d=TC_ARM_HEIGHT);
    }

    // elbow
    translate([-TC_PCB_WIDTH/2,TC_INTER_PADDLE_RADIUS])
    rotate([0,0,-TC_INTER_PADDLE_ANGLE/2])
        TCElbow();
}

module TCBodyRightSide()
{
    scale([-1,1,1]) TCBodyLeftSide();
}

module TCBody()
{
    // Center body arm
    BodyArm();

    TCBodyLeftSide();
    TCBodyRightSide();

    translate([0, -TC_ARM_HEIGHT]) {
        InterconnectBoltHole();
        pn_anchor("tcHole") children();
    }
}

module TCBody_Anchored()
{
    translate([0,TC_ARM_HEIGHT])
        TCBody() children();
}

Dekerf() pn_top() TCBody();

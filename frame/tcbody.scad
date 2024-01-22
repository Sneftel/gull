include <util.scad>
include <params.scad>
include <tccommon.scad>

// PARAMETERS SPECIFIC TO THIS ASSEMBLY

module TCBodyLeftSide()
{
    // body arm
    translate([-TC_PCB_WIDTH/2,TC_INTER_PADDLE_RADIUS,0])
    rotate([0,0,-TC_INTER_PADDLE_ANGLE])
    translate([-TC_PCB_WIDTH/2,-TC_INTER_PADDLE_RADIUS,0])
    union() {
        BodyArm();

        pn_pos() {
            translate([-TC_PCB_WIDTH/2,-TC_ARM_HEIGHT/2,0])
                circle(d=TC_ARM_HEIGHT);
        }
    }

    // elbow
    translate([-TC_PCB_WIDTH/2,TC_INTER_PADDLE_RADIUS,0])
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
    /*
    // Stem
    pn_pos() {
        translate([-TCBODY_STEM_WIDTH/2, -TC_ARM_HEIGHT - TCBODY_STEM_LENGTH])
            square([TCBODY_STEM_WIDTH,TCBODY_STEM_LENGTH], center=false);
    }
*/
    translate([0, -TC_ARM_HEIGHT])
    {
        InterconnectBoltHole();
        pn_anchor("tcHole") children();
    }
}

module TCBody_Anchored()
{
    translate([0,TC_ARM_HEIGHT])
        TCBody() children();
}

pn_top() TCBody();

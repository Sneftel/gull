include <util.scad>
include <params.scad>
include <tccommon.scad>

NECK_STEM_WIDTH = 12;
NECK_STEM_LENGTH = 8;
module TCNeck_Pos()
{
    LARGE = 1000;

    translate([-TC_PADDLE_WIDTH/2,TC_INTER_PADDLE_RADIUS,0])
    rotate([0,0,-TC_INTER_PADDLE_ANGLE])
    translate([-TC_PADDLE_WIDTH/2,-TC_INTER_PADDLE_RADIUS,0])
    union() {
        BodyArm_Pos();
        translate([TC_PADDLE_WIDTH/2,TC_INTER_PADDLE_RADIUS,0])
        rotate([0,0,TC_INTER_PADDLE_ANGLE/2])
            TCElbow_Pos();
        translate([-TC_PADDLE_WIDTH/2,-TC_ARM_HEIGHT/2,0])
            circle(d=TC_ARM_HEIGHT);
    }
    
    difference() {
        BodyArm_Pos();
        translate([-THICKNESS/2, -LARGE/2])
            square([LARGE,LARGE]);
    }
    
    translate([-NECK_STEM_WIDTH - THICKNESS/2, -TC_ARM_HEIGHT - NECK_STEM_LENGTH])
        square([NECK_STEM_WIDTH, TC_ARM_HEIGHT + NECK_STEM_LENGTH], center=false);
}

module TCNeck_Neg()
{
    LARGE = 1000;

    translate([-TC_PADDLE_WIDTH/2,TC_INTER_PADDLE_RADIUS,0])
    rotate([0,0,-TC_INTER_PADDLE_ANGLE])
    translate([-TC_PADDLE_WIDTH/2,-TC_INTER_PADDLE_RADIUS,0])
    union() {
    BodyArm_Neg();
        translate([TC_PADDLE_WIDTH/2,TC_INTER_PADDLE_RADIUS,0])
        rotate([0,0,TC_INTER_PADDLE_ANGLE/2])
            TCElbow_Neg();
    }
    
    difference() {
        BodyArm_Neg();
        translate([-THICKNESS/2, -LARGE/2])
            square([LARGE,LARGE]);
    }
    
    translate([-THICKNESS/2, -TC_ARM_HEIGHT])
    rotate([0,0,-90])
        TSlot();
}

module TCNeck()
{
    difference() {
        TCNeck_Pos();
        TCNeck_Neg();
    }
}

TCNeck();
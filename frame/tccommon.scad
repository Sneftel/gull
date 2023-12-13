include <util.scad>
include <params.scad>

TC_PADDLE_WIDTH = 20;

TC_PADDLE_GUIDE_MAJOR_WIDTH = TC_PADDLE_WIDTH;
TC_PADDLE_GUIDE_SLOT_WIDTH = 2;
TC_PADDLE_GUIDE_DEPTH = 2.5;
TC_PADDLE_GUIDE_SLOT_HEIGHT = 0.8;
TC_PADDLE_GUIDE_MINOR_WIDTH = TC_PADDLE_GUIDE_MAJOR_WIDTH - 2*TC_PADDLE_GUIDE_SLOT_WIDTH;

TC_ARM_BASE_WIDTH = TC_PADDLE_GUIDE_MAJOR_WIDTH;
TC_ARM_HEIGHT = 10;

TC_INTER_PADDLE_ANGLE = 70;
TC_INTER_PADDLE_ARCLEN = 10;

TC_INTER_PADDLE_RADIUS = TC_INTER_PADDLE_ARCLEN / (TC_INTER_PADDLE_ANGLE * PI / 180) - TC_PADDLE_GUIDE_DEPTH;

TC_CUTOUT_MINOR_RADIUS = TC_INTER_PADDLE_RADIUS + TC_PADDLE_GUIDE_DEPTH - TC_PADDLE_GUIDE_SLOT_HEIGHT;

TC_CUTOUT_DEPTH = 3;

TC_CUTOUT_MAJOR_RADIUS = TC_CUTOUT_MINOR_RADIUS + TC_CUTOUT_DEPTH;

module PaddleGuide()
{
    EXTRA=1;
    translate([-TC_PADDLE_GUIDE_MINOR_WIDTH/2, -TC_PADDLE_GUIDE_DEPTH, 0])
        square([TC_PADDLE_GUIDE_MINOR_WIDTH, TC_PADDLE_GUIDE_DEPTH+EXTRA], center=false);
    
    translate([-TC_PADDLE_GUIDE_MAJOR_WIDTH/2, -TC_PADDLE_GUIDE_DEPTH, 0])
        square([TC_PADDLE_GUIDE_MAJOR_WIDTH, TC_PADDLE_GUIDE_SLOT_HEIGHT], center=false);
    
    translate([-LEG_SLOT_WIDTH/2, -TC_PADDLE_GUIDE_DEPTH-LEG_SLOT_DEPTH, 0])
        square([LEG_SLOT_WIDTH, LEG_SLOT_DEPTH], center=false);
}

module BodyArm_Pos()
{
    translate([-TC_ARM_BASE_WIDTH/2, -TC_ARM_HEIGHT, 0])
        square([TC_ARM_BASE_WIDTH, TC_ARM_HEIGHT], center=false);
}

module BodyArm_Neg()
{
    PaddleGuide();
}

module BodyArm()
{
    difference() {
        BodyArm_Pos();
        BodyArm_Neg();
    }
}

module TCElbow_Pos()
{
    EXTRA_ANGLE = 0.1;
    difference() {
        Wedge(TC_INTER_PADDLE_RADIUS+TC_ARM_HEIGHT, TC_INTER_PADDLE_ANGLE+EXTRA_ANGLE);
        circle(r=TC_INTER_PADDLE_RADIUS);
    }
}

module TCElbow_Neg()
{
    difference() {
        Wedge(TC_CUTOUT_MAJOR_RADIUS, TC_INTER_PADDLE_ANGLE - 20);
        circle(r=TC_CUTOUT_MINOR_RADIUS);
    }
}

module TCElbow()
{
    difference() {
        TCElbow_Pos();
        TCElbow_Neg();
    }
}

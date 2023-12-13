include <util.scad>
include <params.scad>
include <tccommon.scad>

// PARAMETERS SPECIFIC TO THIS ASSEMBLY



TCBODY_STEM_WIDTH = 10;
TCBODY_STEM_LENGTH = 8;


module TCBody_Pos()
{
    // Center body arm
    BodyArm_Pos();

    // Left body arm
    translate([-TC_PADDLE_WIDTH/2,TC_INTER_PADDLE_RADIUS,0])
    rotate([0,0,-TC_INTER_PADDLE_ANGLE])
    translate([-TC_PADDLE_WIDTH/2,-TC_INTER_PADDLE_RADIUS,0])
    union() {
        BodyArm_Pos();
        translate([-TC_PADDLE_WIDTH/2,-TC_ARM_HEIGHT/2,0])
            circle(d=TC_ARM_HEIGHT);
    }
    
    // Right body arm
    translate([TC_PADDLE_WIDTH/2,TC_INTER_PADDLE_RADIUS,0])
    rotate([0,0,TC_INTER_PADDLE_ANGLE])
    translate([TC_PADDLE_WIDTH/2,-TC_INTER_PADDLE_RADIUS,0])
    union() {
        BodyArm_Pos();
        translate([TC_PADDLE_WIDTH/2,-TC_ARM_HEIGHT/2,0])
            circle(d=TC_ARM_HEIGHT);
    }
    
    // Left elbow
    translate([-TC_PADDLE_WIDTH/2,TC_INTER_PADDLE_RADIUS,0])
    rotate([0,0,-TC_INTER_PADDLE_ANGLE/2])
        TCElbow_Pos();
    
    // Right elbow
    translate([TC_PADDLE_WIDTH/2,TC_INTER_PADDLE_RADIUS,0])
    rotate([0,0,TC_INTER_PADDLE_ANGLE/2])
        TCElbow_Pos();
    
    // Stem
    translate([-TCBODY_STEM_WIDTH/2, -TC_ARM_HEIGHT - TCBODY_STEM_LENGTH])
        square([TCBODY_STEM_WIDTH,TCBODY_STEM_LENGTH], center=false);
}

module TCBody_Neg()
{
    BodyArm_Neg();
    
    // Left body arm
    translate([-TC_PADDLE_WIDTH/2,TC_INTER_PADDLE_RADIUS,0]) rotate([0,0,-TC_INTER_PADDLE_ANGLE]) translate([-TC_PADDLE_WIDTH/2,-TC_INTER_PADDLE_RADIUS,0])
        BodyArm_Neg();
    
    // Right body arm
    translate([TC_PADDLE_WIDTH/2,TC_INTER_PADDLE_RADIUS,0]) rotate([0,0,TC_INTER_PADDLE_ANGLE]) translate([TC_PADDLE_WIDTH/2,-TC_INTER_PADDLE_RADIUS,0])
        BodyArm_Neg();
    
    // Left elbow
    translate([-TC_PADDLE_WIDTH/2,TC_INTER_PADDLE_RADIUS,0])
    rotate([0,0,-TC_INTER_PADDLE_ANGLE/2])
        TCElbow_Neg();
    
    // Right elbow
    translate([TC_PADDLE_WIDTH/2,TC_INTER_PADDLE_RADIUS,0])
    rotate([0,0,TC_INTER_PADDLE_ANGLE/2])
        TCElbow_Neg();
    
    // Stem
    translate([0, -TC_ARM_HEIGHT])
        circle(d=BOLT_DIAMETER);
}

module TCBody()
{
    difference() {
        TCBody_Pos();
        TCBody_Neg();
    }
}

TCBody();
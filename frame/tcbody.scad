include <util.scad>
include <params.scad>
include <tccommon.scad>

// PARAMETERS SPECIFIC TO THIS ASSEMBLY



TCBODY_STEM_WIDTH = 10;
TCBODY_STEM_LENGTH = 8;


module TCBody()
{
    // Center body arm
    BodyArm();

    // Left body arm
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
    
    // Right body arm
    translate([TC_PCB_WIDTH/2,TC_INTER_PADDLE_RADIUS,0])
    rotate([0,0,TC_INTER_PADDLE_ANGLE])
    translate([TC_PCB_WIDTH/2,-TC_INTER_PADDLE_RADIUS,0])
    union() {
        BodyArm();

        pn_pos() {
            translate([TC_PCB_WIDTH/2,-TC_ARM_HEIGHT/2,0])
                circle(d=TC_ARM_HEIGHT);
        }
    }
    
    // Left elbow
    translate([-TC_PCB_WIDTH/2,TC_INTER_PADDLE_RADIUS,0])
    rotate([0,0,-TC_INTER_PADDLE_ANGLE/2])
        TCElbow();
    
    // Right elbow
    translate([TC_PCB_WIDTH/2,TC_INTER_PADDLE_RADIUS,0])
    rotate([0,0,TC_INTER_PADDLE_ANGLE/2])
        TCElbow();
    
    // Stem
    pn_pos() {
        translate([-TCBODY_STEM_WIDTH/2, -TC_ARM_HEIGHT - TCBODY_STEM_LENGTH])
            square([TCBODY_STEM_WIDTH,TCBODY_STEM_LENGTH], center=false);
    }

    translate([0, -TC_ARM_HEIGHT])
        InterconnectBoltHole();
}

module TCBody_Anchored()
{
    translate([0,TC_ARM_HEIGHT+TCBODY_STEM_LENGTH])
        TCBody() children();
}

pn_top() TCBody_Anchored();

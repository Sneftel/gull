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

    pn_pos()
    {
        translate([-TC_PCB_WIDTH/2,TC_INTER_PADDLE_RADIUS,0])
        rotate([0,0,-TC_INTER_PADDLE_ANGLE])
        translate([-TC_PCB_WIDTH/2,-TC_INTER_PADDLE_RADIUS,0])
        union() {
            BodyArm_Pos();
            translate([TC_PCB_WIDTH/2,TC_INTER_PADDLE_RADIUS,0])
            rotate([0,0,TC_INTER_PADDLE_ANGLE/2])
                TCElbow_Pos();
            translate([-TC_PCB_WIDTH/2,-TC_ARM_HEIGHT/2,0])
                circle(d=TC_ARM_HEIGHT);
        }
        
        difference() {
            BodyArm_Pos();
            translate([-TC_THICKNESS/2, -LARGE/2])
                square([LARGE,LARGE]);
        }
        
        translate([-NECK_STEM_WIDTH - TC_THICKNESS/2, -TC_ARM_HEIGHT - NECK_STEM_LENGTH])
            square([NECK_STEM_WIDTH, TC_ARM_HEIGHT + NECK_STEM_LENGTH], center=false);
    }

    pn_neg()
    {
        translate([-TC_PCB_WIDTH/2,TC_INTER_PADDLE_RADIUS,0])
        rotate([0,0,-TC_INTER_PADDLE_ANGLE])
        translate([-TC_PCB_WIDTH/2,-TC_INTER_PADDLE_RADIUS,0])
        union() {
        BodyArm_Neg();
            translate([TC_PCB_WIDTH/2,TC_INTER_PADDLE_RADIUS,0])
            rotate([0,0,TC_INTER_PADDLE_ANGLE/2])
                TCElbow_Neg();
        }
        
        difference() {
            BodyArm_Neg();
            translate([-TC_THICKNESS/2, -LARGE/2])
                square([LARGE,LARGE]);
        }
    }

    translate([-TC_THICKNESS/2, -TC_ARM_HEIGHT]) rotate([0,0,-90])
        TSlot();
}

pn_top() TCNeck();
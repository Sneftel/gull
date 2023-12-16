include <params.scad>
include <util.scad>

use <spine.scad>
use <pelvis.scad>
use <rib_a.scad>
use <rib_b.scad>
use <rib_c.scad>

ACTUAL_THICKNESS = THICKNESS;

module Side()
{
    color("silver")
    translate([0,0,0])
    rotate([90,0,0]) translate([0,0,ACTUAL_THICKNESS/2 - THICKNESS])
        linear_extrude(ACTUAL_THICKNESS, center=false) Spine();
    
    color("silver")
    translate([0,SPINES_OUTER_SPACING,0])
    rotate([90,0,0]) translate([0,0,-ACTUAL_THICKNESS/2 + THICKNESS])
        linear_extrude(ACTUAL_THICKNESS, center=false) Spine();
    
    color("red")
    {
        rotate([90,0,0])
        translate(RIB_A_POS) rotate([0,0,RIB_A_ANGLE])
        rotate([0,90,0]) translate([(THICKNESS-ACTUAL_THICKNESS)/2,0,-THICKNESS/2])
            linear_extrude(ACTUAL_THICKNESS,center=false) Rib_A();
        
        rotate([90,0,0])
        translate(RIB_B_POS) rotate([0,0,RIB_B_ANGLE])
        rotate([0,90,0]) translate([(THICKNESS-ACTUAL_THICKNESS)/2,0,-THICKNESS/2])
            linear_extrude(ACTUAL_THICKNESS,center=false) Rib_B();
        
        rotate([90,0,0])
        translate(RIB_C_POS) rotate([0,0,RIB_C_ANGLE])
        rotate([0,90,0]) translate([(THICKNESS-ACTUAL_THICKNESS)/2,0,-THICKNESS/2])
            linear_extrude(ACTUAL_THICKNESS,center=false) Rib_C();
    }
}

module PositionedSide()
{
    rotate([0,0,-PELVIS_HALF_ANGLE])
    translate([-PELVIS_REAR_HALF_WIDTH + 4*INTER_CONNECTION_OFFSET,-SPINES_OUTER_SPACING + ACTUAL_THICKNESS/2])
    Side();
}

module Main()
{
    PositionedSide();
    
    mirror([1,0,0]) PositionedSide();
    
    color("pink")
    translate([0,0, SPINE_BASE_HEIGHT - THICKNESS])
    linear_extrude(ACTUAL_THICKNESS) Pelvis();
}

Main();

include <params.scad>
include <util.scad>

use <spine.scad>
use <rib.scad>
use <pelvis.scad>

module Side()
{
    color("silver")
    translate([0,0,0])
    rotate([90,0,0])
        linear_extrude(THICKNESS, center=true) Spine();
    
    color("silver")
    translate([0,SPINES_OUTER_SPACING-THICKNESS,0])
    rotate([90,0,0])
        linear_extrude(THICKNESS, center=true) Spine();
    
    color("red")
    {
        rotate([90,0,0])
        translate(RIB_A_POS) rotate([0,0,RIB_A_ANGLE])
        rotate([0,90,0])
            linear_extrude(THICKNESS,center=true) Rib(RIB_A_SHIFT, RIB_A_RADIUS, RIB_A_PITCH);
        
        rotate([90,0,0])
        translate(RIB_B_POS) rotate([0,0,RIB_B_ANGLE])
        rotate([0,90,0])
            linear_extrude(THICKNESS,center=true) Rib(RIB_B_SHIFT, RIB_B_RADIUS, RIB_B_PITCH);
        
        rotate([90,0,0])
        translate(RIB_C_POS) rotate([0,0,RIB_C_ANGLE])
        rotate([0,90,0])
            linear_extrude(THICKNESS,center=true) Rib(RIB_C_SHIFT, RIB_C_RADIUS, RIB_C_PITCH);
    }
}

module PositionedSide()
{
    rotate([0,0,-PELVIS_HALF_ANGLE])
    translate([-PELVIS_REAR_HALF_WIDTH + 4*INTER_CONNECTION_OFFSET,-SPINES_OUTER_SPACING + THICKNESS/2])
    Side();
}

module Main()
{
    PositionedSide();
    
    mirror([1,0,0]) PositionedSide();
    
    color("pink")
    translate([0,0, SPINE_BASE_HEIGHT - THICKNESS])
    linear_extrude(THICKNESS) Pelvis();
}

Main();

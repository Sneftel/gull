include <params.scad>
include <util.scad>
include <pn.scad>

use <spine.scad>
use <pelvis.scad>
use <rib_a.scad>
use <rib_b.scad>
use <rib_c.scad>

ACTUAL_THICKNESS = THICKNESS;

module Side(name)
{
    pn_attach(str(name, "_front")) Pelvis() rotate([90,0,0])
    color("silver")
    linear_extrude(ACTUAL_THICKNESS, center=true) 
        pn_top() Spine_Anchored();

    pn_attach(str(name, "_rear")) Pelvis() rotate([90,0,0])
    {
        color("silver")
        linear_extrude(ACTUAL_THICKNESS, center=true) 
            pn_top() Spine_Anchored();

        pn_attach("riserA") Spine_Anchored() rotate([90,0,0])
        linear_extrude(ACTUAL_THICKNESS, center=true) 
            pn_top() Rib_A_Anchored();

        pn_attach("riserB") Spine_Anchored() rotate([90,0,0])
        linear_extrude(ACTUAL_THICKNESS, center=true) 
            pn_top() Rib_B_Anchored();

        pn_attach("riserC") Spine_Anchored() rotate([90,0,0])
        linear_extrude(ACTUAL_THICKNESS, center=true) 
            pn_top() Rib_C_Anchored();

    }

}

module Main()
{
    linear_extrude(ACTUAL_THICKNESS, center=true) pn_top() Pelvis();

    Side("left");
    Side("right");
}

Main();

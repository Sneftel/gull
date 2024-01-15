include <params.scad>
include <util.scad>
include <pn.scad>

use <spine.scad>
use <pelvis.scad>
use <rib.scad>
use <fingerboard.scad>
use <stabilizer.scad>

ACTUAL_THICKNESS = THICKNESS;

module RibAssembly(riserName, shift, minorRadius, cantAngle, numGuides)
{
    pn_attach(riserName) Spine_Anchored() rotate([90,0,0]) {
        linear_extrude(ACTUAL_THICKNESS, center=true) 
            pn_top() Rib_Anchored(shift, minorRadius, cantAngle, numGuides);

        pn_attach("pcb") Rib_Anchored(shift, minorRadius, cantAngle, numGuides)
        FingerboardPCB(minorRadius);

        pn_attach("forwardStabilizer") Rib_Anchored(shift, minorRadius, cantAngle, numGuides)
        rotate([0,90,0])
            linear_extrude(ACTUAL_THICKNESS, center=true) Stabilizer();

        pn_attach("rearwardStabilizer") Rib_Anchored(shift, minorRadius, cantAngle, numGuides)
        rotate([0,90,0])
            linear_extrude(ACTUAL_THICKNESS, center=true) Stabilizer();
    }
}

module Side(name)
{
    pn_attach(str(name, "_front")) Pelvis() rotate([90,0,0])
    color("silver")
    linear_extrude(ACTUAL_THICKNESS, center=true) 
        pn_top() Spine_Anchored();

    pn_attach(str(name, "_rear")) Pelvis() rotate([90,0,0]) {
        color("silver")
        linear_extrude(ACTUAL_THICKNESS, center=true) 
            pn_top() Spine_Anchored();

        RibAssembly("riserA", RIB_A_SHIFT, RIB_A_RADIUS, RIB_A_PITCH, 3);
        RibAssembly("riserB", RIB_B_SHIFT, RIB_B_RADIUS, RIB_B_PITCH, 3);
        RibAssembly("riserC", RIB_C_SHIFT, RIB_C_RADIUS, RIB_C_PITCH, 3);
    }
}

module Main()
{
    linear_extrude(ACTUAL_THICKNESS, center=true) pn_top() Pelvis();

    Side("left");
    Side("right");
}

Main();

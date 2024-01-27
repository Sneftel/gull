include <params.scad>
include <util.scad>
include <pn.scad>

use <spine.scad>
use <pelvis.scad>
use <rib.scad>
use <fingerboard.scad>
use <stabilizer.scad>
use <tcneck.scad>

ACTUAL_THICKNESS = THICKNESS;

module RibAssembly(shift, minorRadius, cantAngle, numGuides, withTC)
{
    rotate([90,0,0]) {
        linear_extrude(ACTUAL_THICKNESS, center=true) 
            pn_top() Rib_Anchored(shift, minorRadius, cantAngle, numGuides, withTC);

        pn_attach("pcb") Rib_Anchored(shift, minorRadius, cantAngle, numGuides, withTC)
            FingerboardPCB(minorRadius);

        {
            pn_attach("stabilizer") Rib_Anchored(shift, minorRadius, cantAngle, numGuides, withTC)
            rotate([0,90,0])
                linear_extrude(ACTUAL_THICKNESS, center=true) Stabilizer();

            pn_attach("tcHole") Rib_Anchored(shift, minorRadius, cantAngle, numGuides, withTC)
            rotate([0,-90,0]) translate([-ACTUAL_THICKNESS/2,0,0])
                linear_extrude(ACTUAL_THICKNESS, center=true) pn_top() TCNeck_Anchored();
        }
    }
}

module Side(name)
{
    pn_attach(str(name, "_front")) Pelvis() rotate([90,0,0])
    color("#2B3499")
    linear_extrude(ACTUAL_THICKNESS, center=true) 
        pn_top() Spine_Anchored();

    pn_attach(str(name, "_rear")) Pelvis() rotate([90,0,0]) {
        color("#2B3499") linear_extrude(ACTUAL_THICKNESS, center=true) 
            pn_top() Spine_Anchored();

        pn_attach("riserA") Spine_Anchored() RibAssembly(RIB_A_SHIFT, RIB_A_RADIUS, RIB_A_PITCH, 4, true);
        pn_attach("riserB") Spine_Anchored() RibAssembly(RIB_B_SHIFT, RIB_B_RADIUS, RIB_B_PITCH, 2, false);
        pn_attach("riserC") Spine_Anchored() RibAssembly(RIB_C_SHIFT, RIB_C_RADIUS, RIB_C_PITCH, 1, false);
    }
}

module Main()
{
    translate([0,0,SPINE_BASE_HEIGHT-THICKNESS/2])
    {
        linear_extrude(ACTUAL_THICKNESS, center=true) pn_top() Pelvis();

        Side("left");
        Side("right");
    }
}

Main();

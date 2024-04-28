// Visualization of full keyboard, minus fasteners, cables, and thumb and center PCBs

include <params.scad>
include <util.scad>
include <pn.scad>

use <spine.scad>
use <pelvis.scad>
use <rib.scad>
use <fingerboard.scad>
use <stabilizer.scad>
use <tcneck.scad>
use <tcbody.scad>

ACTUAL_THICKNESS = THICKNESS;

module TCAssembly()
{
    rotate([90,-90,0]) translate([0,0,0]) {
        color("seagreen")
        linear_extrude(ACTUAL_THICKNESS, center=true) pn_top() TCNeck_Anchored();

        pn_attach("TCBody") TCNeck_Anchored() {
            rotate([0,90,0]) linear_extrude(ACTUAL_THICKNESS, center=true) pn_top() TCBody();
        }
    }
}
module RibAssembly(shift, minorRadius, cantAngle, withTC)
{
    rotate([90,0,0]) {
        translate([0,0,-THICKNESS/2]) linear_extrude(ACTUAL_THICKNESS) 
            pn_top() Rib_Anchored(shift, minorRadius, cantAngle, withTC);

        pn_attach("pcb") Rib_Anchored(shift, minorRadius, cantAngle, withTC)
            FingerboardPCB(minorRadius);

        pn_attach("stabilizer") Rib_Anchored(shift, minorRadius, cantAngle, withTC)
        rotate([0,90,0])
            color("gray")
            linear_extrude(ACTUAL_THICKNESS, center=true) Stabilizer();

        if(withTC) {
            pn_attach("TC") Rib_Anchored(shift, minorRadius, cantAngle, withTC) TCAssembly();
        }
    }
}

module Side(name)
{
    pn_attach(str(name, "_front")) Pelvis() rotate([90,0,0])
    color("#5B64C9")
    translate([0,0,-THICKNESS/2]) linear_extrude(ACTUAL_THICKNESS) 
        pn_top() Spine_Anchored();

    pn_attach(str(name, "_rear")) Pelvis() rotate([90,0,0]) {
        color("#3B44A9") translate([0,0,-THICKNESS/2]) linear_extrude(ACTUAL_THICKNESS) 
            pn_top() Spine_Anchored();

        pn_attach("riserA") Spine_Anchored() RibAssembly(RIB_A_SHIFT, RIB_A_RADIUS, RIB_A_PITCH, true);
        pn_attach("riserB") Spine_Anchored() RibAssembly(RIB_B_SHIFT, RIB_B_RADIUS, RIB_B_PITCH, false);
        pn_attach("riserC") Spine_Anchored() RibAssembly(RIB_C_SHIFT, RIB_C_RADIUS, RIB_C_PITCH, false);
    }
}

module Main()
{
    translate([0,0,SPINE_BASE_HEIGHT-THICKNESS/2])
    {
        translate([0,0,-THICKNESS/2]) linear_extrude(ACTUAL_THICKNESS) pn_top() Pelvis();

        Side("left");
        Side("right");
    }
}

Main();

include <params.scad>
include <util.scad>
include <pn.scad>

use <tcneck.scad>
use <tcbody.scad>

module TCMain()
{
    color("magenta")
    translate([0,0,-THICKNESS/2])
    linear_extrude(THICKNESS) TCBody();
    
    color("seagreen")
    translate([THICKNESS/2,0,0])
    rotate([0,-90,0])
    linear_extrude(THICKNESS) TCNeck();
}

pn_top() rotate([90,0,0]) TCMain();

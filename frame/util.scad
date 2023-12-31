include <params.scad>


ANCHOR_TL = 0+0;
ANCHOR_TC = 0+1;
ANCHOR_TR = 0+2;
ANCHOR_CL = 0+3;
ANCHOR_CC = 0+4;
ANCHOR_CR = 0+5;
ANCHOR_BL = 0+6;
ANCHOR_BC = 0+7;
ANCHOR_BR = 0+8;

module Rect(width, height, anchor)
{
    txm = anchor%3 == 0 ? -1 : anchor%3 == 1 ? -0.5 : 0;
    tym = anchor/3 == 0 ? 0 : anchor/3 == 1 ? -0.5 : -1;
    translate([width*txm, height*tym, 0])
        square([width, height], center=false);
}

module TSlot()
{
    EXTRA = 1;
    
    translate([-T_SLOT_MINOR_WIDTH/2, -T_SLOT_DEPTH, 0])
        square([T_SLOT_MINOR_WIDTH, T_SLOT_DEPTH+EXTRA], center=false);
    translate([-T_SLOT_WIDTH/2, -(T_SLOT_NUT_DEPTH+T_SLOT_NUT_OFFSET), 0])
        square([T_SLOT_WIDTH, T_SLOT_NUT_DEPTH], center=false);
    translate([-T_SLOT_WIDTH/2, -T_SLOT_NUT_OFFSET, 0])
        circle(r=STRAIN_RELIEF_RADIUS);
    translate([T_SLOT_WIDTH/2, -T_SLOT_NUT_OFFSET, 0])
        circle(r=STRAIN_RELIEF_RADIUS);
}

module LegSlot()
{
    EXTRA = 1;
    translate([-LEG_SLOT_WIDTH/2, -LEG_SLOT_DEPTH, 0])
        square([LEG_SLOT_DEPTH,LEG_SLOT_WIDTH+EXTRA], center=false);
}

module Wedge(radius, angle)
{
    intersection() {
        circle(radius);
        polygon(points = [
            [0,0],
            [-radius * tan(angle/2), -radius],
            [radius * tan(angle/2), -radius]
        ]);
    }
}

module CocktailSausage(minorRadius, angle, thickness)
{
    halfRadius = minorRadius + thickness/2;
    difference()
    {
        Wedge(minorRadius+thickness, angle);
        circle(minorRadius);
    }
}
module Sausage(minorRadius, angle, thickness)
{
    halfRadius = minorRadius + thickness/2;
    difference()
    {
        union() {
            Wedge(minorRadius+thickness, angle);
            translate([-halfRadius * sin(angle/2), -halfRadius * cos(angle/2), 0])
                circle(d=thickness);
            translate([halfRadius * sin(angle/2), -halfRadius * cos(angle/2), 0])
                circle(d=thickness);
        }
        circle(minorRadius);
    }
}

function angleFromLen(radius, length) = length / radius * 180 / PI;


module CableGuide()
{
    hull()
    {
        translate([0,CABLE_GUIDE_LENGTH/2])
            circle(d=CABLE_GUIDE_WIDTH);
        translate([0,-CABLE_GUIDE_LENGTH/2])
            circle(d=CABLE_GUIDE_WIDTH);
    }
}

include <params.scad>
include <pn.scad>

ANCHOR_BL = 0+0;
ANCHOR_BC = 0+1;
ANCHOR_BR = 0+2;
ANCHOR_CL = 0+3;
ANCHOR_CC = 0+4;
ANCHOR_CR = 0+5;
ANCHOR_TL = 0+6;
ANCHOR_TC = 0+7;
ANCHOR_TR = 0+8;

module Rect(width, height, anchor, extraX=0, extraY=0)
{
    tx = anchor%3 == 0 ? -extraX : anchor%3 == 1 ? -width/2 : -width;
    ty = floor(anchor/3) == 0 ? -extraY : floor(anchor/3) == 1 ? -height/2 : -height;
    translate([tx, ty, 0])
        square([width+extraX, height+extraY], center=false);
}

module TSlot(diameter, length)
{
    EXTRA = 1;

    innerLength = length - THICKNESS;
    
    pn_neg() {
        Rect(diameter, innerLength + T_SLOT_EXTRA_DEPTH, ANCHOR_TC, extraY=EXTRA);
        translate([0, -innerLength + T_SLOT_NUT_OFFSET])
            Rect(T_SLOT_WIDTH, $T_SLOT_NUT_DEPTH, ANCHOR_BC);
        translate([-T_SLOT_WIDTH/2, -innerLength + T_SLOT_NUT_OFFSET + $T_SLOT_NUT_DEPTH, 0])
            circle(r=STRAIN_RELIEF_RADIUS);
        translate([T_SLOT_WIDTH/2, -innerLength + T_SLOT_NUT_OFFSET + $T_SLOT_NUT_DEPTH, 0])
            circle(r=STRAIN_RELIEF_RADIUS);
    }

    pn_pos() {
        translate([-diameter/2-T_SLOT_BUMPER_RADIUS, 0])
            circle(r=T_SLOT_BUMPER_RADIUS);
        translate([diameter/2+T_SLOT_BUMPER_RADIUS, 0])
            circle(r=T_SLOT_BUMPER_RADIUS);
    }
}

module FingerboardTSlot()
{
    TSlot(FINGERBOARD_BOLT_DIAMETER, FINGERBOARD_BOLT_LENGTH);
}

module InterconnectTSlot()
{
    TSlot(INTERCONNECT_BOLT_DIAMETER, INTERCONNECT_BOLT_LENGTH);
}

module InterconnectBoltHole()
{
    pn_neg() {
        circle(d=INTERCONNECT_BOLT_DIAMETER);
    }
}

module Interconnect(name)
{
    EXTRA = 1;
    pn_neg() {
        translate([-EXTRA, -THICKNESS_TOLERANCE])
            square([EXTRA+2*INTER_CONNECTION_OFFSET, THICKNESS_TOLERANCE+THICKNESS]);
    }

    translate([3*INTER_CONNECTION_OFFSET, THICKNESS/2])
        InterconnectBoltHole();

    translate([INTER_CONNECTION_OFFSET, THICKNESS]) rotate([0,0,180])
        InterconnectTSlot();

    translate([2*INTER_CONNECTION_OFFSET, THICKNESS/2])
        pn_anchor(name) children();
}

module LegSlot()
{
    EXTRA = 1;

    pn_neg() {
        translate([-LEG_SLOT_WIDTH/2, -LEG_SLOT_DEPTH, 0])
            square([LEG_SLOT_DEPTH,LEG_SLOT_WIDTH+EXTRA], center=false);
    }
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
    difference() {
        Wedge(minorRadius+thickness, angle);
        circle(minorRadius);
    }
}
module Sausage(minorRadius, angle, thickness)
{
    halfRadius = minorRadius + thickness/2;
    difference() {
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
    pn_neg() {
        hull() {
            translate([0,CABLE_GUIDE_LENGTH/2 - CABLE_GUIDE_WIDTH])
                circle(d=CABLE_GUIDE_WIDTH);
            translate([0,-CABLE_GUIDE_LENGTH/2 + CABLE_GUIDE_WIDTH])
                circle(d=CABLE_GUIDE_WIDTH);
        }
    }
}

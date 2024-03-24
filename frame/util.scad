// Various utilities used throughout other files.

include <params.scad>
include <pn.scad>

ANCHOR_LB = 0+0;
ANCHOR_CB = 0+1;
ANCHOR_RB = 0+2;
ANCHOR_LC = 0+3;
ANCHOR_CC = 0+4;
ANCHOR_RC = 0+5;
ANCHOR_LT = 0+6;
ANCHOR_CT = 0+7;
ANCHOR_RT = 0+8;

module Rect(width, height, anchor, extraX=0, extraY=0)
{
    tx = anchor%3 == 0 ? -extraX : anchor%3 == 1 ? -width/2 : -width;
    ty = floor(anchor/3) == 0 ? -extraY : floor(anchor/3) == 1 ? -height/2 : -height;
    translate([tx, ty, 0])
        square([width+extraX, height+extraY], center=false);
}

module TSlot(diameter, innerLength)
{
    EXTRA = 1;

    pn_neg() {
        Rect(diameter, innerLength + T_SLOT_EXTRA_DEPTH, ANCHOR_CT, extraY=EXTRA);
        translate([0, -innerLength + T_SLOT_NUT_OFFSET])
            Rect($T_SLOT_NUT_WIDTH, $T_SLOT_NUT_DEPTH, ANCHOR_CB);
    }

    translate([-$T_SLOT_NUT_WIDTH/2, -innerLength + T_SLOT_NUT_OFFSET + $T_SLOT_NUT_DEPTH, 0])
        ClearedCorner(-135);
    translate([$T_SLOT_NUT_WIDTH/2, -innerLength + T_SLOT_NUT_OFFSET + $T_SLOT_NUT_DEPTH, 0])
        ClearedCorner(135);


    pn_pos() {
        translate([-diameter/2-T_SLOT_BUMPER_RADIUS, 0])
            circle(r=T_SLOT_BUMPER_RADIUS);
        translate([diameter/2+T_SLOT_BUMPER_RADIUS, 0])
            circle(r=T_SLOT_BUMPER_RADIUS);
    }
}

module FingerboardTSlot()
{
    TSlot(FINGERBOARD_BOLT_DIAMETER, FINGERBOARD_BOLT_LENGTH - FINGERBOARD_THICKNESS);
}

module InterconnectTSlot()
{
    TSlot(INTERCONNECT_BOLT_DIAMETER, INTERCONNECT_BOLT_LENGTH - THICKNESS);
}

module InterconnectBoltHole()
{
    pn_pos() circle(d=INTERCONNECT_WASHER_DIAMETER);
    pn_neg() circle(d=INTERCONNECT_BOLT_DIAMETER);
}

module Interconnect(name, offsetLength=-1)
{
    assert(offsetLength > 0);
    EXTRA = 1;
    pn_neg() Rect(2*offsetLength, THICKNESS, ANCHOR_LB, extraX=EXTRA, extraY=THICKNESS_TOLERANCE);
    translate([2*offsetLength,THICKNESS])
        ClearedCorner(-45);

    translate([3*offsetLength, THICKNESS/2])
        InterconnectBoltHole();

    translate([offsetLength, THICKNESS]) rotate([0,0,180])
        InterconnectTSlot();

    translate([2*offsetLength, THICKNESS/2])
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
            translate([0,CABLE_GUIDE_LENGTH/2 - CABLE_GUIDE_WIDTH/2])
                circle(d=CABLE_GUIDE_WIDTH);
            translate([0,-CABLE_GUIDE_LENGTH/2 + CABLE_GUIDE_WIDTH/2])
                circle(d=CABLE_GUIDE_WIDTH);
        }
    }
}

module ClearedCorner(angle, r=0.01)
{
    rotate([0,0,angle])
        pn_neg() Rect(KERF+2*r, KERF/2+r, ANCHOR_CB, extraY=KERF/2+r);
}

module Dekerf()
{
    if(KERF > 0) {
        offset(delta=KERF/2) children();
    } else {
        children();
    }
}

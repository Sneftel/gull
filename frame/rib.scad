include <util.scad>
include <params.scad>

// PARAMETERS SPECIFIC TO THIS ASSEMBLY

// The height of the lowest point of the top side of the fingerboard (the fingerboard PCB will go as low as this)
FINGERBOARD_CENTER_HEIGHT = 30;

// The thickness of the fingerboard body
RIB_THICKNESS = 12;

RIB_FORWARD_EXTENT = 37;
RIB_REARWARD_EXTENT = 40;

FOOT_HEIGHT = 1.0;

FOOT_LENGTH = 2.0;


FIRST_CABLE_GUIDE_LOC = [5,5];
CABLE_GUIDE_OFFSET = [-5,0];


module CableGuides(n)
{
    if(n>0)
    {
        CableGuide();
        translate(CABLE_GUIDE_OFFSET)
            CableGuides(n-1);
    }
}

module LegSlotAt(radius, x)
{
    rotate([0,0,angleFromLen(radius, x)]) translate([0,-radius,0])
        LegSlot();
}

module CableSlot()
{
    EXTRA = 1;
    LARGE = 100;
    translate([0, -LEG_SLOT_DEPTH, 0])
        square([LARGE,LEG_SLOT_DEPTH+EXTRA], center=false);
}

module Foot()
{
    EXTRA = 1;
    translate([-FOOT_LENGTH,-EXTRA,0])
        square([FOOT_LENGTH, FOOT_HEIGHT+EXTRA], center=false);
}

module OnArc(radius, x)
{
    rotate([0,0,angleFromLen(radius, x)]) translate([0,-radius,0])
        children();
}

module Fingerboard_Pos(minorRadius)
{
    FINGERBOARD_TOTAL_ANGLE = angleFromLen(minorRadius, RIB_FORWARD_EXTENT+RIB_REARWARD_EXTENT);

    FINGERBOARD_ANGLE_BIAS = angleFromLen(minorRadius, (RIB_FORWARD_EXTENT-RIB_REARWARD_EXTENT)/2);
    
    rotate([0,0,FINGERBOARD_ANGLE_BIAS])
        CocktailSausage(minorRadius, FINGERBOARD_TOTAL_ANGLE, RIB_THICKNESS);
    
    OnArc(minorRadius, -38) Foot();
}

module Fingerboard_Neg(minorRadius)
{
    OnArc(minorRadius, -30) LegSlot();
    OnArc(minorRadius, -20) TSlot();
    OnArc(minorRadius, -10) LegSlot();
    OnArc(minorRadius, 0) TSlot();
    OnArc(minorRadius, 10) LegSlot();
    OnArc(minorRadius, 20) TSlot();
    OnArc(minorRadius, 29) CableSlot();
}

module Fingerboard()
{
    difference() {
        Fingerboard_Pos();
        Fingerboard_Neg();
    }
}

module Supports_Pos(shift, minorRadius)
{
    FINGERBOARD_MAJOR_RADIUS = minorRadius + RIB_THICKNESS;
    EXTRA=1;
    LARGE=100;
    difference()
    {
        translate([-SPINES_OUTER_SPACING/2,0])
            square([SPINES_OUTER_SPACING, LARGE]);
        translate([shift, minorRadius+FINGERBOARD_CENTER_HEIGHT, 0])
            circle(r=FINGERBOARD_MAJOR_RADIUS-EXTRA);
    }
}

module Supports_Neg(shift, minorRadius, numGuides)
{
    EXTRA=1;

    translate([-SPINES_OUTER_SPACING/2+THICKNESS, INTER_CONNECTION_OFFSET])
    rotate([0,0,90])
        TSlot();
    translate([-SPINES_OUTER_SPACING/2-EXTRA, -EXTRA])
        square([THICKNESS+EXTRA,2*INTER_CONNECTION_OFFSET+EXTRA], center=false);
    translate([-SPINES_OUTER_SPACING/2+THICKNESS/2, 3*INTER_CONNECTION_OFFSET])
        circle(d=INTERCONNECT_BOLT_DIAMETER);
    
    translate([SPINES_OUTER_SPACING/2-THICKNESS, INTER_CONNECTION_OFFSET])
    rotate([0,0,-90])
        TSlot();
    translate([SPINES_OUTER_SPACING/2-THICKNESS, -EXTRA])
        square([THICKNESS+EXTRA,2*INTER_CONNECTION_OFFSET+EXTRA], center=false);
    translate([SPINES_OUTER_SPACING/2-THICKNESS/2, 3*INTER_CONNECTION_OFFSET])
        circle(d=INTERCONNECT_BOLT_DIAMETER);

    translate(FIRST_CABLE_GUIDE_LOC)
        CableGuides(numGuides);

}

module Supports(shift, minorRadius, numGuides)
{
    difference() {
        Supports_Pos(shift, minorRadius);
        Supports_Neg(shift, minorRadius, numGuides);
    }
}

//Supports(-10, 80);

module Rib_Pos(shift, minorRadius, cantAngle)
{
    Supports_Pos(shift, minorRadius);
    translate([shift,minorRadius+FINGERBOARD_CENTER_HEIGHT,0]) rotate([0,0,cantAngle])
        Fingerboard_Pos(minorRadius);
}

module Rib_Neg(shift, minorRadius, cantAngle, numGuides)
{
    Supports_Neg(shift, minorRadius, numGuides);
    translate([shift,minorRadius+FINGERBOARD_CENTER_HEIGHT,0]) rotate([0,0,cantAngle])
        Fingerboard_Neg(minorRadius);
}

module Rib(shift, minorRadius, cantAngle, numGuides)
{
    translate([SPINES_OUTER_SPACING/2 - THICKNESS/2, -2*INTER_CONNECTION_OFFSET])
    difference() {
        Rib_Pos(shift, minorRadius, cantAngle);
        Rib_Neg(shift, minorRadius, cantAngle, numGuides);
    }
}

Rib(RIB_A_SHIFT, RIB_A_RADIUS, RIB_A_PITCH, 3);
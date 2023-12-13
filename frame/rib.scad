include <util.scad>
include <params.scad>

// PARAMETERS SPECIFIC TO THIS ASSEMBLY

// The (un-reduced by the connection step) width of the front and back legs
LEG_WIDTH = 20;

// The height of the lowest point of the top side of the fingerboard (the fingerboard PCB will go as low as this)
FINGERBOARD_CENTER_HEIGHT = 35;

// The thickness of the fingerboard body
FINGERBOARD_THICKNESS = 10;

// The arclength of the fingerboard body (not including rounded ends)
FINGERBOARD_LENGTH = 80;

FINGERBOARD_FORWARD_EXTENT = 37;
FINGERBOARD_REARWARD_EXTENT = 40;

FOOT_HEIGHT = 1.0;

FOOT_LENGTH = 2.0;


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
module CableSlotAt(radius, x)
{
    rotate([0,0,angleFromLen(radius, x)]) translate([0,-radius,0])
        CableSlot();
}

module TSlotAt(radius, x)
{
    rotate([0,0,angleFromLen(radius, x)]) translate([0,-radius,0])
        TSlot();
}

module FootAt(radius, x)
{
    EXTRA = 1;
    rotate([0,0,angleFromLen(radius, x - FOOT_LENGTH)]) translate([0,-radius-EXTRA,0])
        square([FOOT_LENGTH, FOOT_HEIGHT+EXTRA], center=false);
}

module Fingerboard_Pos(minorRadius)
{
    FINGERBOARD_TOTAL_ANGLE = angleFromLen(minorRadius, FINGERBOARD_FORWARD_EXTENT+FINGERBOARD_REARWARD_EXTENT);

    FINGERBOARD_ANGLE_BIAS = angleFromLen(minorRadius, (FINGERBOARD_FORWARD_EXTENT-FINGERBOARD_REARWARD_EXTENT)/2);
    
    rotate([0,0,FINGERBOARD_ANGLE_BIAS])
        CocktailSausage(minorRadius, FINGERBOARD_TOTAL_ANGLE, FINGERBOARD_THICKNESS);
    
    FootAt(minorRadius, -38);
}

module Fingerboard_Neg(minorRadius)
{
    LegSlotAt(minorRadius, -30);
    TSlotAt(minorRadius, -20);
    LegSlotAt(minorRadius, -10);
    TSlotAt(minorRadius, 0);
    LegSlotAt(minorRadius, 10);
    TSlotAt(minorRadius, 20);
    CableSlotAt(minorRadius, 29);
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
    FINGERBOARD_MAJOR_RADIUS = minorRadius + FINGERBOARD_THICKNESS;
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

module Supports_Neg(shift, minorRadius)
{
    translate([-SPINES_OUTER_SPACING/2+THICKNESS, INTER_CONNECTION_OFFSET])
    rotate([0,0,90])
        TSlot();
    translate([-SPINES_OUTER_SPACING/2, 0])
        square([THICKNESS,2*INTER_CONNECTION_OFFSET], center=false);
    translate([-SPINES_OUTER_SPACING/2+THICKNESS/2, 3*INTER_CONNECTION_OFFSET])
        circle(d=BOLT_DIAMETER);
    
    translate([SPINES_OUTER_SPACING/2-THICKNESS, INTER_CONNECTION_OFFSET])
    rotate([0,0,-90])
        TSlot();
    translate([SPINES_OUTER_SPACING/2-THICKNESS, 0])
        square([THICKNESS,2*INTER_CONNECTION_OFFSET], center=false);
    translate([SPINES_OUTER_SPACING/2-THICKNESS/2, 3*INTER_CONNECTION_OFFSET])
        circle(d=BOLT_DIAMETER);

}

module Supports(shift, minorRadius)
{
    difference() {
        Supports_Pos(shift, minorRadius);
        Supports_Neg(shift, minorRadius);
    }
}

//Supports(-10, 80);

module Rib_Pos(shift, minorRadius, cantAngle)
{
    Supports_Pos(shift, minorRadius);
    translate([shift,minorRadius+FINGERBOARD_CENTER_HEIGHT,0]) rotate([0,0,cantAngle])
        Fingerboard_Pos(minorRadius);
}

module Rib_Neg(shift, minorRadius, cantAngle)
{
    Supports_Neg(shift, minorRadius);
    translate([shift,minorRadius+FINGERBOARD_CENTER_HEIGHT,0]) rotate([0,0,cantAngle])
        Fingerboard_Neg(minorRadius);
}

module Rib(shift, minorRadius, cantAngle)
{
    translate([SPINES_OUTER_SPACING/2 - THICKNESS/2, -2*INTER_CONNECTION_OFFSET])
    difference() {
        Rib_Pos(shift, minorRadius, cantAngle);
        Rib_Neg(shift, minorRadius, cantAngle);
    }
}

Rib(RIB_A_SHIFT, RIB_A_RADIUS, RIB_A_PITCH);
include <util.scad>
include <params.scad>

// PARAMETERS SPECIFIC TO THIS ASSEMBLY

// The height of the lowest point of the top side of the fingerboard (the fingerboard PCB will go as low as this)
FINGERBOARD_CENTER_HEIGHT = 40;

// The thickness of the fingerboard body
RIB_THICKNESS = 15;

RIB_FORWARD_EXTENT = 37;
RIB_REARWARD_EXTENT = 40;

FOOT_HEIGHT = 1.0;

FOOT_LENGTH = 2.0;


FIRST_CABLE_GUIDE_LOC = [5,25];
CABLE_GUIDE_OFFSET = [-5,0];

FORWARD_STABILIZER_LOC = 30;

STABILIZER_SEAT_ANGLE = 10;

STABILIZER_SEAT_EXTRA_WIDTH = 2;

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

module RearwardStabilizerSlot()
{
    EXTRA = 1;

    WIDTH = THICKNESS + STABILIZER_SEAT_EXTRA_WIDTH;

    INNER_DEPTH = STABILIZER_HEIGHT + THICKNESS * tan(STABILIZER_SEAT_ANGLE);
    OUTER_DEPTH = STABILIZER_HEIGHT - STABILIZER_SEAT_EXTRA_WIDTH * tan(STABILIZER_SEAT_ANGLE);

    polygon(points = [
        [-WIDTH + THICKNESS/2, -OUTER_DEPTH],
        [THICKNESS/2, -INNER_DEPTH],
        [THICKNESS/2, EXTRA],
        [-WIDTH + THICKNESS/2, EXTRA]]);
}

module ForwardStabilizerSlot()
{
    scale([-1,1,1]) RearwardStabilizerSlot();
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

module Fingerboard(minorRadius)
{
    FINGERBOARD_TOTAL_ANGLE = angleFromLen(minorRadius, RIB_FORWARD_EXTENT+RIB_REARWARD_EXTENT);
    FINGERBOARD_ANGLE_BIAS = angleFromLen(minorRadius, (RIB_FORWARD_EXTENT-RIB_REARWARD_EXTENT)/2);
    
    pn_pos() {
        rotate([0,0,FINGERBOARD_ANGLE_BIAS])
            CocktailSausage(minorRadius, FINGERBOARD_TOTAL_ANGLE, RIB_THICKNESS);
        
        OnArc(minorRadius, -38) Foot();
    }

    pn_neg() {
        //OnArc(minorRadius, -30) LegSlot();
        OnArc(minorRadius, -30) RearwardStabilizerSlot();
        OnArc(minorRadius, -20) TSlot();
        OnArc(minorRadius, -10) LegSlot();
        OnArc(minorRadius, 0) TSlot();
        OnArc(minorRadius, 10) LegSlot();
        OnArc(minorRadius, 20) TSlot();
        //OnArc(minorRadius, 29) CableSlot();
        OnArc(minorRadius, 30) ForwardStabilizerSlot();
    }
}

module Supports(shift, minorRadius, numGuides)
{
    FINGERBOARD_MAJOR_RADIUS = minorRadius + RIB_THICKNESS;
    EXTRA=1;
    LARGE=100;

    pn_pos() {
        difference()
        {
            translate([-SPINES_OUTER_SPACING/2,0])
                square([SPINES_OUTER_SPACING, LARGE]);
            translate([shift, minorRadius+FINGERBOARD_CENTER_HEIGHT, 0])
                circle(r=FINGERBOARD_MAJOR_RADIUS-EXTRA);
        }
    }

    translate([SPINES_OUTER_SPACING/2,0]) rotate([0,0,90]) Interconnect("foo");
    scale([-1,1,1]) translate([SPINES_OUTER_SPACING/2,0]) rotate([0,0,90]) Interconnect("foo");

    translate(FIRST_CABLE_GUIDE_LOC)
        CableGuides(numGuides);
}

module Rib(shift, minorRadius, cantAngle, numGuides)
{
    Supports(shift, minorRadius, numGuides) children();

    translate([shift,minorRadius+FINGERBOARD_CENTER_HEIGHT,0]) rotate([0,0,cantAngle])
        Fingerboard(minorRadius) children();
}


module Rib_Anchored(shift, minorRadius, cantAngle, numGuides)
{
    rotate([0,0,90])
    translate([-SPINES_OUTER_SPACING/2+THICKNESS/2, -2*INTER_CONNECTION_OFFSET])
        Rib(shift, minorRadius, cantAngle, numGuides) children();
}

pn_top() Rib_Anchored(RIB_A_SHIFT, RIB_A_RADIUS, RIB_A_PITCH, 3);

//pn_top() Supports(RIB_A_SHIFT, RIB_A_RADIUS, 3);

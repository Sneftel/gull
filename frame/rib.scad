include <util.scad>
include <params.scad>

use <tcbody.scad>

// PARAMETERS SPECIFIC TO THIS ASSEMBLY

// The height of the lowest point of the top side of the fingerboard (the fingerboard PCB will go as low as this)
FINGERBOARD_CENTER_HEIGHT = 35;

// The thickness of the fingerboard body
RIB_THICKNESS = 20;

FOOT_HEIGHT = 1.0;

FOOT_LENGTH = 2.0;


FIRST_CABLE_GUIDE_LOC = [7,5];
CABLE_GUIDE_OFFSET = [-4,0];

FORWARD_STABILIZER_LOC = 30;

STABILIZER_SEAT_ANGLE = 10;

STABILIZER_SEAT_EXTRA_WIDTH = 2;

RIB_TCBODY_POINT = -45;

RIB_TCBODY_HEIGHT = -5;

RIB_TCBODY_ANGLE = -10;

CONNECTOR_CUTOUT_HEIGHT = 2;


module CableGuides(n)
{
    if(n>0) {
        CableGuide();
        translate(CABLE_GUIDE_OFFSET)
            CableGuides(n-1);
    }
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

    pn_neg() {
        polygon(points = [
            [-WIDTH + THICKNESS/2, -OUTER_DEPTH],
            [THICKNESS/2, -INNER_DEPTH],
            [THICKNESS/2, EXTRA],
            [-WIDTH + THICKNESS/2, EXTRA]]);
    }

    pn_anchor("stabilizer") children();
}

module ForwardStabilizerSlot()
{
    scale([-1,1,1]) RearwardStabilizerSlot() children();
}

module Foot()
{
    EXTRA = 1;
    translate([-FOOT_LENGTH,-EXTRA,0])
        pn_pos() square([FOOT_LENGTH, FOOT_HEIGHT+EXTRA], center=false);
}

module ConnectorCutout()
{
    EXTRA = 1;
    LARGE = 100;
    pn_neg() Rect(LARGE, CONNECTOR_CUTOUT_HEIGHT, ANCHOR_TL, extraY=EXTRA);
}

module OnArc(radius, x)
{
    rotate([0,0,angleFromLen(radius, x)]) translate([0,-radius,0])
        children();
}

module FingerboardPlatform(minorRadius, withTC)
{
    // The length of the rib's fingerboard platform forward of the center of the middle bolt hole
    RIB_FORWARD_EXTENT = FINGERBOARD_FORWARD_EXTENT;

    // The length of the rib's fingerboard platform forward of the center of the middle bolt hole
    RIB_REARWARD_EXTENT = FINGERBOARD_REARWARD_EXTENT + FOOT_LENGTH + (withTC ? 10 : 0);


    TOTAL_ANGLE = angleFromLen(minorRadius, RIB_FORWARD_EXTENT+RIB_REARWARD_EXTENT);
    ANGLE_BIAS = angleFromLen(minorRadius, (RIB_FORWARD_EXTENT-RIB_REARWARD_EXTENT)/2);
    
    rotate([0,0,ANGLE_BIAS])
    pn_pos()
        CocktailSausage(minorRadius, TOTAL_ANGLE, RIB_THICKNESS);
        
    OnArc(minorRadius, -FINGERBOARD_REARWARD_EXTENT) Foot();

    OnArc(minorRadius, -20) FingerboardTSlot();
    OnArc(minorRadius, -10) LegSlot();
    OnArc(minorRadius, 0) FingerboardTSlot();
    OnArc(minorRadius, 10) LegSlot();
    OnArc(minorRadius, 20) FingerboardTSlot();

    OnArc(minorRadius, -30) RearwardStabilizerSlot() children();
    OnArc(minorRadius, 30) ForwardStabilizerSlot() children();
    OnArc(minorRadius, 0) pn_anchor("pcb") children();

    OnArc(minorRadius, 34) ConnectorCutout();

    if(withTC) {
        OnArc(minorRadius, RIB_TCBODY_POINT) translate([0,RIB_TCBODY_HEIGHT]) rotate([0,0,90-RIB_TCBODY_ANGLE])
            TCBody_Anchored() children();
    }
}

module Supports(shift, minorRadius, numGuides)
{
    FINGERBOARD_MAJOR_RADIUS = minorRadius + RIB_THICKNESS;
    EXTRA=1;
    LARGE=100;

    pn_pos() {
        difference() {
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

module Rib(shift, minorRadius, cantAngle, numGuides, withTC)
{
    Supports(shift, minorRadius, numGuides) children();

    translate([shift,minorRadius+FINGERBOARD_CENTER_HEIGHT,0]) rotate([0,0,cantAngle])
        FingerboardPlatform(minorRadius, withTC) children();
}


module Rib_Anchored(shift, minorRadius, cantAngle, numGuides, withTC)
{
    rotate([0,0,90])
    translate([-SPINES_OUTER_SPACING/2+THICKNESS/2, -2*INTER_CONNECTION_OFFSET])
        Rib(shift, minorRadius, cantAngle, numGuides, withTC) children();
}

pn_top() Rib_Anchored(RIB_A_SHIFT, RIB_A_RADIUS, RIB_A_PITCH, 3, true);

//pn_top() Supports(RIB_A_SHIFT, RIB_A_RADIUS, 3);

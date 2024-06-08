// IMPORTANT PARAMETERS WHICH YOU MAY WELL WANT TO CUSTOMIZE
//
// These parameters are those you are most likely to want to customize because they relate directly to the positioning of the keys.
// Each parameter in this section is annotated with which parts it affects:
// S: spine
// RA, RB, RC: ribs (centermost to outermost)
// P: pelvis
// T: stabilizers
// N: TC neck
// B: TC body

// The nominal thickness of the sheet material. Parts will still mate and work properly if they vary from this width by up to THICKNESS_TOLERANCE. (S)
THICKNESS = 6; //0.1

// The kerf width of the cutter. Determine this by subtracting the measured width of a cut piece from the nominal width. If your laser cutter software supports kerf correction including clearout of reflex corners, you may want to set this to zero. (ALL)
KERF = 0.3;

// Whether certain inside corners with parts fitting into them should be cleared with dogbone fillets. Disabling this may prevent pieces from fitting together as cleanly, and increase the risk of cracking in T-slots.
CLEAR_INNER_CORNERS = true;

// The position of the join point between the inner ribs and the spine, in the plane of the spine (S)
RIB_A_POS = [-40,45];
// The angle in the plane of the spine by which the inner ribs are rolled away from the center (S)
RIB_A_ANGLE = 30;
// The distance by which the inner ribs are shifted backwards from having their lowest point centered between the spines (RA)
RIB_A_SHIFT = 0;
// The radius described by the fingerboards on the inner ribs (RA)
RIB_A_RADIUS = 80; //5
// The angle by which the fingerboards on the inner ribs are canted away from the user (RA)
RIB_A_PITCH = 10;

// The position of the join point between the second ribs and the spine, in the plane of the spine (S)
RIB_B_POS = [-82,25];
// The angle in the plane of the spine by which the second ribs are rolled away from the center (S)
RIB_B_ANGLE = 20;
// The distance by which the second ribs are shifted backwards from having their lowest point centered between the spines (RB)
RIB_B_SHIFT = 0;
// The radius described by the fingerboards on the second ribs (RB)
RIB_B_RADIUS = 80; //5
// The angle by which the fingerboards on the second ribs are canted away from the user (RB)
RIB_B_PITCH = 0;

// The position of the join point between the outer ribs and the spine, in the plane of the spine (S)
RIB_C_POS = [-125,15];
// The angle in the plane of the spine by which the outer ribs are rolled away from the center (S)
RIB_C_ANGLE = 10;
// The distance by which the outer ribs are shifted backwards from having their lowest point centered between the spines (RC)
RIB_C_SHIFT = 0;
// The radius described by the fingerboards on the outer ribs (RC)
RIB_C_RADIUS = 80; //5
// The angle by which the fingerboards on the outer ribs are canted away from the user (RC)
RIB_C_PITCH = 10;

// The angle by which each half of the keyboard is rotated backwards in the horizontal plane (P)
PELVIS_HALF_ANGLE = 20;

// Extra height added to the stabilizer beyond nominal height. This should be determined experimentally, to produce flat fingerboard ends (T)
STABILIZER_EXTRA_HEIGHT = 0.8;

// The vertical angle of the thumb cluster (RA)
TC_ELEVATION_ANGLE = 5;

// The distance by which the thumb clusters are shifted inwards from the innermost ribs (N)
TC_INWARD_SHIFT = 28;

// The distance by which the thumb clusters are shifted rearwards (towards the user) (N)
TC_REARWARD_SHIFT = 15;

// The distance by which the thumb clusters are shifted downwards-ish (RA)
TC_DOWNWARD_SHIFT = 5;


// PARAMETERS WHICH ARE USED BY MULTIPLE PARTS
//
// These are here because they're used across multiple files, or were at one time. Most of them don't need to be customized.

$fs = 0.1;
$fa = 2;

TC_INTERCONNECT_OFFSET = 5;

// Maximum allowed deviation from the nominal thickness
THICKNESS_TOLERANCE = 1; //0.1

// The distance between the connection step and the middle of the bolt hole or T-slot on either side.
PELVIS_SPINE_INTERCONNECT_OFFSET = 10;

// The distance between the connection step and the middle of the bolt hole or T-slot on either side.
SPINE_RIB_INTERCONNECT_OFFSET = 7;

// The diameter of the bolt holes and minor width of the T-slots
INTERCONNECT_BOLT_DIAMETER = 3.2;

// The length of the bolts to be used in interconnects between sheet parts. If washers are used, this should be reduced by the washer thickness.
INTERCONNECT_BOLT_LENGTH = 14;

// The diameter of a positive area surrounding the interconnect bolt hole
INTERCONNECT_WASHER_DIAMETER = 8;

INTERCONNECT_KEEPOUT = 4;

// The extra depth below the nut area of T-slots. This should be at least the maximum variance of the actual sheet material thickness below the nominal thickness, plus the maximum variance of the bolt length above the nominal length.
T_SLOT_EXTRA_DEPTH = 0.5;

// The width of the T-slot; this should be the width of your nuts
$T_SLOT_NUT_WIDTH = 6.2; //0.1

// The depth of the nut area of the T-slot; this should be the thickness of your nuts
$T_SLOT_NUT_DEPTH = 2; //0.1

// The offset of the nut area above the end of the screw in the T-slot. This should be at least the taper length
T_SLOT_NUT_OFFSET = 1.5; //0.1

// The radius of the circular "bumpers" at the opening of the T-slot
T_SLOT_BUMPER_RADIUS = 0.25;

// The distance between the outer extents of the front and back legs
SPINES_OUTER_SPACING = 50;

// The distance between the pelvis's rear center angle and its outer edges, measured along the spine angles
PELVIS_REAR_HALF_WIDTH = 40; //5

// The height of the bottom bar of the spine
SPINE_BASE_HEIGHT = 20;

// The length of the capsule-shaped cable guide cutouts. Should be greater than the width of the FFC ribbons.
CABLE_GUIDE_LENGTH = 6;

// The width of the capsule-shaped cable guide cutouts. Should be wide enough to make inserting the FFC ribbons easy.
CABLE_GUIDE_WIDTH = 2;

// The height of the stabilizers.
STABILIZER_HEIGHT = 8;

STABILIZER_OUTER_WIDTH = 29;
STABILIZER_INNER_WIDTH = 24;
STABILIZER_VERTICAL_INSET = 2.5;

// The length of the fingerboard forward of the center of the middle bolt hole
FINGERBOARD_FORWARD_EXTENT = 38;

// The length of the fingerboard rearward of the center of the middle bolt hole
FINGERBOARD_REARWARD_EXTENT = 38;


FINGERBOARD_THICKNESS = 0.8;
FINGERBOARD_BOLT_DIAMETER = 3;
FINGERBOARD_BOLT_LENGTH = 10;

FINGERBOARD_PCB_WIDTH = 36;

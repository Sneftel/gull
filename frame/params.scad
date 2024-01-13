// USED BY MULTIPLE PARTS

$fs = 0.1;
$fa = 2;

// The nominal thickness of the sheet material. Parts will still mate and work properly if they vary from this width (but see INTERCONNECT_BOLT_EXTRA_LENGTH).
THICKNESS = 6; //0.1

THICKNESS_TOLERANCE = 1; //0.1

// The distance between the connection step and the middle of the bolt hole or T-slot on either side.
INTER_CONNECTION_OFFSET = 7;

// The diameter of the bolt holes and minor width of the T-slots
INTERCONNECT_BOLT_DIAMETER = 3;

// The length of the bolts to be used in interconnects between sheet parts. If washers are used, this should be reduced by the washer thickness.
INTERCONNECT_BOLT_LENGTH = 12;

// The extra depth below the nut area of T-slots. This should be at least the length of the taper at the bottom of the bolts, plus the maximum variance of the actual sheet material thickness below the nominal thickness, plus the maximum variance of the bolt length above the nominal length.
INTERCONNECT_BOLT_EXTRA_LENGTH = 3;

// The radius of the strain reliefs in the T-slots
STRAIN_RELIEF_RADIUS = 0.25; //0.01

// The total depth of the T-slot from the opening to the end of the bolt area
T_SLOT_DEPTH = INTERCONNECT_BOLT_LENGTH + INTERCONNECT_BOLT_EXTRA_LENGTH - THICKNESS;

// The width of the T-slot; this should be the width of your nuts
T_SLOT_WIDTH = 6; //0.1

// The width of the bolt area
T_SLOT_MINOR_WIDTH = INTERCONNECT_BOLT_DIAMETER;

// The depth of the nut area of the T-slot; this should be the thickness of your nuts
T_SLOT_NUT_DEPTH = 2; //0.1

// The offset of the nut area below the opening of the T-slot
T_SLOT_NUT_OFFSET = 3; //0.1

// The distance between the outer extents of the front and back legs
SPINES_OUTER_SPACING = 50;


LEG_SLOT_DEPTH = 2;
LEG_SLOT_WIDTH = 2;


// The position of the join point between the inner ribs and the spine, in the plane of the spine
RIB_A_POS = [-45,55];
// The angle in the plane of the spine by which the inner ribs are rolled away from the center
RIB_A_ANGLE = 30;
// The distance by which the inner ribs are shifted backwards from having their lowest point centered between the spines
RIB_A_SHIFT = 0;
// The radius described by the fingerboards on the inner ribs
RIB_A_RADIUS = 80; //5
// The angle by which the fingerboards on the inner ribs are canted away from the user
RIB_A_PITCH = 10;


// The position of the join point between the second ribs and the spine, in the plane of the spine
RIB_B_POS = [-90,30];
// The angle in the plane of the spine by which the second ribs are rolled away from the center
RIB_B_ANGLE = 20;
// The distance by which the second ribs are shifted backwards from having their lowest point centered between the spines
RIB_B_SHIFT = 0;
// The radius described by the fingerboards on the second ribs
RIB_B_RADIUS = 80; //5
// The angle by which the fingerboards on the second ribs are canted away from the user
RIB_B_PITCH = 0;

// The position of the join point between the outer ribs and the spine, in the plane of the spine
RIB_C_POS = [-140,15];
// The angle in the plane of the spine by which the outer ribs are rolled away from the center
RIB_C_ANGLE = 10;
// The distance by which the outer ribs are shifted backwards from having their lowest point centered between the spines
RIB_C_SHIFT = 0;
// The radius described by the fingerboards on the outer ribs
RIB_C_RADIUS = 80; //5
// The angle by which the fingerboards on the outer ribs are canted away from the user
RIB_C_PITCH = 10;

// The angle by which each half of the keyboard is rotated backwards in the horizontal plane
PELVIS_HALF_ANGLE = 20;

// The distance between the pelvis's rear center angle and its outer edges, measured along the spine angles
PELVIS_REAR_HALF_WIDTH = 30; //5

// The height of the bottom bar of the spine
SPINE_BASE_HEIGHT = 20;


CABLE_GUIDE_LENGTH = 7;
CABLE_GUIDE_WIDTH = 1;

STABILIZER_HEIGHT = 8;

// A tool to find the best value for $T_SLOT_NUT_DEPTH (one which will lightly grip the nut for assembly). 

include <util.scad>
include <params.scad>
include <pn.scad>

DEPTHS = [1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8];
SPACING = T_SLOT_WIDTH + 4;
TESTER_WIDTH = (len(DEPTHS)+1) * SPACING;
TESTER_DEPTH = INTERCONNECT_BOLT_LENGTH + T_SLOT_EXTRA_DEPTH;


module TNutTester()
{
	pn_pos() Rect(TESTER_WIDTH, TESTER_DEPTH, ANCHOR_TL);
	for(i = [0:len(DEPTHS)-1]) {
		translate([(i+1)*SPACING, 0]) {
			let($T_SLOT_NUT_DEPTH = DEPTHS[i])
			 	InterconnectTSlot();
			 translate([0, -(INTERCONNECT_BOLT_LENGTH+T_SLOT_EXTRA_DEPTH-THICKNESS+1)])
			 	pn_neg() text(text=str(DEPTHS[i]), halign="center", valign="top", size=2);
		}
	}
}

pn_top() TNutTester();

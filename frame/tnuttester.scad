/* A tool to find the best value for T slot nut width and depth, given your material, cutter, and nut.

To use this:
  1. Find the narrowest T-slot (from the top row) which allows easy insertion of the nut, and which allows the
     nut to rotate only a tiny amount when a bolt is screwed into it.
  2. Find the slot in that column which grips the nut enough to hold it during assembly without making it
     at all difficult to insert.
*/

include <util.scad>
include <params.scad>
include <pn.scad>

DEPTHS = [1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8];

WIDTHS = [4.5, 4.75, 5, 5.25, 5.5, 5.75, 6];

X_SPACING = $T_SLOT_NUT_WIDTH + 4;
Y_SPACING = 5;
SECOND_ROW_EXTRA_SPACING = 1;

TESTER_WIDTH = (len(WIDTHS)+1) * X_SPACING;
TESTER_DEPTH = (len(DEPTHS)+1) * Y_SPACING + 3;


module NutHatch()
{
	pn_neg() Rect($T_SLOT_NUT_WIDTH, $T_SLOT_NUT_DEPTH, ANCHOR_TC);
	translate([-$T_SLOT_NUT_WIDTH/2, 0])
		pn_neg() circle(r=STRAIN_RELIEF_RADIUS);
	translate([$T_SLOT_NUT_WIDTH/2, 0])
		pn_neg() circle(r=STRAIN_RELIEF_RADIUS);
	pn_neg() Rect(INTERCONNECT_BOLT_DIAMETER, $T_SLOT_NUT_DEPTH + 1, ANCHOR_TC, extraY = 1);
}

module TNutTester()
{
	pn_pos() Rect(TESTER_WIDTH, TESTER_DEPTH, ANCHOR_TL);
	for(iw = [0:len(WIDTHS)-1]) {
		translate([(iw+1)*X_SPACING, -TESTER_DEPTH + 2])
		 	pn_neg() text(text=str(WIDTHS[iw]), halign="center", valign="bottom", size=2);
		for(id = [0:len(DEPTHS)-1]) {
			let($T_SLOT_NUT_WIDTH = WIDTHS[iw], $T_SLOT_NUT_DEPTH = DEPTHS[id]) {
				if(id == len(DEPTHS)-1) {
					translate([(iw+1)*X_SPACING, 0])
						InterconnectTSlot();
				} else {
					translate([(iw+1)*X_SPACING, -(len(DEPTHS)-id)*Y_SPACING-SECOND_ROW_EXTRA_SPACING])
						NutHatch();
				}
			}
		}
	}
	for(id = [0:len(DEPTHS)-1]) {
		translate([1, -(len(DEPTHS)-id)*Y_SPACING])
			pn_neg() text(text=str(DEPTHS[id]), halign="left", valign="top", size=2);
	}
}

/*			 
			 	*/
pn_top() TNutTester();

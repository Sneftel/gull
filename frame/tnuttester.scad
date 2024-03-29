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

DEPTHS = [1.9, 1.95, 2.0, 2.05, 2.1];

WIDTHS = [5.8, 5.9, 6, 6.1, 6.2];

X_SPACING = $T_SLOT_NUT_WIDTH + 4;
Y_SPACING = 5;
SECOND_ROW_EXTRA_SPACING = 1;

TESTER_WIDTH = (len(WIDTHS)+1) * X_SPACING;
TESTER_DEPTH = (len(DEPTHS)+1) * Y_SPACING + 3;

ESCAPE_WIDTH = INTERCONNECT_BOLT_DIAMETER;

module NutHatch()
{
	pn_neg() Rect($T_SLOT_NUT_WIDTH, $T_SLOT_NUT_DEPTH, ANCHOR_CT);
	translate([-$T_SLOT_NUT_WIDTH/2, 0])
		ClearedCorner(-135);
	translate([$T_SLOT_NUT_WIDTH/2, 0])
		ClearedCorner(135);
}

module TNutTester()
{
	pn_pos() Rect(TESTER_WIDTH, TESTER_DEPTH, ANCHOR_LT);
	for(iw = [0:len(WIDTHS)-1]) {
		translate([(iw+1)*X_SPACING, -TESTER_DEPTH + 1])
		 	_pn_label("text") text(text=str(WIDTHS[iw]), halign="center", valign="bottom", font="Calibri:style=Light", size=2);
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
        
        translate([(iw+1)*X_SPACING, -2*Y_SPACING])
            pn_neg() Rect(ESCAPE_WIDTH, (len(DEPTHS)-1)*Y_SPACING-1, ANCHOR_CT);
	}
	for(id = [0:len(DEPTHS)-1]) {
		translate([0.5, -(len(DEPTHS)-id)*Y_SPACING])
			_pn_label("text") text(text=str(DEPTHS[id]), halign="left", valign="top", font="Calibri:style=Light", size=2);
	}
}

difference() {
	Dekerf() pn_top() TNutTester();
	_pn_filter("text") TNutTester();
}


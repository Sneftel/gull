// A saddle shape which sits astride the front or back of a rib and supports the corners of the
// fingerboard to keep them from drooping. Held in place by friction, compressive force, and the 
// legs of keyswitches.

include <util.scad>
include <params.scad>

STABILIZER_OUTER_WIDTH = 29;
STABILIZER_INNER_WIDTH = 24;
STABILIZER_VERTICAL_INSET = 2.5;
STABILIZER_EXTRA_HEIGHT = 0.5;

module Stabilizer()
{
	LARGE = 100;
	difference() {
		Rect(STABILIZER_OUTER_WIDTH, STABILIZER_HEIGHT, ANCHOR_TC, extraY=STABILIZER_EXTRA_HEIGHT);
		Rect(STABILIZER_INNER_WIDTH, STABILIZER_VERTICAL_INSET, ANCHOR_TC, extraY=STABILIZER_EXTRA_HEIGHT);
	}
}

Stabilizer();

// The middle (relative to others on that side) ribs.

include <params.scad>
use <rib.scad>

module Rib_B()
{
	Rib_Anchored(RIB_B_SHIFT, RIB_B_RADIUS, RIB_B_PITCH, false) children();
}

Dekerf() pn_top() Rib_B();

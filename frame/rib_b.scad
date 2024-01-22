include <params.scad>
use <rib.scad>

module Rib_B()
{
	Rib_Anchored(RIB_B_SHIFT, RIB_B_RADIUS, RIB_B_PITCH, 2, false) children();
}

pn_top() Rib_B();

include <params.scad>
use <rib.scad>

module Rib_C()
{
	Rib_Anchored(RIB_C_SHIFT, RIB_C_RADIUS, RIB_C_PITCH, 1, false) children();
}

pn_top() Rib_C();

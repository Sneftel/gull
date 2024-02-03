// The center-most ribs.

include <params.scad>
use <rib.scad>

module Rib_A()
{
	Rib_Anchored(RIB_A_SHIFT, RIB_A_RADIUS, RIB_A_PITCH, 4, true) children();
}

Dekerf() pn_top() Rib_A();

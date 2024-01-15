include <params.scad>
use <rib.scad>

module Rib_B()
{
	Rib(RIB_B_SHIFT, RIB_B_RADIUS, RIB_B_PITCH, 2) children();
}

Rib_B();

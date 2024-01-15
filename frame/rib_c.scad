include <params.scad>
use <rib.scad>

module Rib_C()
{
	Rib(RIB_C_SHIFT, RIB_C_RADIUS, RIB_C_PITCH, 1) children();
}

Rib_C();

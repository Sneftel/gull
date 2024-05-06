/* A simple library for filtering and injecting geometry.

Supports two features:
  1. Positive/negative: allows modules to introduce negative shapes which are effectively hoisted
     to the top level. So you can, say, put a screw hole in a part, and that hole will definitely
     be cut out, even if some higher level union'ed the part with something else covering the hole.
  2. Anchors: allows a module to be used for its chain of transforms, injecting child geometry at
     a particular named point in the tree. In this mode, positive and negative shapes are ignored.

For the anchoring functionality to work, modules which expect to have pn_attach as an ancestor, or
pn_anchor as a descendant, should wrap all geometry in pn_pos or pn_neg and should pass children()
through to modules which themselves might have pn_anchor as a descendant. In general, push pn_pos
and pn_neg as far towards the leaves as you can. And remember, it's okay to use difference() under
pn_pos.
*/

// Internal use only. Passes through the child geometry if and only if the lexical label matches that
// given in the parameter.
//
// Paradoxically, this function "does the filtering". Notionally, however, its label is constant, and
// the lexical label varies by invocation.
module _pn_label(label)
{
	assert(is_string(label), "A string giving the label must be passed to _pn_label");
	assert(is_string($PN_FILTER_LABEL), "_pn_label() should be under a _pn_filter()");

	if($PN_FILTER_LABEL == label) {
		children();
	}
}

// Internal use only. Sets the lexical label for child geometry.
//
// Paradoxically, this function "sets the label". Notionally, however, its labeling is variable, and the
// child geometry's labels are constant.
module _pn_filter(label)
{
	assert(is_string(label), "A string giving the label must be passed to _pn_filter");

	let($PN_FILTER_LABEL = label) {
		children();
	}
}

// Marks the child geometry as being positive geometry. This should always have pn_top or pn_attach as 
// an ancestor. 
module pn_pos()
{
	_pn_label("pos") children();
}

// Marks the child geometry as being negative geometry. This should always have pn_top or pn_attach as 
// an ancestor. 
module pn_neg()
{
	_pn_label("neg") children();
}

// Marks the child geometry as being especially positive geometry, which will override mere pn_neg()s.
// This should always have pn_top or pn_attach as an ancestor. 
module pn_pospos()
{
	_pn_label("pospos") children();
}

// Marks the child geometry as being especially negative geometry, which will override all geometry,
// even pn_pospos(). This should always have pn_top or pn_attach as an ancestor. 
module pn_negneg()
{
	_pn_label("negneg") children();
}

// Outputs the positive geometry, minus the negative geometry. All geometry under this should be wrapped
// in pn_pos or pn_neg.
module pn_top()
{
	difference() {
		union() {
			difference() {
				_pn_filter("pos") children();
				_pn_filter("neg") children();
			}
			_pn_filter("pospos") children();
		}
		_pn_filter("negneg") children();
	}
}

// Specifies an anchor with the given name. If this is a descendant of a matching pn_attach, passes
// through the child geometry.
module pn_anchor(name)
{
	_pn_label(str("anchor_", name)) {
		assert($children != 0, str("Children were not passed through to anchor ", name))
		children();
	}
}

// Passes through the child geometry, with that child's own child geometry injected at the matching
// pn_attach.
module pn_attach(name)
{
	_pn_filter(str("anchor_", name)) children();
}

//$PN_FILTER_LABEL = undef;
module _pn_label(label)
{
	assert(is_string(label), "A string giving the label must be passed to _pn_label");
	assert(is_string($PN_FILTER_LABEL), "_pn_label() should be under a _pn_filter()");

	if($PN_FILTER_LABEL == label) {
		children();
	}
}

module _pn_filter(label)
{
	assert(is_string(label), "A string giving the label must be passed to _pn_filter");

	let($PN_FILTER_LABEL = label) {
		children();
	}
}

module pn_pos()
{
	_pn_label("pos") children();
}

module pn_neg()
{
	_pn_label("neg") children();
}

module pn_posneg()
{
	assert($children == 2, "pn_posneg must have two children");
	_pn_label("pos") children(0);
	_pn_label("neg") children(1);
}

module pn_top()
{
	difference() {
		_pn_filter("pos") children();
		_pn_filter("neg") children();
	}
}

module pn_anchor(name)
{
	_pn_label(str("anchor_", name)) {
		assert($children != 0, str("Children were not passed through to anchor ", name))
		children();
	}
}

module pn_attach(name)
{
	_pn_filter(str("anchor_", name)) children();
}

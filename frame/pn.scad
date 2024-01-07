$PN_FILTER_LABEL = undef;
module _pn_label(label)
{
	assert(is_string(label), "A string giving the label must be passed to _pn_label");
	assert(is_string($PN_FILTER_LABEL), "_pn_label() should be under a _pn_filter()");

	if($PN_FILTER_LABEL == label)
	{
		children();
	}
}

module _pn_filter(label)
{
	assert(is_string(label), "A string giving the label must be passed to _pn_filter");
	assert(is_undef($PN_FILTER_LABEL) || $PN_FILTER_LABEL == label, 
		str("Can't filter for label ", label, " while filtering for label ", $PN_FILTER_LABEL));

	let($PN_FILTER_LABEL = label)
	{
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
	if(is_undef($PN_FILTER_LABEL)) {
		difference()
		{
			_pn_filter("pos") children();
			_pn_filter("neg") children();
		}
	} else {
		children();
	}
}

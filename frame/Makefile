.PHONY: dxfs svgs clean

DEPS = params.scad util.scad pn.scad tccommon.scad tcbody.scad

OPENSCAD = openscad

PARTS = pelvis spine rib_a rib_b rib_c tcneck stabilizer tnuttester

$(addprefix dxf/, $(PARTS:=.dxf)): dxf/%.dxf: %.scad $(DEPS)
	mkdir -p dxf
	$(OPENSCAD) -o $@ $<

$(addprefix svg/, $(PARTS:=.svg)): svg/%.svg: %.scad $(DEPS)
	mkdir -p svg
	$(OPENSCAD) -o $@ $<

dxfs: $(addprefix dxf/, $(PARTS:=.dxf))
svgs: $(addprefix svg/, $(PARTS:=.svg))

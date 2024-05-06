.PHONY: clean default

default: svg.zip

include $(wildcard deps/*.deps)

OPENSCAD = openscad
ZIP = zip

PARTS = pelvis spine rib_a rib_b rib_c tcneck tcbody stabilizer clamp tnuttester

svg.zip: $(addprefix svg/, $(PARTS:=.svg))
	$(ZIP) $@ -FS $^

dxf.zip: $(addprefix dxf/, $(PARTS:=.dxf))
	$(ZIP) $@ -FS $^

svg/%.svg : %.scad
	@mkdir -p deps svg
	$(OPENSCAD) -m make -o $@ -d deps/$(@F).deps $<

dxf/%.dxf : %.scad
	@mkdir -p deps dxf
	$(OPENSCAD) -m make -o $@ -d deps/$(@F).deps $<

clean:
	rm -rf svg dxf svg.zip dxf.zip

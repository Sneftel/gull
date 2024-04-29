.PHONY: dxfs svgs clean

include $(wildcard deps/*.deps)

OPENSCAD = openscad

PARTS = pelvis spine rib_a rib_b rib_c tcneck tcbody stabilizer tnuttester
dxfs: $(addprefix dxf/, $(PARTS:=.dxf))
svgs: $(addprefix svg/, $(PARTS:=.svg))

dxf/%.dxf : %.scad
	mkdir -p dxf
	mkdir -p deps
	$(OPENSCAD) -m make -o $@ -d deps/$(@F).deps $<

svg/%.svg : %.scad
	mkdir -p svg
	mkdir -p deps
	$(OPENSCAD) -m make -o $@ -d deps/$(@F).deps $<

clean:
	rm -rf dxf
	rm -rf svg

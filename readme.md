# Gull

Gull is a dished ergonomic keyboard. It contains no 3D-printed parts and no hand-wired circuitry, and is designed for rapid constructibility rather than aesthetics. Keys are inserted into thin FR4 PCBs which are bent to the frame.

The raison d'etre of Gull is to be rapidly assembled, tweaked, and remade. The frame is fully parameterized, and changing a parameter generally only requires recutting one shape. PCBs can be reused after changing almost any parameters. The exposed ribbon cables make it potentially impractical for portable use.

The key layout is essentially 3x6 on each side. There are six additional keys per side, two in the bottom center of each side and four (relatively inaccessible) keys at the top corners of each side.

PCB layout is in KiCad. Frame shapes are in OpenSCAD.

## Tools

The frame for Gull must be cut from acrylic or similar using a laser cutter.

The PCBs have surface-mount components. A hotplate is the best tool for soldering these, but hand soldering is also possible. Hot air reflow can be used but be aware of temperature limits for the FFC connectors.

## Materials

I use six millimeter-thick acrylic for the frame. Eight millimeter will also work. Below six millimeters is not recommended. Plywood will likely also be acceptable, though I have not tested the most recent shapes with plywood.

The finger and thumb PCBs should be fabricated from 0.8mm-thick FR4. I have not tested other materials or thicknesses. The center PCB should be fabricated from thicker FR4 (I use standard 1.6mm-thick FR4).

## Parts

The following parts are required:

### Hardware 

* 38 14mm-long M3 bolts (not countersunk)
* 22 10mm-long M3 bolts (not countersunk)
* 56 6mm M3 square nuts
* 4 4mm female-threaded hex spacers
* 4 M3 hex nuts

### Components

* 56 Kailh Choc V1 low-profile keyswitches
* 56 Choc V1 keycaps
* 56 0805 diodes
* 16 vertical FFC connectors, 10 pin, 0.5mm pitch
    * IMPORTANT NOTE: Currently the fingerboards and centerboards use horizontal FFC connectors, with different footprints. Either use horizontal connectors for these, or wait for me to update the PCBs and the fingerboard design.
* 8 FFC ribbon cables in various lengths from 10cm to 25cm, 10pin, 0.5mm pitch, type B (opposite side contacts)
* Pins and sockets for a Pro Micro MCU
* Pro Micro MCU (or pinout-compatible)

### Laser-cut pieces

* 6 ribs, 2 for each position
* 4 spines
* 2 thumb cluster necks
* 2 thumb cluster bodies
* 12 stabilizers
* 1 pelvis

### PCBs

* 6 fingerboards, in 0.8mm FR4
* 2 thumbboards, in 0.8mm FR4
* 1 centerboard, in 1.6mm FR4 or similar

## Customization

Most customization should be done through frame/params.scad. This file contains almost all parameters one might want to tweak, and documents which pieces are affected by which parameters. 

To visualize the keyboard as a whole, open frame/main.scad. This file should not be used to generate shapes for laser cutting.

The OpenSCAD files dilate some parts to account for the laser cutter's kerf. If your cutter's control software includes this as a feature, you should either disable it in the control software, or disable the dilation by setting the KERF parameter in params.scad to 0. Otherwise, cut a 10mm square, measure the average of its side lengths and subtract that from 10, and set KERF to that value. If the kerf is above 0.6 or so, you may have trouble getting things to fit firmly.

For easy assembly, it's useful for the square nuts to firmly friction-fit into the T-slots. This requires a fairly tight tolerance. The "tnuttester.scad" file can be used to empirically determine the right parameters for this, given a particular laser cutter and material. See the comments in that file for how to use it.

## Fabrication

### PCBs

The fingerboards and centerboard may be panelized or printed as-is. 

The thumbboard has delicately narrow areas and should be carefully panelized for fabrication. I use KiKit for this, with "panelize.json" containing the necessary presets. (I'll add the pre-panelized version in a couple of days.) Make sure to mention the need for V-cuts to the PCB fabricator. Mousebites would also work.

### Laser-cut shapes

Execute "make svg" or (on Windows) "makeall.bat svg" to generate SVG shapes for all laser-cut pieces. DXF and PDF outputs are also supported.

I use Deepnest.io to nest the pieces for printing. Consider manually nesting the stabilizers and printing them separately.

The OpenSCAD files dilate some parts to account for laser-cut kerf.

## Assembly

Follow the following steps for assembly:

### Solder the PCBs

The thumbboards should remain panelized until after both SM and TH components are soldered. 

Solder only one connector per thumbboard: J1 on one, J2 on the other.

### Assemble the frame

It's marginally easier to do this before attaching the thumb and finger PCBs. First attach the spines to the pelvis, then the ribs to the spine. (You will use only the 14mm bolts for these.)

Ideally, the square nuts can be press-fit into the T-slots and will stay there for assembly. If a fit is too loose or tight, try a different nut, or try rotating the nut. A drop of glue, or a piece of tape, can also be used to keep things in position.

### Mount thumbboards

Break off the frames, then carefully bend the row of three keys to insert into the body of the thumb cluster frame. Go slow and make sure the PCB is slotting in correctly. The fit should be firm but there should be no need to force anything.

Then fit square nuts into the thumb cluster necks and attach them. The left one will slide in from the bottom, the right one from the top. With 6mm material, the necks will not be flush against the stops on the PCB. Bolt the necks in while checking for centered and square positioning.

### Mount fingerboards

It's easiest to do this with two people, one bending the board to the frame and one inserting the 10mm bolts. Failing that, bend in as well as possible and attach the center bolt but do not fully tighten it. Then insert a stabilizer on each side (it will not yet fit firmly). Continue to bend and attach the other two bolts, then tighten everything down and adjust the stabilizers.

### Mount centerboard

Attach four 14mm bolts from the top of the centerboard and secure finger-tight with the 4mm spacers on the bottom. Insert the bolt shanks through the holes in the pelvis and secure with nuts.

### Attach cables

Insert and secure FFC ribbon cables in the centerboard one by one, fishing them through the frame and inserting them into the fingerboards and thumbbboards. Take care they are oriented properly, and if desired reverse them so the printing is on a consistent side.

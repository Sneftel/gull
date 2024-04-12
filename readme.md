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

* 34 14mm-long M3 bolts (not countersunk)
* 22 10mm-long M3 bolts (not countersunk)
* 52 6mm M3 square nuts
* 4 4mm female-threaded hex spacers
* 4 M3 hex nuts

### Components

* 56 Kailh Choc V1 low-profile keyswitches
* 56 Choc V1 keycaps
* 56 0805 diodes
* 16 vertical FFC connectors, 10 pin, 0.5mm pitch
** IMPORTANT NOTE: Currently the fingerboards and centerboards use horizontal FFC connectors, with different footprints. Either replace these in the PCB design, or wait for me to do it.
* 8 FFC ribbon cables in various lengths from 10cm to 25cm, 10pin, 0.5mm pitch
* Pins and sockets for a Pro Micro MCU
* Pro Micro MCU (or pinout-compatible)

### Laser-cut pieces

* 6 ribs, 2 for each position
* 4 spines
* 2 thumb cluster necks
* 12 stabilizers
* 1 pelvis

### PCBs

* 6 fingerboards, in 0.8mm FR4
* 2 thumbboards, in 0.8mm FR4
* 1 centerboard, in 1.6mm FR4 or similar

## Customization

Most customization should be done through frame/params.scad. This file contains almost all parameters one might want to tweak, and documents which pieces are affected by which parameters. 

To visualize the keyboard as a whole, open frame/main.scad. This file should not be used to generate shapes for laser cutting.

The OpenSCAD files dilate some parts to account for the laser cutter's kerf. If your cutter's control software includes this as a feature, you should either disable it in the control software, or disable the dilation by setting the KERF parameter in params.scad to 0.

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

todo

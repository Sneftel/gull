@echo off

set FORMAT=%1

if '%FORMAT%'=='' set /p FORMAT="Generate what format (dxf, svg, pdf)? "

set OPENSCAD="c:\Program Files\OpenSCAD\openscad.exe"
set PARTS=pelvis spine rib_a rib_b rib_c tcneck stabilizer tnuttester

if not exist %FORMAT% mkdir %FORMAT%

for %%p in (%PARTS%) do %OPENSCAD% -o %FORMAT%\%%p.%FORMAT% %%p.scad

@echo off

set FORMAT=%1

if '%FORMAT%'=='' set /p FORMAT="Generate what format (dxf, svg, pdf)? "

set OPENSCAD="c:\Program Files\OpenSCAD\openscad.exe"
set PARTS=pelvis spine rib_a rib_b rib_c tcneck tcbody stabilizer tnuttester

if not exist %FORMAT% mkdir %FORMAT%

del /s /q %FORMAT%\*.*

for %%p in (%PARTS%) do %OPENSCAD% -o %FORMAT%\%%p.%FORMAT% %%p.scad

if exist %FORMAT%.zip del %FORMAT%.zip

7z a %FORMAT%.zip %FORMAT%

@ECHO OFF

set KICAD_DIR="C:\Program Files\KiCad\7.0"

PUSHD .
CALL %KICAD_DIR%\bin\kicad-cmd.bat
POPD

ECHO
ECHO Panelizing...
kikit panelize -p panelize.json thumbboard.kicad_pcb thumbboard-panelized.kicad_pcb

ECHO Exporting...
kikit fab jlcpcb thumbboard-panelized.kicad_pcb .

ECHO Done.

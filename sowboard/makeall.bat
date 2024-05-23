@ECHO OFF

set KICAD_DIR="C:\Program Files\KiCad\7.0"

PUSHD .
CALL %KICAD_DIR%\bin\kicad-cmd.bat
POPD

ECHO Exporting...
kikit fab jlcpcb sowboard.kicad_pcb .

ECHO Done.

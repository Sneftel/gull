@ECHO OFF

IF EXIST gull RMDIR /S /Q gull
MKDIR gull

ECHO Building centerboard PCBs...
PUSHD centerboard
CALL makeall.bat
COPY /Y gerbers.zip ..\gull\centerboard.zip
POPD

ECHO Building fingerboard PCBs...
PUSHD fingerboard
CALL makeall.bat
COPY /Y gerbers.zip ..\gull\fingerboard.zip
POPD

ECHO Building thumbboard PCBs...
PUSHD thumbboard
CALL makeall.bat
COPY /Y gerbers.zip ..\gull\thumbboard.zip
POPD

ECHO Building frame SVGs...
PUSHD frame
CALL makeall.bat svg
COPY /Y svg.zip ..\gull\frame.zip
POPD

IF EXIST gull.zip DEL gull.zip
7z a gull.zip gull\*.*

RMDIR /S /Q gull

ECHO Done.

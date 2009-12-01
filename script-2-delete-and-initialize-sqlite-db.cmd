@ECHO OFF
SETLOCAL EnableDelayedExpansion

SET DATABASE_FILE=database-dev.db
SET CONFIG=development.ini
SET DATA_FOLDER=data
SET PASTER_EXE=pylons\Scripts\paster

IF NOT EXIST "%PASTER_EXE%" (
    SET PASTER_EXE=paster
)



IF EXIST "%DATABASE_FILE%" (
    ECHO ============================================
    ECHO Deleting old Database "%DATABASE_FILE%"
    DEL %DATABASE_FILE%
)

IF EXIST "%DATA_FOLDER%" (
    ECHO ============================================
    ECHO Deleting old Data folder "%DATA_FOLDER%"
    DEL /S /Q %DATA_FOLDER%
)

IF NOT EXIST "%DATA_FOLDER%" (
    mkdir %DATA_FOLDER%
)

ECHO ============================================
ECHO Running "setup-app" command to create the new database
ECHO ============================================

%PASTER_EXE% setup-app %CONFIG%

GOTO EXIT

:exit
pause
ENDLOCAL

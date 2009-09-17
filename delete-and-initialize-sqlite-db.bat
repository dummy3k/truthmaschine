@ECHO OFF
SETLOCAL EnableDelayedExpansion

SET DATABASE_FILE=database-dev.db
SET CONFIG=development.ini
SET DATA_FOLDER=data

IF NOT DEFINED PYLONS_VIRTUALDEV (
	ECHO Environment Variable PYLONS_VIRTUALDEV not definied
	GOTO exit
)

ECHO ============================================
ECHO Using PYLONS_VIRTUALDEV=%PYLONS_VIRTUALDEV%


IF NOT EXIST "%PYLONS_VIRTUALDEV%" (
	ECHO Directory %PYLONS_VIRTUALDEV% does not exist
	GOTO exit
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

ECHO ============================================
ECHO Running "setup-app" command to create the new database

"%PYLONS_VIRTUALDEV%\Scripts\paster" setup-app %CONFIG%

GOTO EXIT

:exit
pause
ENDLOCAL

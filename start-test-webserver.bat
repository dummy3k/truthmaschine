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

ECHO ============================================
ECHO Running "paster serve --reload %CONFIG%"

"%PYLONS_VIRTUALDEV%\Scripts\paster" serve --reload %CONFIG%"

GOTO EXIT

:exit
pause
ENDLOCAL

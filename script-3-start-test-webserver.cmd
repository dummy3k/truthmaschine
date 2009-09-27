@ECHO OFF
SETLOCAL EnableDelayedExpansion

SET DATABASE_FILE=database-dev.db
SET CONFIG=development.ini
SET DATA_FOLDER=data

ECHO ============================================
ECHO Running "paster serve --reload %CONFIG%"
ECHO ============================================

paster serve --reload %CONFIG%
GOTO EXIT

:exit
pause
ENDLOCAL

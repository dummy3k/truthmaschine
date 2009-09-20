@ECHO OFF
SETLOCAL EnableDelayedExpansion

SET DATABASE_FILE=database-dev.db
SET CONFIG=development.ini
SET DIST_FOLDER=dist

IF EXIST "%DIST_FOLDER%" (
    ECHO ============================================
    ECHO Deleting old output folder "%DIST_FOLDER%"
    DEL /S /Q %DIST_FOLDER%
)


ECHO ============================================
ECHO Running "python setup.py bdist_egg" command to create the new database
ECHO ============================================

python setup.py bdist_egg

GOTO EXIT

:exit
pause
ENDLOCAL

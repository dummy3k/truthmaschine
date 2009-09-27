@ECHO OFF
SETLOCAL EnableDelayedExpansion

ECHO ============================================
ECHO Running "easy_install sqlalchemy python-openid sqlalchemy-migrate PyRSS2Gen Babel" command to create the new database
ECHO ============================================

easy_install sqlalchemy python-openid sqlalchemy-migrate PyRSS2Gen Babel

GOTO EXIT

:exit
pause
ENDLOCAL

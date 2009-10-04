@ECHO OFF
SETLOCAL EnableDelayedExpansion

ECHO ============================================
ECHO Running "easy_install sqlalchemy python-openid sqlalchemy-migrate PyRSS2Gen Babel whoosh" command to create the new database
ECHO ============================================

easy_install sqlalchemy python-openid sqlalchemy-migrate PyRSS2Gen Babel whoosh

GOTO EXIT

:exit
pause
ENDLOCAL

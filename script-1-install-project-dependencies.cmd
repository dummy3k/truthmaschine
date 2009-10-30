@ECHO OFF
SETLOCAL EnableDelayedExpansion

ECHO ============================================
ECHO Running "easy_install sqlalchemy python-openid sqlalchemy-migrate PyRSS2Gen Babel whoosh" command to create the new database
ECHO ============================================

easy_install sqlalchemy python-openid sqlalchemy-migrate PyRSS2Gen Babel whoosh
easy_install -U http://dl.getdropbox.com/u/530973/Babel-1.0dev_r0-py2.6.egg

GOTO EXIT

:exit
pause
ENDLOCAL

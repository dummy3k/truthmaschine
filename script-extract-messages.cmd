@ECHO OFF
SETLOCAL EnableDelayedExpansion

SET PYTHON_EXE=pylons\Scripts\python

IF NOT EXIST "%PYTHON_EXE%" (
    SET PYTHON_EXE=python
)

ECHO ============================================
ECHO Running "python setup.py extract_messages" command to extract all messages
ECHO ============================================

%PYTHON_EXE% setup.py extract_messages

GOTO EXIT

:exit
pause
ENDLOCAL

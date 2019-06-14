@ECHO OFF

SET "INVIS_SKIPWAIT_VBS=%TEMP%\invis_nowait.vbs"
ECHO CreateObject("Wscript.Shell").Run """" ^& WScript.Arguments(0) ^& """", 1, FALSE> "%INVIS_SKIPWAIT_VBS%"

SET STARTUP_SCRIPTS_BAT=%USERPROFILE%\.startup-scripts\startup-%COMPUTERNAME%.bat
IF EXIST "%STARTUP_SCRIPTS_BAT%" (
	wscript.exe "%INVIS_SKIPWAIT_VBS%" "%STARTUP_SCRIPTS_BAT%"
)

SET STARTUP_SCRIPTS_LNK=%USERPROFILE%\.startup-scripts\startup-%COMPUTERNAME%.lnk
IF EXIST "%STARTUP_SCRIPTS_LNK%" (
	wscript.exe "%INVIS_SKIPWAIT_VBS%" "%STARTUP_SCRIPTS_LNK%"
)

EXIT

REM	------------------------------------------------------------
REM	Revisioning | 2018-11-28 | Created
REM	Revisioning | 2018-12-12 | Generalized parameters
REM	Revisioning | 2018-12-12 | New "~\.startup-scripts" format
REM	------------------------------------------------------------
REM	Author | Matt Cavallo | https://github.com/mcavallo-git
REM	------------------------------------------------------------

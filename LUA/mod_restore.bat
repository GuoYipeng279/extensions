@ECHO OFF
setlocal EnableDelayedExpansion

NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto START ) else ( goto getPrivileges ) 

:getPrivileges
if '%1'=='ELEV' ( goto START )

set "batchPath=%~f0"
set "batchArgs=ELEV"

::Add quotes to the batch path, if needed
set "script=%0"
set script=%script:"=%
IF '%0'=='!script!' ( GOTO PathQuotesDone )
    set "batchPath=""%batchPath%"""
:PathQuotesDone

::Add quotes to the arguments, if needed.
:ArgLoop
IF '%1'=='' ( GOTO EndArgLoop ) else ( GOTO AddArg )
    :AddArg
    set "arg=%1"
    set arg=%arg:"=%
    IF '%1'=='!arg!' ( GOTO NoQuotes )
        set "batchArgs=%batchArgs% "%1""
        GOTO QuotesDone
        :NoQuotes
        set "batchArgs=%batchArgs% %1"
    :QuotesDone
    shift
    GOTO ArgLoop
:EndArgLoop

::Create and run the vb script to elevate the batch file
ECHO Set UAC = CreateObject^("Shell.Application"^) > "%temp%\OEgetPrivileges.vbs"
ECHO UAC.ShellExecute "cmd", "/c ""!batchPath! !batchArgs!""", "", "runas", 1 >> "%temp%\OEgetPrivileges.vbs"
"%temp%\OEgetPrivileges.vbs" 
del "%temp%\OEgetPrivileges.vbs"
exit /B

:START
::Remove the elevation tag and set the correct working directory
IF '%1'=='ELEV' ( shift /1 )
cd /d %~dp0

::END OF UAC SCRIPT

echo ============================================================
echo    Deleting BSPRM files - Please wait...
echo ============================================================
RMDIR effects /S /Q
RMDIR fonts /S /Q
RMDIR interface /S /Q
RMDIR lockit /S /Q
RMDIR models /S /Q
RMDIR movies /S /Q
RMDIR particles /S /Q
RMDIR profiles /S /Q
RMDIR scripts /S /Q
RMDIR shaderfx /S /Q
RMDIR sound /S /Q
RMDIR terrain /S /Q
RMDIR universe /S /Q
RMDIR weather /S /Q
del adapter.txt
del battlestationspacific.exe
del gamemode.lua
del giachievement_model_load_temp
del xlive.dll
echo =========================================================
echo    Restoring game backup - this may take a while...
echo =========================================================
echo Restoring BSP launch files
xcopy /s /c /q /y BSPRM\bsp.mpkg 
xcopy /s /c /q /y BSPRM\bsp.exe 
xcopy /s /c /q /y BSPRM\battlestationspacific.exe 


echo Restoring interface
RMDIR interface /S /Q
xcopy /s /c /q /y BSPRM\interface interface\
RMDIR BSPRM\interface /S /Q

echo Restoring movies
RMDIR movies /S /Q
xcopy /s /c /q /y BSPRM\movies movies\
RMDIR BSPRM\movies /S /Q

echo Restoring mpak
RMDIR mpak /S /Q
xcopy /s /c /q /y BSPRM\mpak mpak\
RMDIR BSPRM\mpak /S /Q

echo Restoring sound
RMDIR sound /S /Q
xcopy /s /c /q /y BSPRM\sound sound\
RMDIR BSPRM\sound /S /Q

RMDIR BSPRM /S /Q


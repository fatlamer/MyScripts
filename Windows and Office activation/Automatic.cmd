@ECHO OFF
color 1f
::The main purpose of this script is to be used where no standard OSD solution (like MDT, SCCM, Altiris or else) is available.
:: Place this script in "%ProgramData%\Microsoft\Windows\Start Menu\Programs\StartUp" before capturing Windows.
:: Referer to Manual.cmd in the same folder for more info.
::Ths script is created for MAK keys, but of course can be used with any other valid MS License Key.

::Uncomment next rows if you need to restart LAN adapter after deplyment or clone of Windows Image.
::ECHO Restarting LAN Connections to be sure that activation will succeed!
::netsh interface set interface "Local Area Connection" disabled
::netsh interface set interface "Local Area Connection" enabled
::netsh interface set interface "Local Area Connection 1" disabled
::netsh interface set interface "Local Area Connection 1" enabled
::netsh interface set interface "Local Area Connection 2" disabled
::netsh interface set interface "Local Area Connection 2" enabled
::netsh interface set interface "Local Area Connection 3" disabled
::netsh interface set interface "Local Area Connection 3" enabled
::netsh interface set interface "Local Area Connection 4" disabled
::netsh interface set interface "Local Area Connection 4" enabled
::netsh interface set interface "Local Area Connection 5" disabled
::netsh interface set interface "Local Area Connection 5" enabled
::netsh interface set interface "Local Area Connection 6" disabled
::netsh interface set interface "Local Area Connection 6" enabled
::netsh interface set interface "Local Area Connection 7" disabled
::netsh interface set interface "Local Area Connection 7" enabled
::netsh interface set interface "Local Area Connection 8" disabled
::netsh interface set interface "Local Area Connection 8" enabled
::ECHO ALL LOCAL AREA CONNECTIONS WERE RESTARTED!
::cls
ECHO #################################################
ECHO #####                 PLEASE                #####
ECHO #####                 DO NOT                #####
ECHO #####          INTERRUPT THE PROCESS        #####  
ECHO #####          OR CLOSE THIS WINDOW         #####
ECHO #################################################
ECHO #################################################
ECHO ##### AFTER ACTIVATION PROCESS THIS SCRIPT  #####
ECHO #####    WILL BE DELETED AUTOMATICALLY!     #####
ECHO #################################################
ECHO.
ECHO Waiting for Network Connectivity for 60 seconds!
ECHO Please, be patient and DO NOT close this window!
timeout /T 60 /NOBREAK
cls
ECHO Attempting to activate Windows... 
ECHO Importing Windows MAK Key...
cd %windir%\system32\
cscript.exe slmgr.vbs /ipk XXXXX-XXXXX-XXXXX-XXXXX-XXXXX
ECHO Attempting to activate Windows...
cscript.exe slmgr.vbs /ato
ECHO Cleaning the screen...
cls
ECHO Attempting to activate Microsoft Office 2010 Pro Plus
::Use your own MAK or Retail License Key for Office and put it below in /inpkey.
::If you want to activate Office 2013 change the path to Office15, like this--> %ProgramFiles(x86)%\Microsoft Office\Office15
::For Office 2016 it is %ProgramFiles(x86)%\Microsoft Office\Office16
::If you are using 64bit Office version, change %ProgramFiles(x86) with %ProgramFiles%
ECHO Importing Office 2010 Pro Plus MAK Key...
cd %windir%\system32
cscript.exe "%ProgramFiles(x86)%\Microsoft Office\Office14\ospp.vbs" /inpkey:XXXXX-XXXXX-XXXXX-XXXXX-XXXXX
ECHO Activating Microsoft Office 2010 Pro Plus...
cscript.exe "%ProgramFiles(x86)%\Microsoft Office\Office14\ospp.vbs" /act
ECHO Proceeding to the next phase...
cls
ECHO Changing the PC name!
wmic path win32_computersystem where "Name='%computername%'" CALL rename name='PC-%random%'
ECHO.
::Rows below were created to fix an issue with Ubuntu Dual Boot installation with Win7.
::I will leave it here for my reference only, since there are VMs already :)
::ECHO Setting  CHKDSK to check the disk, so Ubuntu can run after the process is complete!
::fsutil dirty set %systemdrive%
::chkntfs %systemdrive% /c
::cls
ECHO Restarting the PC for changes to take effect!
shutdown -t 60 -r -f -c "This PC will restart after 60 seconds! Your friendly neighborhood System Administrator wishes you a nice day!"
ECHO Cleaning and exiting...
GOTO:CLEAN

:CLEAN
cls
ECHO BYE-BYE Cruel World!
cd /d "%~dp0"
del "%~f0"
::END

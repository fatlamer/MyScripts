@ECHO OFF
color 0A
::The main purpose of this script is to be used where no standard OSD solution (like MDT, SCCM, Altiris or else) is available.
::Put this script in %Programdata%\Microsoft\Windows\Start Menu\Programs\Startup before capturing an Windows image. It does not matter OSD solution.
::Script is named "Manual" because you have the ability to manually choose what to do. 
::If you want automation, choose "Automatic.cmd"
:: For both scripts you will need to provide your own MAK or Retail License Keys. KMS keys can be used as well, in case you need such thing.
ECHO #####################################################################
ECHO ############   Windows and Office Activation Script #################
ECHO ########################### by FaTLaMeR #############################
ECHO ##########     Activate Windows 7/8/8.1/10          #################  
ECHO ########## and MS Office 2010/2013/2016 Pro Plus    #################
ECHO ##########   INSPIRED BY ILINCHO AND SUPERLAMER     #################
ECHO ##########            THANK YOU, GUYS!:)            #################
ECHO #####################################################################
ECHO.
ECHO ####################   What do You want to do?    ###################
ECHO.
ECHO #######################          ALL           ######################
ECHO.
ECHO 1. Activate Windows and Office (DEFAULT ACTION!) and RESTART!
ECHO.
ECHO #######################     WINDOWS ONLY     ########################
ECHO.
ECHO 2. Activate only Windows
ECHO.
ECHO #######################     OFFICE ONLY      ########################
ECHO.
ECHO 3. Activate only Office
ECHO.
ECHO #######################         EXIT         ########################
ECHO 4. Exit

ECHO.

CHOICE /C:1234 /D:1 /T 90 /M "You have 90 seconds to decide! After that the DEFAULT ACTION (1) will take place!"

IF ERRORLEVEL == 4 GOTO END                    
IF ERRORLEVEL == 3 GOTO OFFICE                    
IF ERRORLEVEL == 2 GOTO WINDOWS                     
IF ERRORLEVEL == 1 GOTO ALL                     


:END
ECHO Performing CLEANING actions!
del "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Manual.cmd" /F /Q
ECHO Will now EXIT! 
ECHO See ya soon!:)
exit
GOTO:EOF

:OFFICE
ECHO Please, wait!
ECHO Now activating Microsoft Office 2010 Pro Plus Edition!
::Use your own MAK or Retail License Key for Office and put it below in /inpkey.
::If you want to activate Office 2013 change the path to Office15, like this--> %ProgramFiles(x86)%\Microsoft Office\Office15
::For Office 2016 it is %ProgramFiles(x86)%\Microsoft Office\Office16
::If you are using 64bit Office version, change %ProgramFiles(x86) with %ProgramFiles%
cscript.exe "%ProgramFiles(x86)%\Microsoft Office\Office14\ospp.vbs" /inpkey:XXXXX-XXXXX-XXXXX-XXXXX-XXXXX
cscript.exe "%ProgramFiles(x86)%\Microsoft Office\Office14\ospp.vbs" /act
ECHO Performing CLEANING actions!
del "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Manual.cmd" /F /Q
ECHO THIS SCRIPT WILL NOW EXIT! 
ECHO THANK YOU FOR YOUR PATIENCE! BYE-BYE!:)
GOTO:EOF

:WINDOWS
ECHO Please, wait!
ECHO Now activating Microsoft Windows!
cscript.exe %Windir%\system32\slmgr.vbs /ipk XXXXX-XXXXX-XXXXX-XXXXX-XXXXX
cscript.exe %Windir%\system32\slmgr.vbs /ato
ECHO Performing CLEANING actions!
del "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Manual.cmd" /F /Q
ECHO THIS SCRIPT WILL NOW EXIT! 
ECHO THANK YOU FOR YOUR PATIENCE! BYE-BYE!:)
GOTO:EOF

:ALL
ECHO Please, wait!
ECHO Now activating Microsoft Windows
ECHO and Microsoft Office Pro Plus Edition!
cscript.exe %Windir%\system32\slmgr.vbs /ipk XXXXX-XXXXX-XXXXX-XXXXX-XXXXX
cscript.exe %Windir%\system32\slmgr.vbs /ato
cscript.exe "%ProgramFiles(x86)%\Microsoft Office\Office14\ospp.vbs" /inpkey:XXXXX-XXXXX-XXXXX-XXXXX-XXXXX
cscript.exe "%ProgramFiles(x86)%\Microsoft Office\Office14\ospp.vbs" /act
ECHO WILL NOW RESTART!
shutdown -t 60 -r -f -c "This PC will restart after 60 seconds! Your friendly neighborhood System Administrator wishes you a nice day!"
ECHO Performing CLEANING actions!
del "%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup\Manual.cmd" /F /Q
ECHO THIS SCRIPT WILL NOW EXIT! 
ECHO THANK YOU FOR YOUR PATIENCE! BYE-BYE!:)
GOTO:EOF

::DONE




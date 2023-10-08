::SCRIPT.........:  EventlogArchive.bat
::AUTHOR.........:  Deyan "fatlamer" Denev
::VERSION........:  1.1
::DATE...........:  23 June 2023
::CHANGELOG:
::Version 1.0 - initial version (not present in GitHub)
::version 1.1 - adding map/unmap drive functionality to authenticate properly against Azure File Share as it cannot be done via Scheduled Task runas user.
::Impoved date format for logging and changed logic for log file creation
::NOTE:Please replace #destination#, #user# and #password# as per your environment, user must have read/write access to destination.
::No need of source access as Scehudeld taks in SYSTEM context is used. If needed at least "Log reader" role is required.

@ECHO OFF

:: Set variables
set source="%SystemDrive%\Windows\system32\winevt\Logs\Archive*.*"
set destination="\\#destination#\EventViewerBackup\%ComputerName%"
set logs="\\#destination#\EventViewerBackup\%ComputerName%\Logs"
::Set date format in YYYY-MM-DD
FOR /F "TOKENS=1* DELIMS= " %%A IN ('DATE/T') DO SET CDATE=%%B
FOR /F "TOKENS=1,2 eol=/ DELIMS=/ " %%A IN ('DATE/T') DO SET mm=%%B
FOR /F "TOKENS=1,2 DELIMS=/ eol=/" %%A IN ('echo %CDATE%') DO SET dd=%%B
FOR /F "TOKENS=2,3 DELIMS=/ " %%A IN ('echo %CDATE%') DO SET yyyy=%%B
SET now=%yyyy%-%mm%-%dd%

:: Map netowrk drive
net use \\#destination# /user:domain\#user# #password# /persistent:no
:: Check if the folder exists and if not create it
if exist %destination% (
    goto checkforarchive
) else (
    md %destination%
)
:: Check if Logs folder exist
if exist %logs% (
    goto checkforarchive
) else (
    md %logs%
    break>%logs%\ArchiveLog-%now%.log
)
:: Check if there are any logs for archiving
:checkforarchive
if exist "%SystemDrive%\Windows\system32\winevt\Logs\Archive*.*" (
    goto movearchives
) else (
ECHO There are no logs to archive today, enjoy!>>"%logs%\ArchiveLog-%now%.log"
goto unmapdrive  
)
:: Move the files to desired destination
:movearchives
::Create the log file first
break>%logs%\ArchiveLog-%now%.log
::Move the logs to desired destination
move /Y %source% %destination%>>"%logs%\ArchiveLog-%now%.log"
::Unmap network drive
:unmapdrive
net use \\#destination# /delete
net use \\#destination#\IPC$ /delete
:end
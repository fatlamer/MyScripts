#This script will map $DriveLetter drive
$DriveLetter = "X"
$FileShareServer = "\\stauksema01.file.core.windows.net\energyadvisory"
$ShareDescription = "Azure_EnergyAdvisory"
Start-Process cmd -ArgumentList "/c net use X: /del /y" -NoNewWindow -ErrorAction SilentlyContinue -Wait
New-PSDrive -Persist -Name $DriveLetter -PSProvider FileSystem -Root $FileShareServer -Scope Global -Description $ShareDescription
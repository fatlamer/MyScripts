<#Simple script to remove apps related to MediaArena vulnerability.
Created by Deyan "fatlamer" Denev
Version: 1.0
Date: 22/09/2023#>

#Create log folder
New-Item -Path "$env:userprofile\Logs\Remove-MediaArenaApps" -ItemType Directory -ErrorAction SilentlyContinue
#Create log file
function MALog([string]$LogMessage) {
  Add-Content "$env:userprofile\Logs\Remove-MediaArenaApps\MARemoval.log" $LogMessage
}
#Set timestamp
$timestamp=Get-Date -Format "dddd dd/MM/yyyy HH:mm K" 

#Set paths for checking later
$ZipRarArchiveReg = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\ZipRarArchiver"
$ZipRarAchiveUser = "$env:onedrive\Desktop\ZipRarArchiver.lnk"
$ZipRarArchiverAppData = "$env:userprofile\AppData\Local\Temp\ZipRarArchiver"
$SearchArchiver = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\searcharchiver"

#Start removing
MALog "[$timestamp] Starting ZipRARArchiver removal"
#Remove from registry
if (Test-Path -Path $ZipRarArchiveReg)
{
    Remove-Item -Path $ZipRarArchiveReg -Force -Recurse -ErrorAction SilentlyContinue; MALog "[$timestamp] ZipRARArchiver has been removed from the registry!"
} else
{
    MALog "[$timestamp] ZipRARArchiver is not found in the registry"
}
#Remove from Desktop
if (Test-Path -Path $ZipRarAchiveUser)
{
    Remove-Item -Path $ZipRarAchiveUser -Force -ErrorAction SilentlyContinue; MALog "[$timestamp] ZipRARArchiver has been removed from Desktop!"
} else
{
    MALog "[$timestamp] ZipRARArchiver is not found on user's Desktop"
}
#Remove from Appdata temp folder
if (Test-Path -Path $ZipRarArchiverAppData)
{
    Remove-Item -Path $ZipRarArchiverAppData -Force -Recurse -ErrorAction SilentlyContinue; MALog "[$timestamp] ZipRARArchiver has been removed from Appdata Temp folder!"
} else
{
    MALog "[$timestamp] ZipRARArchiver is not found in appdata\temp folder"
}
MALog "[$timestamp] Starting SearchArchiver removal"
#Remove from registry
if (Test-Path -Path $SearchArchiver)
{
    Remove-Item -Path $SearchArchiver -Force -Recurse -ErrorAction SilentlyContinue; MALog "[$timestamp] SearchArchiver has been removed from the registry!"
} else
{
    MALog "[$timestamp] SearchArchiver is not found in the registry"
}
MALog "[$timestamp] Removal completed!"
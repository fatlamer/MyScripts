<#
Name:Install-Updates.ps1
Author: Deyan "fatlamer"Denev
Disclaimer: This script is for my reference only. Use it at your own risk!
Description:
This script is used to install all updates found in subfolders "Important" and "Optional", as seen in Windows Updates pane in Control Panel for Windows 7.
If you want to include more updates, just place them in their proper folder.
They must be with .msu extension, becuase wusa.exe is used to install them!
Directory structure must look like this:
-->RootFolder
	-->Important
	-->Optional
	-->InstallUpdates.ps1
It is supposed to be used inside an MDT or SCCM task sequence for easily updating Windows durining image creation process.
#>
$ImportandUpdates=Get-ChildItem ".\Important"
$OptionalUpdates=Get-ChildItem ".\Optional"
foreach ($ImportantUpdate in $ImportandUpdates)
{
wusa.exe $ImportantUpdate.FullName /quiet /norestart;while(Get-Process wusa){Write-Host "Installing $ImportantUpdate"}
}
foreach ($OptionalUpdate in $OptionalUpdates)
{
wusa.exe $OptionalUpdate.FullName /quiet /norestart;while(Get-Process wusa){Write-Host "Installing $OptionalUpdate"}
}
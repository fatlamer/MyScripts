<#Original author and location: https://github.com/robertomoir/remove-sccm
Some tweaks and improvements by Deyan "fatlamer" Denev
Version: 1.2
Date: 23/07/2023#>

#Create log folder
New-Item -Path "$env:WinDir\Logs\SCCMUninstall" -ItemType Directory -ErrorAction SilentlyContinue
#Create log file
function SCCMUninstallLog([string]$LogMessage) {
  Add-Content "$env:WinDir\Logs\SCCMUninstall\SCCMUninstallLog.log" $LogMessage
}
#Set timestamp
$timestamp=Get-Date -Format "dddd dd/MM/yyyy HH:mm K" 
# $ccmpath is path to SCCM Agent's own uninstall routine.
$CCMpath = "$env:WinDir\ccmsetup\ccmsetup.exe"
# And if it exists we will remove it, or else we will silently fail.
SCCMUninstallLog "[$timestamp] Starting SCCM Agent uninstallation"
if (Test-Path $CCMpath) {

    Start-Process -FilePath $CCMpath -Args "/uninstall" -Wait -NoNewWindow
    # wait for exit
    $CCMProcess = Get-Process ccmsetup -ErrorAction SilentlyContinue

        try{
            $CCMProcess.WaitForExit()
            }catch{

            }
}
#Copy CCMSetup logs
Copy-Item -path "$env:windir\ccmsetup\Logs" -Destination "$env:windir\Logs\SCCMUninstall" -Recurse -ErrorAction SilentlyContinue
SCCMUninstallLog "[$timestamp] SCCM Agent has been removed and all logs have been copied to this folder: C:\Windows\Logs\SCCMUninstall\Logs"
#Stop Services
Stop-Service -Name ccmsetup -Force -ErrorAction SilentlyContinue
Stop-Service -Name CcmExec -Force -ErrorAction SilentlyContinue
Stop-Service -Name smstsmgr -Force -ErrorAction SilentlyContinue
Stop-Service -Name CmRcService -Force -ErrorAction SilentlyContinue
# wait for services to exit
$CCMProcess = Get-Process ccmexec -ErrorAction SilentlyContinue
try{

    $CCMProcess.WaitForExit()

}catch{
}
SCCMUninstallLog "[$timestamp] CCM Services were force to stop"
# Remove WMI Namespaces
Get-WmiObject -Query "SELECT * FROM __Namespace WHERE Name='ccm'" -Namespace root | Remove-WmiObject
Get-WmiObject -Query "SELECT * FROM __Namespace WHERE Name='sms'" -Namespace root\cimv2 | Remove-WmiObject
SCCMUninstallLog "[$timestamp] WMI Namespaces were forcefully removed"

# Remove Services from Registry
# Set $CurrentPath to services registry keys
$CurrentPath = "HKLM:\SYSTEM\CurrentControlSet\Services"
Remove-Item -Path $CurrentPath\CCMSetup -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path $CurrentPath\CcmExec -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path $CurrentPath\smstsmgr -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path $CurrentPath\CmRcService -Force -Recurse -ErrorAction SilentlyContinue
SCCMUninstallLog "[$timestamp] Services were forcefully removed from registry"
# Remove SCCM Client from Registry
# Update $CurrentPath to HKLM/Software/Microsoft
$CurrentPath = "HKLM:\SOFTWARE\Microsoft"
Remove-Item -Path $CurrentPath\CCM -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path $CurrentPath\CCMSetup -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path $CurrentPath\SMS -Force -Recurse -ErrorAction SilentlyContinue
SCCMUninstallLog "[$timestamp] SCCM Client registry entries were forcefully removed"
# Reset MDM Authority
# CurrentPath should still be correct, we are removing this key: HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\DeviceManageabilityCSP
Remove-Item -Path $CurrentPath\DeviceManageabilityCSP -Force -Recurse -ErrorAction SilentlyContinue
SCCMUninstallLog "[$timestamp] MDM Authority was reset at registry"
# Remove Folders and Files
# Tidy up garbage in Windows and Start Menu folders
$CurrentPath = $env:WinDir
Remove-Item -Path $CurrentPath\CCM -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path $CurrentPath\ccmsetup -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path $CurrentPath\ccmcache -Force -Recurse -ErrorAction SilentlyContinue
Remove-Item -Path $CurrentPath\SMSCFG.ini -Force -ErrorAction SilentlyContinue
Remove-Item -Path $CurrentPath\SMS*.mif -Force -ErrorAction SilentlyContinue
Remove-Item -Path $CurrentPath\SMS*.mif -Force -ErrorAction SilentlyContinue
Remove-Item -Path "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Endpoint Manager" -Force -Recurse -ErrorAction SilentlyContinue
SCCMUninstallLog "[$timestamp] CCM folders were forcefully removed from Windows and Start Menu folders. The script has reached its end!"
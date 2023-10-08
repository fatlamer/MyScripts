<#Simple script to remove Intel Connectivity Performance Suite Software from end user divices.
The driver is causing slow MS Teams connectivity and it's overwriting split-tunnleing settings in Palo Alto Globap Protect VPN
Script is based on these two articles
https://support.lenovo.com/us/en/solutions/ht513263-how-to-completely-uninstall-intel-connectivity-performance-suite-driver-from-a-system
https://www.intel.com/content/www/us/en/support/articles/000093451/wireless/wireless-software.html

Logs from pnputil can be found in %windir%\inf\setupapi.dev.log (https://learn.microsoft.com/en-us/windows-hardware/drivers/devtest/pnputil-return-values)
Detection method to deploy as Intune Win32 app is: %windir%\system32\drivers\Intel\ICPS\IDBWM.exe exists.

Link explaining why pnputil is working only in Sysnative mode: https://call4cloud.nl/2021/05/the-windows-driver-games/ 

Script name: Remove-ICPSDriver.ps1
Script version: 1.4
Created by: Deyan "fatlamer" Denev 
Created on: 27/09/2023#>

#Create log folder
New-Item -Path "$env:WinDir\Logs\RemoveICPSDriver" -ItemType Directory -ErrorAction SilentlyContinue
#Create log file
function WriteLog([string]$LogMessage) 
{
  Add-Content "$env:WinDir\Logs\RemoveICPSDriver\RemoveICPSDriverLog.log" $LogMessage
}
#Set timestamp
$timestamp=Get-Date -Format "dddd dd/MM/yyyy HH:mm K" 
#Create a log file 
WriteLog "[$timestamp]Starting the script..."
#Getting ICPS drivers from the device and removing them:
$InstalledDrivers = Get-WindowsDriver -all -Online | Where-Object OriginalFileName -CLike "*icps*"
WriteLog "[$timestamp] Checking if ICPS drivers are present on this computer..."
if ($InstalledDrivers) 
{
    WriteLog "[$timestamp] ICPS drivers have been found and details are in C:\Windows\Logs\RemoveICPSDriver\ICPSDriversfound.txt"
    $InstalledDrivers | Out-File -FilePath $env:WinDir\Logs\RemoveICPSDriver\ICPSDriversfound.txt
    WriteLog "[$timestamp] Starting ICPS driver removal..."
    $DriverICPS = $InstalledDrivers.Driver
    foreach ($DriverOEM in $DriverICPS) 
    { 
    C:\Windows\Sysnative\pnputil.exe /delete-driver $DriverOEM /uninstall /force
    }
    WriteLog "[$timestamp]Copying pnputil log (setupapi.dev.log) to logs folder."
    Copy-Item -path "$ENV:SystemRoot\inf\setupapi.dev.log" -Destination "$ENV:SystemRoot\Logs\RemoveICPSDriver" -ErrorAction SilentlyContinue
    WriteLog "[$timestamp] Drivers should have been removed with PNPUtil, please check the logs in .\Windows\Logs\RemoveICPSDriver folder"
} else {
    WriteLog "[$timestamp]No ICPS drivers were found on the system, exiting..."
}
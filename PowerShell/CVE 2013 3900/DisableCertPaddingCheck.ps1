<#This script is developed to undo the changes made by EnableCertPaddingCheck.ps1
Its purpose is to set back EnableCertPaddingCheck registry value to NULL in case we need to revert back how
More info here: https://msrc.microsoft.com/update-guide/vulnerability/CVE-2013-3900 
Script name: DisableCertPaddingCheck.ps1
Script version: 1.4
Created by: Deyan Denev (deyan.denev@baringa.com)
Created on: 28/11/2023#>

<#IMPORTANT NOTE: When executing the scipt in Intune, use %SystemRoot%\sysnative\WindowsPowerShell\v1.0\powershell.exe -executionpolicy bypass -file DisableCertPaddingCheck.ps1 or it will fail to set the 64bit key#>

#Declare variables and set log file
#Set timestamps
$timestamp=Get-Date -Format "dddd dd/MM/yyyy HH:mm K" 
#Create log folder
New-Item -Path "$env:WinDir\Logs\Baringa\CVE-2013-3900-Fix" -ItemType Directory -ErrorAction SilentlyContinue
#Create log file
function WriteLog([string]$LogMessage) 
{
  Add-Content "$env:WinDir\Logs\Baringa\CVE-2013-3900-Fix\DisableCertPaddingCheck.log" $LogMessage
}
#Script main routine
#Create a log file 
WriteLog "[$timestamp]Starting the script..."
#Setting variables and checking registry paths
$RegistryPath32bit = 'HKLM:\Software\Wow6432Node\Microsoft\Cryptography\Wintrust\Config'
$RegistryPath64bit = 'HKLM:\Software\Microsoft\Cryptography\Wintrust\Config'
$RegistryName = 'EnableCertPaddingCheck'
#$RegistryValue = '1'
$EnableCertPaddingCheck = Get-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Cryptography\Wintrust\Config -ErrorAction SilentlyContinue
$EnableCertPaddingCheck64bit = Get-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Cryptography\Wintrust\Config -ErrorAction SilentlyContinue
#Check if recommended registry values are set, otherwise exit silently without making changes to the system
if ($EnableCertPaddingCheck.EnableCertPaddingCheck -eq 1 -or $EnableCertPaddingCheck64bit.EnableCertPaddingCheck -eq 1) {
    WriteLog "[$timestamp]EnableCertPaddingCheck exists on the system, deleting it now..."
    Remove-ItemProperty -Path $RegistryPath32bit -Name $RegistryName -Force -ErrorAction SilentlyContinue
    Remove-ItemProperty -Path $RegistryPath64bit -Name $RegistryName -Force -ErrorAction SilentlyContinue
    WriteLog "[$timestamp]EnableCertPaddingCheck has been deleted from the system, exiting the script now!"
    WriteLog "[$timestamp]More information can be found here: https://msrc.microsoft.com/update-guide/vulnerability/CVE-2013-3900"
 }
else {
    WriteLog "[$timestamp]EnableCertPaddingCheck does no exists on this system, exiting the script without making any changes to the system!"
    WriteLog "[$timestamp]More information can be found here: https://msrc.microsoft.com/update-guide/vulnerability/CVE-2013-3900"
 }
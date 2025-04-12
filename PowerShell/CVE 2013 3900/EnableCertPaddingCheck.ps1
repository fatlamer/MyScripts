<#This script is developed to mitigate issues found in an internal mock assisement in one of my previous companies, more specifically CVE-2013-3900.
This vulnerability does not have patch for it, just a registry value that needs to be set.
More info here: https://msrc.microsoft.com/update-guide/vulnerability/CVE-2013-3900 
Script name: EnableCertPaddingCheck.ps1
Script version: 1.5
Created by: Deyan "fatlamer" Denev
Created on: 28/11/2023#>

<#IMPORTANT NOTE: When executing the scipt in Intune, use %SystemRoot%\sysnative\WindowsPowerShell\v1.0\powershell.exe -executionpolicy bypass -file EnableCertPaddingCheck.ps1 or it will fail to set the 64bit key#>

#Declare variables and set log file
#Set timestamps
$timestamp=Get-Date -Format "dddd dd/MM/yyyy HH:mm K" 
#Create log folder
New-Item -Path "$env:WinDir\Logs\YourCompany\CVE-2013-3900-Fix" -ItemType Directory -ErrorAction SilentlyContinue
#Create log file
function WriteLog([string]$LogMessage) 
{
  Add-Content "$env:WinDir\Logs\YourCompany\CVE-2013-3900-Fix\EnableCertPaddingCheck.log" $LogMessage
}
#Script main routine
#Create a log file 
WriteLog "[$timestamp]Starting the script..."
#Setting variables and checking registry paths
$RegistryPath32bit = 'HKLM:\Software\Wow6432Node\Microsoft\Cryptography\Wintrust\Config'
$RegistryPath64bit = 'HKLM:\Software\Microsoft\Cryptography\Wintrust\Config'
$RegistryName = 'EnableCertPaddingCheck'
$RegistryValue = '1'
if(-NOT (Test-Path $RegistryPath32bit)) {
  New-Item -Path $RegistryPath32bit -Force | Out-Null
}
if(-NOT (Test-Path $RegistryPath64bit)) {
  New-Item -Path $RegistryPath64bit -Force | Out-Null
}
$EnableCertPaddingCheck32bit = Get-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\Software\Wow6432Node\Microsoft\Cryptography\Wintrust\Config
$EnableCertPaddingCheck64bit = Get-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Cryptography\Wintrust\Config
#Check if recommended registry values are set, otherwise exit silently without making changes to the system
if ($EnableCertPaddingCheck32bit.EnableCertPaddingCheck -ne 1) 
{
    WriteLog "[$timestamp]EnableCertPaddingCheck does not exist in 32bit registry hive on the system, setting its value to 1 now..."
    New-ItemProperty -Path $RegistryPath32bit -Name $RegistryName -Value $RegistryValue -PropertyType string -Force -ErrorAction SilentlyContinue
    WriteLog "[$timestamp]EnableCertPaddingCheck has been set to 1 in 32bit registry hive, moving to next step now..."
 }
else 
{
    WriteLog "[$timestamp]EnableCertPaddingCheck already exist with recommended value 1 in 32bit registry hive, checking 64bit hive now..."
}
 if ($EnableCertPaddingCheck64bit.EnableCertPaddingCheck -ne 1) 
{
  WriteLog "[$timestamp]EnableCertPaddingCheck does not exist in 64bit registry hive on the system, setting its value to 1 now..."
  New-ItemProperty -Path $RegistryPath64bit -Name $RegistryName -Value $RegistryValue -PropertyType string -Force -ErrorAction SilentlyContinue
  WriteLog "[$timestamp]EnableCertPaddingCheck has been set to 1 in 64bit registry hive as well, exiting the script now."
  WriteLog "[$timestamp]More information can be found here: https://msrc.microsoft.com/update-guide/vulnerability/CVE-2013-3900"
}
else 
{
  WriteLog "[$timestamp]EnableCertPaddingCheck already exist with recommended value 1 in 64bit hive as well, exiting the script now!"
  WriteLog "[$timestamp]More information can be found here: https://msrc.microsoft.com/update-guide/vulnerability/CVE-2013-3900"
}
<#This script is developed to mitigate issues found in an internal mock assisement in one of my previous companies.
The script is designed to remove the local administrator profile and the local administrator.yourcompany profile from the system.
When executing from Intune, use %SystemRoot%\SysNative\WindowsPowershell\v1.0\PowerShell.exe -NoProfile -ExecutionPolicy ByPass -File Remove-LocalAdminProfile.ps1 to avoid issues with 32-bit and 64-bit context.
Script name: Remove-LocalAdminProfile.ps1
Script version: 1.2.1
Created by: Deyan "fatlamer" Denev
Created on: 07/12/2023#>

#Declare variables and set log file
#Set Script Version for better logging
$ScriptVersion = "1.2.1"
#Set timestamps
$timestamp=Get-Date -Format "dddd dd/MM/yyyy HH:mm K" 
#Create log folder
New-Item -Path "$env:WinDir\Logs\yourcompany\LocalAdminRemoval" -ItemType Directory -ErrorAction SilentlyContinue
#Create log file
function WriteLog([string]$LogMessage) 
{
  Add-Content "$env:WinDir\Logs\yourcompany
\LocalAdminRemoval\Remove-LocalAdminProfile.log" $LogMessage
}
#Script main routine
#Create a log file 
WriteLog "[$timestamp]Starting the script version "@$ScriptVersion""
#Check if local admin profile exist and remove it, otherwise exit silently without making changes to the system
 $LocalAdminExist = Test-Path -Path $Env:SystemDrive\Users\Administrator
 if ($LocalAdminExist) {
    WriteLog "[$timestamp]Local Administrator directory has been found, executing main command to remove it from C:\Users and registry and continue with Administrator.yourcompany
    profile..."
    Get-CimInstance -Class Win32_UserProfile | Where-Object { $_.LocalPath.split('\')[-1] -eq 'administrator' } | Remove-CimInstance -ErrorAction SilentlyContinue
    Remove-Item -Path $Env:SystemDrive\Users\Administrator -Force -Recurse -ErrorAction SilentlyContinue #Remove any possible remnants
    #Remove-LocalUser -Name "Administrator" #this can be used as well, but doesn't work in SysWOW64 context
 }
 else {
    WriteLog "[$timestamp]Local Administrator directory has not been found, continue and checking for Administrator.yourcompany
    directory..."
 }
#Check if local admin.yourcompany profile exist and remove it, otherwise exit silently without making changes to the system
$LocalAdminyourcompanyExist = Test-Path -Path $Env:SystemDrive\Users\Administrator.yourcompany
if ($LocalAdminyourcompanyExist) {
   WriteLog "[$timestamp]Local Administrator.yourcompany
 directory has been found, executing main command to remove it from C:\Users and registry..."
   Get-CimInstance -Class Win32_UserProfile | Where-Object { $_.LocalPath.split('\')[-1] -eq 'administrator.yourcompany
' } | Remove-CimInstance -ErrorAction SilentlyContinue
   Remove-Item -Path $Env:SystemDrive\Users\Administrator.yourcompany
 -Force -Recurse -ErrorAction SilentlyContinue #Remove any possible remnants
   #Remove-LocalUser -Name "Administrator.yourcompany
" #this can be used as well, but doesn't work in SysWOW64 context
}
else {

 directory has not been found, exiting the script without making any changes to the system!"
}
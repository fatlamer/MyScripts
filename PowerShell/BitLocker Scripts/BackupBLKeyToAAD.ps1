<#Script to backup BitLocker Recovery Key to Azure AD
This should be used only as a workaround in case the BitLocker key is not automatically backed up to Azure AD.
This script will only work on Windows 10/11 Pro, Enterprise and Education editions.
Script version: 1.1
Created by: Deyan Denev
Created on: 05/12/2023
#>
$BLV = Get-BitLockerVolume -MountPoint $env:SystemDrive
$KeyProtectorType = ($BLV.KeyProtector).KeyProtectorType
foreach($KeyProtector in $BLV.KeyProtector)
{
    if($KeyProtectorType -eq "RecoveryPassword")
    {
    $KeyProtectorID=$keyProtector.KeyProtectorID
    Write-Output $KeyProtectorID
    BackupToAAD-BitLockerKeyProtector -MountPoint "$env:SystemDrive" -KeyProtectorId "$KeyProtectorID" -ErrorAction SilentlyContinue
    break;
    }
}
#Create registry value to detect if this has been executed and the key stored. This is a temporary solution and not very reliable
$RegistryPath = 'HKLM:\Software\YourCompany\BitLockerKeytoAAD'
$RegistryKey = 'BLRKStatus'
$RegistryValue = '1'
New-Item -Path $RegistryPath -Force -ErrorAction SilentlyContinue
New-ItemProperty -Path $RegistryPath -Name $RegistryKey -Value $RegistryValue -Force -ErrorAction SilentlyContinue
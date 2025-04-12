<#Simple script to detect if TPM with Pin is enabled on the target system#>
$BitLockerStatus = Get-BitLockerVolume
#$BitLockerProtectors = $BitLockerStatus.KeyProtector
#$KeyProtectorTPM = $BitLockerStatus.KeyProtector | Where-Object KeyProtectorType -EQ "TPM"
$KeyProtectorTPMandPin = $BitLockerStatus.KeyProtector | Where-Object KeyProtectorType -EQ "TPMPin"
if ($KeyProtectorTPMandPin){
Write-Output "TPM with PIN is enabled, no need to re-enabled it, considering this app installed!"}
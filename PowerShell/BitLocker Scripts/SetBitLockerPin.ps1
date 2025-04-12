<#Simple script to set BitLocker PIN the same to all devices!
Yes, I know it is stupid, but a Cyber director forced me to :)#>
$PIN = ConvertTo-SecureString "123456" -AsPlainText -Force
Add-BitLockerKeyProtector -MountPoint $env:SystemDrive -TPMandPinProtector -Pin $PIN
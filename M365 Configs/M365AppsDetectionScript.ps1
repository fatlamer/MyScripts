$UninstallRegKey = Get-ChildItem -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
$M365Apps = "Microsoft 365 Apps"
$M365AppsCheck = $UninstallRegKey | Get-ItemProperty | Where-Object { $_.DisplayName -match $M365Apps }
if ($M365AppsCheck) {
    Write-Output "Microsoft 365 Apps Detected"
	Exit 0
   }else{
    Write-Output "Microsoft 365 Apps haven't been detected"
    Exit 1
}  
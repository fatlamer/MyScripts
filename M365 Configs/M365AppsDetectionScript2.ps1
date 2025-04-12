$C2RRegKey = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Office\ClickToRun\Configuration"
$M365AppsCheck = $C2RRegKey | Get-ItemProperty | Where-Object { $_.ProductReleaseIds -clike "*O365ProPlusRetail*" }
if ($M365AppsCheck) {
    Write-Output "Microsoft 365 Apps Detected"
	Exit 0
   }else{
    Write-Output "Microsoft 365 Apps haven't been detected"
    Exit 1
    }
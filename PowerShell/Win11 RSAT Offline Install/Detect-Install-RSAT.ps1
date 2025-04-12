<#Detect RSAT before installing it. We are false detecting it because the following tools are being removed only manually and after a reboot.
RSAT Tools removed only after a reboot:
Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0
Rsat.GroupPolicy.Management.Tools~~~~0.0.1.0
Rsat.ServerManager.Tools~~~~0.0.1.0
#>

$GetDNS = Get-WindowsCapability -Online -Name Rsat.Dns.Tools~~~~0.0.1.0
$GetDNSState = $GetDNS.State
if ($GetDNSState -eq "Installed"){
    Write-Output = "RSAT are installed, no further action is required!"
    Exit 0
}else{
    Write-Output "RSAT are not installed, begin installation now...."
    Exit 1
}
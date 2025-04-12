<#Detect RSAT before uninstalling it. We are false detecting it because the following tools are removed only after reboot
and we don't want to force reboot.
RSAT Tools removed only after a reboot:
Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0
Rsat.GroupPolicy.Management.Tools~~~~0.0.1.0
Rsat.ServerManager.Tools~~~~0.0.1.0
#>

$GetDNS = Get-WindowsCapability -Online -Name Rsat.Dns.Tools~~~~0.0.1.0
$GetDNSState = $GetDNS.State
if ($GetDNSState -eq "NotPresent"){
    Write-Output = "RSAT are not installed"
    Exit 0
}else{
    Write-Output "RSAT are installed"
    Exit 1
}
#Ensure script won't generate error to give false positive error in Company Portal
$ErrorActionPreference = “SilentlyContinue”
#Get all installed RSAT Tools
$GetRSAT = Get-WindowsCapability -Name RSAT* -Online
#Get all RSAT Tools' names
$RSATNames = $GetRSAT.Name
#Remove all found RSAT Tools
foreach ($name in $RSATNames){
    Remove-WindowsCapability -Name $name -Online
}
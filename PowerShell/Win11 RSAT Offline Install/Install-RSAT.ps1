#Unzip Features on Demand content so RSAT tools can be installed from local source
Expand-Archive -Path .\RSATSource.zip -DestinationPath .\ -Force -ErrorAction Stop
#Remove zip archive to save some disk space
Remove-Item -Path .\RSATSource.zip -Force -ErrorAction SilentlyContinue
#Get all installed RSAT Tools
$GetRSAT = Get-WindowsCapability -Name RSAT* -Online
#Get all RSAT Tools' names
$RSATNames = $GetRSAT.Name
#Add all RSAT Tools
foreach ($name in $RSATNames){
    Add-WindowsCapability -Name $name -Online -Source .\RSATSource -LimitAccess
}
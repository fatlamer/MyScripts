<#Simple script to convert computer names to Azure Device ID for easier group's bulk Import
Original idea is from https://techlabs.blog/categories/azure/get-azure-ad-device-object-id-from-computer-display-name-using-powershell #>

#Connect to Azure AD (first enable your JIT role, either Intune or Security Administrator)
#Enter your admin-xxxx365 account and credentils
Connect-AzureAD
#Place your file with computer names in your Download folder. First row of the file must be named "Name"
$devices = Import-CSV -Path $Env:USERPROFILE\Downloads\MSTeamsFixPC.csv
$obejctids = foreach ($device in $devices){
Get-AzureADDevice -SearchString "$($device.name)" |  Select-Object Displayname, ObjectId
}
$obejctids | Export-Csv -Path $Env:USERPROFILE\Downloads\DeviceIDs.csv -Force
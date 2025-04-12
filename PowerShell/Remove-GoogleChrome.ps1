<# Simple script to remove Chrome or any other software installed utilizing WMI query#>
$Chrome = Get-WmiObject -Class Win32_Product | Where-Object {$_.Name -clike "*Google Chrome*"} 
foreach ($Version in $Chrome)
{ 
     $Version.Uninstall() 
} 
Write-Output "Google Chrome successfully uninstalled"
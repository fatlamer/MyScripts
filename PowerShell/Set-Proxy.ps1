<#
Name:Set-Proxy.ps1
Author: Deyan "fatlamer" Denev
Synopsis: Script to enable or disable Proxy Server settings in Windows 7 and above.
There is a issue with Remove-ItemProperty cmdlet in PS 2.0 (Windows 7) where it cannot remove ProxyEnable registry entry.
Script was tested only on Windows 7, but it should work on the rest higher versions.
Purpose was to enable proxy, so MDT can updated Windows druing image creation and disable it at the end.
It can be devided into two portions in case "if staement" fails because of Remove-ItemProperty bug.
Disclaimer: This script is for my reference only. Use it at your own risk!
#>
#Setting variables
$MyProxyPath="your.proxy.URL.goes.here"
$MyProxyPort="your.proxy.port.goes.here"
$ProxyRegPath="HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings"
$SetMyProxy=$MyProxyPath+":"+$MyProxyPort
#Modifying proxy settings
if([string]::IsNullOrEmpty((Get-ItemProperty -Path $ProxyRegPath -Name ProxyEnable).ProxyEnable))
{
Write-Host "Proxy is not enable"
New-ItemProperty -Path $ProxyRegPath -Name ProxyEnable -Force -PropertyType "Dword"
New-ItemProperty -Path $ProxyRegPath -Name ProxyServer -Force
New-ItemProperty -Path $ProxyRegPath -Name ProxyOverride -Force
Set-ItemProperty -Path $ProxyRegPath -Name ProxyEnable -Value 1 -Force
Set-ItemProperty -Path $ProxyRegPath -Name ProxyServer -Value $SetMyProxy -Force
Set-ItemProperty -Path $ProxyRegPath -Name ProxyOverride -Value "<local>" -Force
Write-Host "Proxy is now set...enjoy!"
}else{
Write-Host "Proxy is enabled...reverting to default settings"
Remove-ItemProperty -Path $ProxyRegPath -Name ProxyEnable -Force
Remove-ItemProperty -Path $ProxyRegPath -Name ProxyServer -Force
Remove-ItemProperty -Path $ProxyRegPath -Name ProxyOverride -Force
Write-Host "Proxy is now removed and returned to default settings"
}
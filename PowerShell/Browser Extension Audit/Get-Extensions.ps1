<#This is a simple script utilizing PowerShell's Gallery "BrowserExtensionReporting" module.
The module itself can be found here https://www.powershellgallery.com/packages/BrowserExtensionReporting/1.0.0
It needs internet connectivity and NuGet Package Manager in order to be installed successfully
Created by: Deyan Denev
Version: 1.0
Date: 22/01/2025
#>
#Install NuGet
Install-PackageProvider -name NuGet -Force -Scope CurrentUser -ErrorAction Stop
#Install BrowserExtensionReporting module
Install-Module -name BrowserExtensionReporting -Force -Scope CurrentUser -ErrorAction Stop
#Prepare to store output on central location, check if the drive is mapped. You can change the drive letter and file share server to your needs
#or use Azure File Share or any other share without mapping
if(!(Test-Path -Path X:)){
    #P is not mapped, mapping...
    $DriveLetter = "X"
    $FileShareServer = "\\yourseerver\yourshare"
    $ShareDescription = "Public"
    New-PSDrive -Persist -Name $DriveLetter -PSProvider FileSystem -Root $FileShareServer -Scope Global -Description $ShareDescription
    #Store the output to X drive
    Get-BrowserExtensionInfo | Export-Csv -Path X:\BrowserExtensions-Audit.csv -Append -ErrorAction Stop
} else {
    #X drive is mapped, so we just store the output
    Get-BrowserExtensionInfo | Export-Csv -Path X:\BrowserExtensions-Audit.csv -Append -ErrorAction Stop
}
#Get all extension and store output locally, STOP error action is required to break the script as we will use this file as detection method in Intune
Get-BrowserExtensionInfo | Export-Csv -Path $ENV:TEMP\Extensions-Audit-local.csv -Force -ErrorAction Stop
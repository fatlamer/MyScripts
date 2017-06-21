
<#
Name:Get-Checksum.ps1
Author: Deyan "fatlamer"Denev
Disclaimer: This script is for my reference only. Use it at your own risk!
Description:
This script is used to create .txt file containig File Hash checksum of a file using Windows Forms.
#>
#Loading windows forms
[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
# Setting variables:
$FileDialog=New-Object System.Windows.Forms.OpenFileDialog
#Note to myself: Fix loosing focus issue
$FileDialog.Title="Choose File or files for which you want to create a checksum!"
$FileDialog.Multiselect="TRUE"
$FileDialog.InitialDirectory=$Env:SystemDrive
$FileDialog.Filter="All files (*.*)|*.*"
$FileDialog.ShowDialog() | Out-Null
$Filelocation=$FileDialog.FileNames
$FileSave=New-Object System.Windows.Forms.SaveFileDialog
$FileSave.Title="Choose where do you want to save the file containing SHA256 checksum:"
$FileSave.InitialDirectory=$Env:SystemDrive
$FileSave.FileName="SHA256Checksum.txt"
$FileSave.Filter="Simple Text File Format (*.txt)|*.txt"
$FileSave.ShowDialog() | Out-Null
$CheckSumFile=$FileSave.FileName
#Creating file hash checksum with SHA256 Algorithm (default by Get-FileHash cmdlet).
#If you want different algorithm, change the value - more info here-->https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.utility/get-filehash
Get-FileHash -Path $Filelocation -Algorithm SHA256 | Format-List | Out-File $CheckSumFile
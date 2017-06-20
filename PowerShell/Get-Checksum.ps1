
<#
.SYNOPSIS
    Script to create FileHash Checksum via GUI from Windows Forms.
    Author: Deyan "fatlamer" Denev
#>
#Loading windows forms
[System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
# Setting variables:
$FileDialog=New-Object System.Windows.Forms.OpenFileDialog
#Note to myself: Fix loosing focus issue
$FileDialog.Title="Choose File or files for which you want to create a checksum. If you want to select muliple files, hold down Ctrl button on the keyboard!"
$FileDialog.Multiselect="TRUE"
$FileDialog.ShowDialog()
$Filelocation=$FileDialog.FileNames
$FileSave=New-Object System.Windows.Forms.SaveFileDialog
$FileSave.Title="Choose where do you want to save the file containing SHA256 checksum:"
$FileSave.FileName="SHA256Checksum.txt"
$FileSave.Filter="Simple Text File Format (*.txt)|*.txt"
$FileSave.ShowDialog()
$CheckSumFile=$FileSave.FileName
#Creating file hash checksum with SHA256 Algorithm (default by Get-FileHash cmdlet)
Get-FileHash -Path $Filelocation -Algorithm SHA256 | Format-List | Out-File $CheckSumFile
#Showing the full path to newly created file with the file hash checksum
Write-Host "You can find the file containing the checksum here: $CheckSumFile" -ForegroundColor Green
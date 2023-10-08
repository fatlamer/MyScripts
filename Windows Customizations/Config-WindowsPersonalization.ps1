<#Script name: Config-WindowsPersonalization.ps1
Script version: 1.0
Created by: Deyan "fatlamer" Denev
Created on: 29/09/2023
NOTE: Place your pictures in UserAccount and Wallpapers folders, have in mind that you need to have different dimenstions parepared
as explained here https://winaero.com/default-user-account-picture-windows-10/ 
You can deploy this via Intune/SCCM and the detection method can be "if #programdata#\Microsoft\User Account Pictures\User-backup.png exist"#>

#Declare variables and set log file
#Set timestamps
$timestamp=Get-Date -Format "dddd dd/MM/yyyy HH:mm K" 
#Create log folder
New-Item -Path "$env:WinDir\Logs\WinPersonalization" -ItemType Directory -ErrorAction SilentlyContinue
#Create log file
function WriteLog([string]$LogMessage) 
{
  Add-Content "$env:WinDir\Logs\WinPersonalization\WinPersonalization.log" $LogMessage
}
#Script main routine
#Create a log file 
WriteLog "[$timestamp]Starting the script..."
#Backup default User Account pictures
WriteLog "[$timestamp]Backing up default User Account Pictures in case they need to be reverted. All pictures will have "-backup" added to their names."
Rename-Item -Path "$ENV:ProgramData\Microsoft\User Account Pictures\User.bmp" -NewName User-backup.bmp -Force -ErrorAction SilentlyContinue
Rename-Item -Path "$ENV:ProgramData\Microsoft\User Account Pictures\User.jpg" -NewName User-backup.jpg -Force -ErrorAction SilentlyContinue
Rename-Item -Path "$ENV:ProgramData\Microsoft\User Account Pictures\User.png" -NewName User-backup.png -Force -ErrorAction SilentlyContinue
Rename-Item -Path "$ENV:ProgramData\Microsoft\User Account Pictures\User-32.png" -NewName User-32-backup.png -Force -ErrorAction SilentlyContinue
Rename-Item -Path "$ENV:ProgramData\Microsoft\User Account Pictures\User-40.png" -NewName User-40-backup.png -Force -ErrorAction SilentlyContinue
Rename-Item -Path "$ENV:ProgramData\Microsoft\User Account Pictures\User-48.png" -NewName User-48-backup.png -Force -ErrorAction SilentlyContinue
Rename-Item -Path "$ENV:ProgramData\Microsoft\User Account Pictures\User-192.png" -NewName User-192-backup.png -Force -ErrorAction SilentlyContinue
WriteLog "[$timestamp]All default user pictures have been renamed. Default guest picture has not, add it if you want"
WriteLog "[$timestamp]Start copying branded User Account pictures to default user account folder C:\ProgramData\Microsoft\User Account Pictures"
Copy-Item -Path ".\UserAccount\*" -Destination "$ENV:ProgramData\Microsoft\User Account Pictures" -Recurse -Force -ErrorAction SilentlyContinue
WriteLog "[$timestamp]Branded pictures have been copied to required destination"
WriteLog "[$timestamp]Start copying branded wallpapers for Welcome Screen and Desktop"
#Create folder in default Windows wallpaper folder C:\Windows\Web
New-Item -Path "$env:WinDir\Web\Wallpaper\Branded" -ItemType Directory -ErrorAction SilentlyContinue
New-Item -Path "$env:WinDir\Web\Screen\Branded" -ItemType Directory -ErrorAction SilentlyContinue
#Copy branded wallapepers where required as per Intune Configuration Profile
Copy-Item -Path ".\Wallpapers\BaringaBackground.jpg" -Destination "$env:WinDir\Web\Screen\Branded" -Force -ErrorAction SilentlyContinue
Copy-Item -Path ".\Wallpapers\BaringaDesktop.jpg" -Destination "$env:WinDir\Web\Wallpaper\Branded" -Force -ErrorAction SilentlyContinue
WriteLog "[$timestamp]Branded wallpapers have been copied to local machine."
WriteLog "[$timestamp]You can find then in C:\Windows\Web\Wallpaper\Branded and C:\Windows\Web\Screen\Branded"
WriteLog "[$timestamp]Windows Customization script is now finished, exiting..."
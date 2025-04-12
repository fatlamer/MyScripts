<#This script work only on Windows 64bit mode, its purpose is to automate Python installations via Nerdio Manager for Enterprise (Nerdio Manager for MSP) and to remove the 260 character limit on Windows (LongPathsEnabled).
If you need other versions to be installed, please change all paths accordinglt, i.e. Python311 is for v.3.11.
Check Python's FTP server for all versions at https://www.python.org/ftp/python/ 
Create by Denyan Denev (deyan.denev@baringa.com)
Created on 26/04/2024
Version: 1.0#>

#Set variables
$PythonSystemPath = Test-Path -Path $env:ProgramFiles\Python312
$PythonUserPath = Test-Path -Path $env:LOCALAPPDATA\Programs\Python\Python312
$DownloadURI = "https://www.python.org/ftp/python/3.12.3/python-3.12.3-amd64.exe"
$DownloadPath = "$env:windir\Temp\python-3.12.3-amd64.exe"
#Check if Python is installed in user or system context
if ($PythonSystemPath -or $PythonUserPath){
    Write-Host "Python 3.12 is already installed on this device, exiting the script now!"
    Exit 0
}else{
    #Download Python 3.12.3 (latest version available during script creation)
    Invoke-WebRequest -Uri $DownloadURI -OutFile $DownloadPath
    Start-Process -FilePath $DownloadPath -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1 CompileAll=1 InstallLauncherAllUsers=1" -Wait -WindowStyle Hidden -ErrorAction SilentlyContinue
    Remove-Item -Path $DownloadPath -Force -ErrorAction SilentlyContinue
    #Remove 260 character limit on Windows (LongPathsEnabled)
    New-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem -Name "LongPathsEnabled" -Value "1" -PropertyType Dword -Force -ErrorAction SilentlyContinue
    Write-Host "Python 3.12 has been installed on the device, script is now completed!"
    Exit 0
}
#Uninstall silently if needed:
#$DownloadURI = "https://www.python.org/ftp/python/3.12.3/python-3.12.3-amd64.exe"
#$DownloadPath = "$env:windir\Temp\python-3.12.3-amd64.exe"
#Invoke-WebRequest -Uri $DownloadURI -OutFile $DownloadPath
#Start-Process -FilePath $DownloadPath -ArgumentList "/quiet /uninstall" -Wait -WindowStyle Hidden -ErrorAction SilentlyContinue
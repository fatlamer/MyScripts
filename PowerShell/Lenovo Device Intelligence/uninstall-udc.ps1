<#IMPORTANT NOTE: When executing the scipt in Intune, use %SystemRoot%\sysnative\WindowsPowerShell\v1.0\powershell.exe -executionpolicy bypass -file uninstall-udc.ps1 to ensure pnputil will uninstall all drivers properly in 64bit context.
Otherwise the uninstall will fail!#>
<#This logic has been taked from Lenovo's original readme file located in C:\Windows\System32\drivers\Lenovo\udc\Data
Here is the excerpt:
UNINSTALL
[Uninstall through Windows Device Manager]
  1. Start Device Manager by using running devmgmt.msc or key combination  (Windows Key + X + M)
  2. Navigate to System Devices → "Universal Device Client Device"
  3. Right click on "Universal Device Client Device" → "Uninstall Device"
  4. When prompted, check the checkbox for "Delete the driver software for this device"
  5. The device should be restarted to complete uninstall
[Uninstall through command line]
  Run the following command as Administrator
    PUSHD %windir%\System32\drivers\Lenovo\udc\Data\InfBackup\
    .\UDCInfInstaller.exe -uninstall
    POPD
#>
Push-Location $env:windir\System32\drivers\Lenovo\udc\Data\InfBackup\
Start-Process -FilePath .\UDCInfInstaller.exe -ArgumentList "-uninstall" -ErrorAction Stop -Wait -NoNewWindow
Pop-Location
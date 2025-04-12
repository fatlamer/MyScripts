<#IMPORTANT NOTE: When executing the scipt in Intune, use %SystemRoot%\sysnative\WindowsPowerShell\v1.0\powershell.exe -executionpolicy bypass -file install-udc.ps1 to ensure pnputil will install all drivers properly.#>
#Installing Lenovo Universal Device Client
Start-Process -FilePath .\udc_setup.exe -ArgumentList " /VERYSILENT /NORESTART" -Wait -ErrorAction Stop -NoNewWindow
#Waiting 120 seconds to ensure that the client has connected to the cloud environment and populated all registry keys required for the detection method in Intune
Start-Sleep 120
$currentdate = (Get-Date) - (New-TimeSpan -Days 180)
Get-ADcomputer -Filter 'lastLogondate -lt $currentdate' | Format-Table

# Select the lastlogondate and name for a more readable list
Get-ADcomputer -Filter 'lastLogondate -lt $currentdate' -properties canonicalName,lastlogondate | Select-Object name,lastlogondate | export-csv $env:USERPROFILE\Desktop\InactiveADComputers180days.csv -NoTypeInformation
if(Test-Path -Path $ENV:TEMP\Extensions-Audit-local.csv){
    Write-Output "Extension audit has been done on this device, no further actions are required!"
}else{
    Write-Output "Extension audit is not executed on this device, executing now..."
    Exit 1
}
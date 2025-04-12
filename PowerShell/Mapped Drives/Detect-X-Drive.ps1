#Detect if X drive is mapped. If not, pass the action to remediation script to map it. Set in Intune to run every 1 hours indefinately
$X_Drive = Get-PSDrive "X" -ErrorAction SilentlyContinue
if($null -ne $X_Drive -and $X_Drive.DisplayRoot -eq "\\yourserver\yourshare"){
    Write-Host "X drive exists"
    Exit 0
}else{
    Write-Host "X Drive is not present, remediation script will start now"
    Exit 1
}
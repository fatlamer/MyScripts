$PLEXOSPATH = Resolve-Path -Path 'C:\Program Files\Energy Exemplar\PLEXOS*'
foreach ($ppath in $PLEXOSPATH){
    if (Test-Path -Path "$ppath\gurobi91.lcr"){Copy-Item -Path .\gurobi91.lcr -Destination $ppath -Force}
    if (Test-Path -Path "$ppath\gurobi95.lcr"){Copy-Item -Path .\gurobi95.lcr -Destination $ppath -Force}
    if (Test-Path -Path "$ppath\gurobi100.lcr"){Copy-Item -Path .\gurobi100.lcr -Destination $ppath -Force}
    if (Test-Path -Path "$ppath\gurobi110.lcr"){Copy-Item -Path .\gurobi110.lcr -Destination $ppath -Force}
    if (Test-Path -Path "$ppath\gurobi120.lcr"){Copy-Item -Path .\gurobi120.lcr -Destination $ppath -Force}
}
#Create detection method tag in the registry
$RegistryPath = 'HKLM:\Software\YourCompany\GurobiLicenseFix'
$RegistryKey = 'GurobiFix'
$RegistryValue = '1'
New-Item -Path $RegistryPath -Force -ErrorAction SilentlyContinue
New-ItemProperty -Path $RegistryPath -Name $RegistryKey -Value $RegistryValue -Force -ErrorAction SilentlyContinue
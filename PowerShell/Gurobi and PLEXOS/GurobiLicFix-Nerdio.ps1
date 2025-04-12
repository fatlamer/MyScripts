#Set download path and URLs:
New-Item -Path "C:\Temp\GurobiFix" -ItemType Directory -Force -ErrorAction SilentlyContinue
$DownloadPath91 = "C:\Temp\GurobiFix\gurobi91.lcr"
$DownloadPath95 = "C:\Temp\GurobiFix\gurobi95.lcr"
$DownloadPath100 = "C:\Temp\GurobiFix\gurobi100.lcr"
$DownloadPath110 = "C:\Temp\GurobiFix\gurobi110.lcr"
$DownloadPath120 = "C:\Temp\GurobiFix\gurobi120.lcr"
$DownloadGurobi91URL = "https://plexos.energyexemplar.com/files/Gurobi/gurobi91.lcr"
$DownloadGurobi95URL = "https://plexos.energyexemplar.com/files/Gurobi/gurobi95.lcr"
$DownloadGurobi100URL = "https://plexos.energyexemplar.com/files/Gurobi/gurobi100.lcr"
$DownloadGurobi110URL = "https://plexos.energyexemplar.com/files/Gurobi/gurobi110.lcr"
$DownloadGurobi120URL = "https://plexos.energyexemplar.com/files/Gurobi/gurobi120.lcr"
#Download updated license files from EE
Invoke-WebRequest -Uri $DownloadGurobi91URL -OutFile $DownloadPath91
Invoke-WebRequest -Uri $DownloadGurobi95URL -OutFile $DownloadPath95
Invoke-WebRequest -Uri $DownloadGurobi100URL -OutFile $DownloadPath100
Invoke-WebRequest -Uri $DownloadGurobi110URL -OutFile $DownloadPath110
Invoke-WebRequest -Uri $DownloadGurobi120URL -OutFile $DownloadPath120
#Check all installed PLEXOS versions and replace expired licensed files for Gurobi
$PLEXOSPATH = Resolve-Path -Path 'C:\Program Files\Energy Exemplar\PLEXOS*'
foreach ($ppath in $PLEXOSPATH){
    if (Test-Path -Path "$ppath\gurobi91.lcr"){Copy-Item -Path $DownloadPath91 -Destination $ppath -Force}
    if (Test-Path -Path "$ppath\gurobi95.lcr"){Copy-Item -Path $DownloadPath95 -Destination $ppath -Force}
    if (Test-Path -Path "$ppath\gurobi100.lcr"){Copy-Item -Path $DownloadPath100 -Destination $ppath -Force}
    if (Test-Path -Path "$ppath\gurobi110.lcr"){Copy-Item -Path $DownloadPath110 -Destination $ppath -Force}
    if (Test-Path -Path "$ppath\gurobi120.lcr"){Copy-Item -Path $DownloadPath120 -Destination $ppath -Force}
}
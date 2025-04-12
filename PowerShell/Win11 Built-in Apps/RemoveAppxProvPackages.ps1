#Script to remove built in appx packages from Win11 Enterprise in device context during Autopilot build
#Create list of apps for removal
$AppxProvPacks = @(
    'Microsoft.BingWeather'
    'Microsoft.BingNews'
    'Microsoft.MicrosoftJournal'
    'Microsoft.GamingApp'
    'Microsoft.Getstarted'
    'Microsoft.Messaging'
    'Microsoft.Microsoft3DViewer'
    'Microsoft.MicrosoftOfficeHub'
    'Microsoft.MicrosoftSolitaireCollection'
    'Microsoft.MixedReality.Portal'
    'Microsoft.OneConnect'
    'Microsoft.People'
    'Microsoft.Print3D'
    'Microsoft.SkypeApp'
    'Microsoft.windowscommunicationsapps'
    'Microsoft.WindowsFeedbackHub'
    'Microsoft.WindowsMaps'
    'Microsoft.XboxApp'
    'Microsoft.Xbox.TCUI'
    'Microsoft.XboxGameOverlay'
    'Microsoft.XboxGamingOverlay'
    'Microsoft.XboxIdentityProvider'
    'Microsoft.XboxSpeechToTextOverlay'
    'Microsoft.YourPhone'
    'Microsoft.ZuneMusic'
    'Microsoft.ZuneVideo'
    'Microsoft.PowerAutomateDesktop'
    'MicrosoftCorporationII.MicrosoftFamily'
    'Microsoft.549981C3F5F10' #Cortana App
    'Microsoft.Windows.DevHome'
    #'Microsoft.MSPaint'
    #'Microsoft.DesktopAppInstaller'
    #'Clipchamp.Clipchamp'
    #'Microsoft.WindowsCamera'
)
#Get currently installed apps
$Apps = Get-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue
#Remove Appx Packages
foreach ($Package in $AppxProvPacks)
{
    if ($apps.DisplayName -eq $Package){
        $PackageName = (Get-AppxProvisionedPackage -Online | Where-Object DisplayName -eq $Package).PackageName
        Remove-AppxProvisionedPackage -Online -PackageName "$PackageName" -AllUsers -ErrorAction SilentlyContinue | Out-Null
    }
}
#Create registry value to detect if this has been executed during Autopilot and it's not needed in already installed devices
$RegistryPath = 'HKLM:\Software\YourCompany\WinBuiltinApps'
$RegistryKey = 'AppxProvPacksRemoved'
$RegistryValue = '1'
New-Item -Path $RegistryPath -Force -ErrorAction SilentlyContinue
New-ItemProperty -Path $RegistryPath -Name $RegistryKey -Value $RegistryValue -Force -ErrorAction SilentlyContinue
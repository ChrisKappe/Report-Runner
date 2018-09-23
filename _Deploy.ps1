import-module "C:\Program Files (x86)\Microsoft Dynamics 365 Business Central\130\RoleTailored Client\NavModelTools.ps1"
import-module "C:\Program Files\Microsoft Dynamics 365 Business Central\130\Service\NavAdminTool.ps1"

$AppSettings = Get-Content ".\app.json" | Out-String | ConvertFrom-Json

$ServiceTier = "BC130"
$AppFolder = "C:\Users\markb\"+$AppSettings.name+"\"
$AppFile = $AppSettings.publisher+"_"+$AppSettings.name+"_" + $AppSettings.Version + ".app"

Uninstall-NAVApp -ServerInstance $ServiceTier -Name $AppSettings.name -Version $AppSettings.version
Unpublish-NAVApp -ServerInstance $ServiceTier -Name $AppSettings.name -Version $AppSettings.version
Publish-NAVApp -ServerInstance $ServiceTier -Path "$AppFolder$AppFile" -SkipVerification
Install-NAVApp -ServerInstance $ServiceTier -Name $AppSettings.name -Version $AppSettings.version

Sync-NAVApp -ServerInstance $ServiceTier -Name $AppSettings.name -Mode Clean -Force
Sync-NAVApp -ServerInstance $ServiceTier -Name $AppSettings.name -Mode Add

# Module manifest for module 'ud-cmwt'
# Generated by: sccmadmin
# Generated on: 8/28/2019

@{
RootModule    = '.\ud-cmwt.psm1'
ModuleVersion = '0.0.6'
# CompatiblePSEditions = @()
GUID   = 'd8f453c1-1379-4de9-a533-bc3f4fee2126'
Author = 'David Stein'
CompanyName = 'Skatterbrainz'
Copyright   = '(c) 2019 David Stein. All rights reserved.'
Description = 'Web Console UI for AD, AzureAD, and Configuration Manager built with UniversalDashboard Community Edition 2.5.3.'
# PowerShellVersion = ''
# PowerShellHostName = ''
# PowerShellHostVersion = ''
# DotNetFrameworkVersion = ''
# CLRVersion = ''
# ProcessorArchitecture = ''
RequiredModules = @("dbatools","adsips","UniversalDashboard.Community")
# RequiredAssemblies = @()
# ScriptsToProcess = @()
# TypesToProcess = @()
# FormatsToProcess = @()
# NestedModules = @()
FunctionsToExport = @('Start-UDCmwtDashboard','Import-CmwtCredential','Export-CmwtCredential','Set-CmwtConfigJson','Get-CmwtConfigJson','Get-CmwtDbQuery')
CmdletsToExport   = '*'
VariablesToExport = '*'
AliasesToExport   = '*'
# DscResourcesToExport = @()
# ModuleList = @()
# FileList = @()
PrivateData = @{
    PSData = @{
        Tags = @('CMWT','ConfigMgr','sccm','activedirectory','ud-dashboard','UniversalDashboard')
        LicenseUri = 'https://github.com/Skatterbrainz/ud-cmwt/blob/master/LICENSE'
        ProjectUri = 'https://github.com/Skatterbrainz/ud-cmwt'
        IconUri    = 'https://user-images.githubusercontent.com/11505001/63904011-88b48c80-c9dd-11e9-9d66-bdf211c8b0e2.png'
        ReleaseNotes = 'Still in development. Check back often.'
    }
}
HelpInfoURI = 'https://github.com/Skatterbrainz/ud-cmwt/wiki'
# DefaultCommandPrefix = ''
}

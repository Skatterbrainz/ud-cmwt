# Module manifest for module 'ud-cmwt'
# Generated by: sccmadmin
# Generated on: 8/22/2019

@{
RootModule = '.\ud-cmwt.psm1'
ModuleVersion = '0.0.2'
# CompatiblePSEditions = @()
GUID = 'd8f453c1-1379-4de9-a533-bc3f4fee2126'
Author = 'David Stein'
CompanyName = 'Skatterbrainz'
Copyright = '(c) 2019 David Stein. All rights reserved.'
Description = 'Web Console UI for AD, AzureAD, and Configuration Manager built with UniversalDashboard.'
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
FunctionsToExport = @('Start-UDCmwtDashboard','Import-CmwtCredential','Export-CmwtCredential')
CmdletsToExport = '*'
VariablesToExport = '*'
AliasesToExport = '*'
# DscResourcesToExport = @()
# ModuleList = @()
# FileList = @()
PrivateData = @{
    PSData = @{
        Tags = @('CMWT','ConfigMgr','sccm','activedirectory','ud-dashboard','UniversalDashboard')
        LicenseUri = 'https://github.com/Skatterbrainz/ud-cmwt/blob/master/LICENSE'
        ProjectUri = 'https://github.com/Skatterbrainz/ud-cmwt'
        # IconUri = ''
        ReleaseNotes = 'Still in development. Check back often.'
    }
}
# HelpInfoURI = ''
# DefaultCommandPrefix = ''
}

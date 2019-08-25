<#
.SYNOPSIS
    Export AzureAD credentials to a JSON file
.DESCRIPTION
    Import AzureAD credentials to a JSON file for use with CMWT
.PARAMETER FilePath
    Path and filename. Default is "$($env:userprofile)\documents\cmwt-aad-cred.json"
.PARAMETER Force
    Overwrite destination if it exists
.EXAMPLE
    Export-CmwtCredential -Force
.OUTPUTS
    JSON file
.NOTES
    NOT the most secure way to store credentials! Protect access to this file!
#>

function Export-CmwtCredential {
    [CmdletBinding()]
    param (
        [parameter()] [ValidateNotNullOrEmpty()] [string] $FilePath = $(Join-Path -Path $env:USERPROFILE -ChildPath "Documents\cmwt-aad-cred.json"),
        [parameter()] [switch] $Force
    )
    if ((Test-Path $FilePath) -and (-not $Force)) {
        Write-Warning "File [$FilePath] exists! To overwrite, use the -Force parameter"
        break
    }
    else {
        $cred = Get-Credential -Message "AzureAD Credentials"
        if ($null -ne $cred) {
            $cred | Select-Object Username,@{n="Password"; e={$_.password | ConvertFrom-SecureString}} |
                ConvertTo-Json |
                    Set-Content -Path $FilePath -Encoding UTF8 -Force
        }
        else {
            Write-Warning "Credentials were not provided for exporting."
        }
    }
}

<#
.SYNOPSIS
    Import CMWT AzureAD credentials from JSON file
.DESCRIPTION
    Import CMWT AzureAD credentials from JSON file created using Export-CmwtCredential
.PARAMETER FilePath
    Path and filename. Default is "$($env:userprofile)\documents\cmwt-aad-cred.json"
.EXAMPLE
    $aadCred = Import-CmwtCredential
.OUTPUTS
    PSCredential object
#>
function Import-CmwtCredential {
    [CmdletBinding()]
    param (
        [parameter()] [ValidateNotNullOrEmpty()]
        [string] $FilePath = $(Join-Path -Path $env:USERPROFILE -ChildPath "Documents\cmwt-aad-cred.json")
    )
    Write-Verbose "searching for file: $FilePath"
    if (Test-Path $FilePath) {
        $xdata = Get-Content -Path $FilePath -Encoding UTF8 -Raw | ConvertFrom-Json
        $(New-Object -TypeName PSCredential $xdata.UserName, ($xdata.Password | ConvertTo-SecureString))
    }
    else {
        Write-Warning "File not found: $FilePath"
    }
}

<#
.SYNOPSIS
    Create or Update CMWT configuration settings file
.DESCRIPTION
    Create or Update CMWT configuration settings file
.PARAMETER SmsProvider
    Configuration Manager SMS Provider hostname
.PARAMETER SqlHost
    Configuration Manager site database SQL Server hostname
.PARAMETER SiteCode
    Configuration Manager Site Code
.PARAMETER Port
    TCP Port to run local instance. Default is 8081
.EXAMPLE
    Set-CmwtConfigJson -SmsProvider "CM01" -SqlHost "CM01" -SiteCode "P01" -Port 8080
.OUTPUTS
    JSON file
.NOTES
    JSON file can be edited externally if desired
#>
function Set-CmwtConfigJson {
    [CmdletBinding()]
    param (
        [parameter(Mandatory, HelpMessage="ConfigMgr SMS Provider name")]
        [validateLength(3,32)] [string] $SmsProvider,
        [parameter(Mandatory, HelpMessage="ConfigMgr SQL Hostname")]
        [validateLength(3,32)] [string] $SqlHost,
        [parameter(Mandatory, HelpMessage="ConfigMgr Site Code")]
        [validateLength(3,3)] [string] $SiteCode,
        [parameter(HelpMessage="TCP Port Number")]
        [int] $Port = 8081,
        [parameter(HelpMessage="Path to Configuration JSON file")]
        [ValidateNotNullOrEmpty()]
        [string] $FilePath = $(Join-Path $env:USERPROFILE "documents\cmwt-settings.json"),
        [parameter()] [switch] $Force
    )
    if (Test-Path $FilePath) {
        if ($Force) {
            Write-Verbose "deleting existing file: $FilePath"
            Get-Item -Path $FilePath | Remove-Item -Force -Confirm:$False
        }
        else {
            Write-Warning "$FilePath exists.  To replace, use the -Force parameter."
            break
        }
    }
    Write-Verbose "saving settings to: $FilePath"
    @{SMSPROVIDER = $SmsProvider; SQLHOST = $SqlHost; SITECODE = $SiteCode; PORT = $Port} |
        ConvertTo-Json | Set-Content -Path $FilePath -Encoding UTF8 -Force
    Write-Output "Settings were saved successfully to $FilePath"
}

<#
.SYNOPSIS
    Launch CMWT UniversalDashboard instance
.DESCRIPTION
    Ummmmm, yeah, I just said that.
.PARAMETER ConfigJson
    Path to CMWT configuration JSON file. Default is "($env:USERPROFILE)\documents\cmwt-settings.json"
    Use the Set-CmwtConfigJson function to create or update a configuration file.
.PARAMETER SmsProvider
    Configuration Manager SMS Provider host name
    ConfigJson overrides this parameter
.PARAMETER SqlHost
    Configuration Manager site database SQL Server host name
    ConfigJson overrides this parameter
.PARAMETER SiteCode
    Configuration Manager site code
    ConfigJson overrides this parameter
.PARAMETER Credential
    AzureAD credentials
    If omitted, read from AzureAD credentials file
.PARAMETER Port
    TCP port to run CMWT instance. Default is 8081
    ConfigJson overrides this parameter
.EXAMPLE
    Start-UDCmwtDashboard
    Start CMWT using default parameters from configuration file
.EXAMPLE
    Start-UDCmwtDashboard -ConfigJson ".\myconfig.json"
    Use specified configuration file
.EXAMPLE
    Start-UDCmwtDashboard -SmsProvider "CM01" -SqlHost "CM01" -SiteCode "P01"
    Start with direct parameter values
.OUTPUTS
    UDDashboard instance: Name, Port, Running, DashboardService
.NOTES
    Tested with UD Community Edition 2.5.3 only
#>
function Start-UDCmwtDashboard {
    [CmdletBinding()]
    param (
        [parameter(HelpMessage="Path to Configuration JSON file")] [string] $ConfigJson = $(Join-Path $env:USERPROFILE "documents\cmwt-settings.json"),
        [parameter(HelpMessage="ConfigMgr SMS Provider name")] [string] $SmsProvider = "",
        [parameter(HelpMessage="ConfigMgr SQL Hostname")] [string] $SqlHost = "",
        [parameter(HelpMessage="ConfigMgr Site Code")] [string] $SiteCode = "",
        [parameter(HelpMessage="AzureAD Credentials")] [pscredential] $Credential,
        [parameter(HelpMessage="Local Port for CMWT")] [int] $Port = 8081
    )
    if ($null -eq $Credential) {
        Write-Verbose "AzureAD credentials were not provided."
        Write-Verbose "looking for default AzureAD credential file"
        $Credential = Import-CmwtCredential
        if ($null -eq $Credential) {
            Write-Warning "credentials not provided or available in cred-file. Aborting"
            break
        }
    }
    if (![string]::IsNullOrEmpty($ConfigJson)) {
        Write-Verbose "looking for default site configuration file: $ConfigJson"
        if (Test-Path $ConfigJson) {
            Write-Verbose "importing local settings file: $ConfigJson"
            $jdat = Get-Content $ConfigJson -Encoding UTF8 -Raw | ConvertFrom-Json
            $SmsProvider = $jdat.SMSPROVIDER
            $SqlHost  = $jdat.SQLHOST
            $SiteCode = $jdat.SITECODE
            $Port     = $jdat.PORT
            if ([string]::IsNullOrEmpty($SmsProvider) -or ([string]::IsNullOrEmpty($SqlHost)) -or ([string]::IsNullOrEmpty($SiteCode))) {
                Write-Warning "invalid configuration data. unable to continue."
                break
            }
            else {
                Write-Verbose "successfully imported configuration data"
            }
        }
        else {
            Write-Warning "file not found: $ConfigJson"
            Write-Warning "no settings were provided. aborting"
            break
        }
    }
    if ([string]::IsNullOrEmpty($SmsProvider) -or ([string]::IsNullOrEmpty($SqlHost)) -or ([string]::IsNullOrEmpty($SiteCode))) {
        Write-Warning "No site parameters provided. unable to continue."
        break
    }
    $Cache:Loading = $True
    $Cache:ConnectionInfo = @{
        SmsProvider = $SmsProvider
        Server      = $SqlHost
        SiteCode    = $SiteCode
        Credential  = $Credential
        AppName     = "CMWT"
        AppVersion  = [string]$((Get-Module 'ud-cmwt').Version -join '.')
        BasePath    = [string]$(Split-Path ((Get-Module 'ud-cmwt').Path))
    }

    $Utilities = (Join-Path $PSScriptRoot 'ud-cminit.psm1')
    Import-Module $Utilities

    $Pages = Get-ChildItem (Join-Path $PSScriptRoot 'pages') -Recurse -File |
        ForEach-Object {
            Write-Verbose "loading: $($_.FullName)"
            & $_.FullName
        }

#    $Endpoints = Get-ChildItem (Join-Path $PSScriptRoot 'endpoints') | ForEach-Object {
#        & $_.FullName
#    }

    Write-UDLog -Message $Cache:ConnectionInfo.Server
    Write-UDLog -Message $Cache:ConnectionInfo.SiteCode

    #region NavigationMenu

    $Navigation = New-UDSideNav -Content {
        New-UDSideNavItem -Text "Home" -Url "Home" -Icon home
        New-UDSideNavItem -Text "ConfigMgr" -Icon folder -Children {
            New-UDSideNavItem -Text "Assets" -Icon folder -Children {
                New-UDSideNavItem -Text "Devices" -Url "cmdevices" -Icon desktop
                New-UDSideNavItem -Text "Device Collections" -Url "cmdcollections" -Icon desktop
                New-UDSideNavItem -Text "Users" -Url "cmusers" -Icon users
                New-UDSideNavItem -Text "User Collections" -Url "cmucollections" -Icon users
            }
            New-UDSideNavItem -Text "Software" -Icon folder -Children {
                New-UDSideNavItem -Text "Applications" -Icon folder -Children {
                    New-UDSideNavItem -Text "Applications" -Url "cmapps" -Icon app_store
                    New-UDSideNavItem -Text "Application Groups" -Url "cmappgroups" -Icon app_store
                    New-UDSideNavItem -Text "Packages" -Url "cmpackages" -Icon app_store
                }
                New-UDSideNavItem -Text "Software Updates" -Icon folder -Children {
                    New-UDSideNavItem -Text "All Updates" -Url "cmupdates" -Icon stroopwafel
                    New-UDSideNavItem -Text "Update Groups" -Url "cmupdategrps" -Icon stroopwafel
                    New-UDSideNavItem -Text "Update Packages" -Url "cmupdatepkgs" -Icon stroopwafel
                    New-UDSideNavItem -Text "ADRs" -Url "cmadrs" -Icon stroopwafel
                }
                New-UDSideNavItem -Text "OS Deployment" -Icon folder -Children {
                    New-UDSideNavItem -Text "OS Images" -Url "cmosimages" -Icon windows
                    New-UDSideNavItem -Text "OS Upgrades" -Url "cmosupgrades" -Icon windows
                    New-UDSideNavItem -Text "Driver Packages" -Url "cmdriverpkgs" -Icon usb
                    New-UDSideNavItem -Text "Task Sequences" -Url "cmtasksequences" -Icon network_wired
                    New-UDSideNavItem -Text "Boot Images" -Url "cmbootimages" -Icon windows
                    New-UDSideNavItem -Text "VHD Packages" -Url "cmvhdpkgs" -Icon gears
                }
                New-UDSideNavItem -Text "SW Inventory" -Icon folder -Children {
                    New-UDSideNavItem -Text "Installed Software" -Url "cmswinventory" -Icon file_contract
                    New-UDSideNavItem -Text "Operating Systems" -Url "cmswinventory" -Icon file_alt
                    New-UDSideNavItem -Text "Installed Software" -Url "cmswinventory" -Icon file_contract
                }
            }
            New-UDSideNavItem -Text "Administration" -Icon folder -Children {
                New-UDSideNavItem -Text "Discovery Methods" -Url "cmdiscmethods" -Icon search
                New-UDSideNavItem -Text "Site Boundaries" -Url "cmboundaries" -Icon city
                New-UDSideNavItem -Text "Boundary Groups" -Url "cmboundarygroups" -Icon city
                New-UDSideNavItem -Text "Site Systems" -Url "cmsitesystems" -Icon server
                New-UDSideNavItem -Text "Site Administrators" -Url "cmadmins" -Icon user_shield
            }
            New-UDSideNavItem -Text "Monitoring" -Icon folder -Children {
                New-UDSideNavItem -Text "$Server" -Icon folder -Children {
                    New-UDSideNavItem -Text "Processes" -Url "processes" -Icon tachometer
                    New-UDSideNavItem -Text "Services" -PageName "services" -Icon tachometer
                    New-UDSideNavItem -Text "System Event Log" -PageName "eventlog" -Icon thermometer
                }
                New-UDSideNavItem -Text "$SiteCode - Site Status" -Url "cmsitestatus" -Icon medkit
                New-UDSideNavItem -Text "$SiteCode - Component Status" -Url "cmcompstatus" -Icon medkit
                New-UDSideNavItem -Text "$SiteCode - Deployments" -Url "cmdepsummary" -Icon thermometer
                New-UDSideNavItem -Text "SUP Synch Status" -Url "cmsupsynch" -Icon thermometer
            }
            New-UDSideNavItem -Text "$SiteHost SQL Server" -Icon folder -Children {
                New-UDSideNavItem -Text "SQL Version" -Url "sqlserverinfo" -Icon usb
                New-UDSideNavItem -Text "Database Files" -Url "sqlfiles" -Icon files_o
                New-UDSideNavItem -Text "SQL Agent Jobs" -Url "sqlagentjobs" -Icon usb
                New-UDSideNavItem -Text "Status" -Icon folder -Children {
                    New-UDSideNavItem -Text "SQL Agent Job History" -Url "sqlagentjobhistory" -Icon clock
                    New-UDSideNavItem -Text "Backup History" -Url "sqlbackuphistory" -Icon clock
                    New-UDSideNavItem -Text "SPN Registrations" -Url "sqlspn" -Icon search_location
                }
                New-UDSideNavItem -Text "Performance" -Icon folder -Children {
                    New-UDSideNavItem -Text "Memory Usage" -Url "sqlmem" -Icon thermometer
                    New-UDSideNavItem -Text "Fragmentation" -Url "sqlindexfrag" -Icon thermometer
                }
                New-UDSideNavItem -Text "CM_$SiteCode Database" -Icon folder -Children {
                    New-UDSideNavItem -Text "Views" -Url "dbviews" -Icon table
                    New-UDSideNavItem -Text "Tables" -Url "dbtables" -Icon table
                }
            }
        } # configmgr
        New-UDSideNavItem -Text "Active Directory" -Icon folder -Children {
            New-UDSideNavItem -Text "Domain" -Url "addomain" -Icon mountain
            New-UDSideNavItem -Text "Computers" -Url "adcomputers" -Icon desktop
            New-UDSideNavItem -Text "Users" -Url "adusers" -Icon users
            New-UDSideNavItem -Text "Contacts" -Url "adcontacts" -Icon address_card
            New-UDSideNavItem -Text "Security Groups" -Url "adgroups" -Icon users_cog
        }
        New-UDSideNavItem -Text "Azure AD" -Icon folder -Children {
            New-UDSideNavItem -Text "Users" -Url "aadusers" -Icon users
            New-UDSideNavItem -Text "Groups" -Url "aadgroups" -Icon users_cog
            New-UDSideNavItem -Text "Devices" -Url "aadcomputers" -Icon desktop
        }
        New-UDSideNavItem -Text "References" -Url "references" -Icon link
        New-UDSideNavItem -Text "UD Documentation" -Url "https://docs.universaldashboard.io/" -Icon link
        New-UDSideNavItem -Text "Send Feedback" -Url "https://github.com/Skatterbrainz/ud-cmwt/issues" -Icon comment
        New-UDSideNavItem -Text "About" -Url "About" -Icon info_circle
    }
    #endregion NavigationMenu

    $Dashboard = New-UDDashboard -Title $AppName -Pages $Pages -Navigation $Navigation
    Start-UDDashboard -Dashboard $Dashboard -Port $Port
}

﻿function Export-CmwtCredential {
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
            $cred | Select Username,@{n="Password"; e={$_.password | ConvertFrom-SecureString}} |
                ConvertTo-Json |
                    Set-Content -Path $FilePath -Encoding UTF8 -Force
        }
        else {
            Write-Warning "Credentials were not provided for exporting."
        }
    }
}

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

function Start-UDCmwtDashboard {
    [CmdletBinding()]
    param (
        [parameter(Mandatory)] [ValidateLength(3,15)] [string] $Server,
        [parameter(Mandatory)] [ValidateLength(3,3)] [string] $SiteCode,
        [parameter()] [pscredential] $Credential,
        [parameter()] [int] $Port = 8081
    )
    if ($null -eq $Credential) {
        $Credential = Import-CmwtCredential
        if ($null -eq $Credential) {
            Write-Warning "credentials not provided or available in cred-file. Aborting"
            break
        }
    }
    $Cache:Loading = $True
    $Cache:ConnectionInfo = @{
        Server     = $Server
        SiteCode   = $SiteCode
        Credential = $Credential
        AppName    = "CMWT"
        AppVersion = [string]$((Get-Module 'ud-cmwt').Version -join '.')
        BasePath   = [string]$(Split-Path ((Get-Module 'ud-cmwt').Path))
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
                New-UDSideNavItem -Text "SQL Agent Jobs" -Url "sqlagentjobs" -Icon usb
                New-UDSideNavItem -Text "SQL Agent Job History" -Url "sqlagentjobhistory" -Icon clock
                New-UDSideNavItem -Text "Backup History" -Url "sqlbackuphistory" -Icon clock
                New-UDSideNavItem -Text "Memory Usage" -Url "sqlmem" -Icon thermometer
                New-UDSideNavItem -Text "SPN Registrations" -Url "sqlspn" -Icon search_location
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
        New-UDSideNavItem -Text "About" -Url "About" -Icon info
    }
    $Dashboard = New-UDDashboard -Title "CMWT" -Pages $Pages -Navigation $Navigation
    Start-UDDashboard -Dashboard $Dashboard -Port $Port
}

function Start-UDCmwtDashboard {
    [CmdletBinding()]
    param (
        [parameter(Mandatory)] [ValidateLength(3,15)] [string] $Server,
        [parameter(Mandatory)] [ValidateLength(3,3)] [string] $SiteCode,
        [parameter(Mandatory)] [pscredential] $Credential,
        [parameter()] [int] $Port = 8081
    )
    $Cache:Loading = $True
    $Cache:ConnectionInfo = @{
        Server     = $Server
        SiteCode   = $SiteCode
        Credential = $Credential
        AppName    = "CMWT"
        AppVersion = [string]$((Get-Module 'ud-cmwt').Version -join '.')
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

    <#
    Assets and Compliance
    Software Library
        Applications
        Application Groups
        Packages
        Software Updates
            All Updates
            Update Groups
            Update Packages
            ADRs
        Operating Systems
            OS Images
            OS Upgrade Packages
            Drivers
            Driver Packages
            Boot Images
            Task Sequences
        Office 365
            Office 365 Updates
        Windows 10
            Servicing Plans
        Scripts
    Monitoring
        Queries
        Reports
        Site Status
        Component Status
        Deployments
        Client Health
    Administration
        Hierarchy
        Discovery Methods
        Site Boundaries
        Boundary Groups
        Site Systems
        Security / Accounts
        Client Settings
        Distribution Points
        Distribution Groups
    #>

    $Navigation = New-UDSideNav -Content {
        New-UDSideNavItem -Text "Home" -Url "Home" -Icon home
        New-UDSideNavItem -Text "Devices" -Icon folder -Children {
            New-UDSideNavItem -Text "CM Devices" -Url "cmdevices" -Icon desktop
            New-UDSideNavItem -Text "CM Device Collections" -Url "cmdcollections" -Icon desktop
            New-UDSideNavItem -Text "AD Devices" -Url "adcomputers" -Icon desktop
            New-UDSideNavItem -Text "AzureAD Devices" -Url "aadcomputers" -Icon desktop
        }
        New-UDSideNavItem -Text "Users" -Icon folder -Children {
            New-UDSideNavItem -Text "CM Users" -Url "cmusers" -Icon users
            New-UDSideNavItem -Text "CM User Collections" -Url "cmucollections" -Icon users
            New-UDSideNavItem -Text "AD Users" -Url "adusers" -Icon users
            New-UDSideNavItem -Text "AD Groups" -Url "adgroups" -Icon users_cog
            New-UDSideNavItem -Text "AzureAD Users" -Url "aadusers" -Icon users
        }
        New-UDSideNavItem -Text "Software" -Icon folder -Children {
            New-UDSideNavItem -Text "CM Deployments" -Icon folder -Children {
                New-UDSideNavItem -Text "Applications" -Url "cmapps" -Icon app_store
                New-UDSideNavItem -Text "Packages" -Url "cmpackages" -Icon app_store
            }
            New-UDSideNavItem -Text "CM Updates" -Icon folder -Children {
                New-UDSideNavItem -Text "All Updates" -Url "cmupdates" -Icon stroopwafel
                New-UDSideNavItem -Text "Update Groups" -Url "cmupdategrps" -Icon stroopwafel
                New-UDSideNavItem -Text "Update Packages" -Url "cmupdatepkgs" -Icon stroopwafel
                New-UDSideNavItem -Text "ADRs" -Url "cmadrs" -Icon stroopwafel
            }
            New-UDSideNavItem -Text "CM OS Deployment" -Icon folder -Children {
                New-UDSideNavItem -Text "OS Images" -Url "cmosimages" -Icon windows
                New-UDSideNavItem -Text "OS Upgrades" -Url "cmosupgrades" -Icon windows
                New-UDSideNavItem -Text "Driver Packages" -Url "cmdriverpkgs" -Icon usb
                New-UDSideNavItem -Text "Task Sequences" -Url "cmtasksequences" -Icon network_wired
                New-UDSideNavItem -Text "Boot Images" -Url "cmbootimages" -Icon windows
                New-UDSideNavItem -Text "VHD Packages" -Url "cmvhdpkgs" -Icon gears
            }
            New-UDSideNavItem -Text "CM Inventory" -Icon folder -Children {
                New-UDSideNavItem -Text "Installed Software" -Url "cmswinventory" -Icon file_contract
                New-UDSideNavItem -Text "Operating Systems" -Url "cmswinventory" -Icon file_alt
                New-UDSideNavItem -Text "Installed Software" -Url "cmswinventory" -Icon file_contract
            }
        }
        New-UDSideNavItem -Text "CM Administration" -Icon folder -Children {
            New-UDSideNavItem -Text "Discovery Methods" -Url "cmdiscmethods" -Icon search
            New-UDSideNavItem -Text "Site Boundaries" -Url "cmboundaries" -Icon city
            New-UDSideNavItem -Text "Boundary Groups" -Url "cmboundarygroups" -Icon city
            New-UDSideNavItem -Text "Site Systems" -Url "cmsitesystems" -Icon server
        }
        New-UDSideNavItem -Text "CM Monitoring" -Icon folder -Children {
            New-UDSideNavItem -Text "$Server - Processes" -Url "processes" -Icon tachometer
            New-UDSideNavItem -Text "$Server - Services" -PageName "services" -Icon tachometer
            New-UDSideNavItem -Text "$Server - Event Log" -PageName "eventlog" -Icon tachometer
            New-UDSideNavItem -Text "$SiteCode - Site Status" -Url "cmsitestatus" -Icon medkit
            New-UDSideNavItem -Text "$SiteCode - Component Status" -Url "cmcompstatus" -Icon medkit
        }
        New-UDSideNavItem -Text "References" -Url "references" -Icon link
        New-UDSideNavItem -Text "UD Documentation" -Url "https://docs.universaldashboard.io/" -Icon link
        New-UDSideNavItem -Text "Send Feedback" -Url "https://github.com/Skatterbrainz/ud-cmwt/issues" -Icon comment
        New-UDSideNavItem -Text "About" -Url "About" -Icon info
    }
    $Dashboard = New-UDDashboard -Title "CMWT" -Pages $Pages -Navigation $Navigation
    Start-UDDashboard -Dashboard $Dashboard -Port $Port
}

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

    $Navigation = New-UDSideNav -Content {
        New-UDSideNavItem -Text "Home" -Url "Home" -Icon home
        New-UDSideNavItem -Text "$Server" -Icon folder -Children {
            New-UDSideNavItem -Text "Processes" -Url "processes" -Icon tachometer
            New-UDSideNavItem -Text "Services" -PageName "services" -Icon tachometer
            New-UDSideNavItem -Text "Event Log" -PageName "eventlog" -Icon tachometer
        }
        New-UDSideNavItem -Text "Machines" -Icon folder -Children {
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
        New-UDSideNavItem -Text "About" -Url "About" -Icon info
    }
    $Dashboard = New-UDDashboard -Title "CMWT" -Pages $Pages -Navigation $Navigation
    Start-UDDashboard -Dashboard $Dashboard -Port $Port
}
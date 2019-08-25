New-UDPage -Name "SQLServerInfo" -Id 'sqlserverinfo' -Content {
    New-UDGrid -Title "SQL Server Platform: $($Cache:ConnectionInfo.Server)" -Endpoint {
        Get-DbaBuildReference -SqlInstance $Cache:ConnectionInfo.Server | Foreach-Object {
            [pscustomobject]@{
                HostName     = [string]$_.SqlInstance
                Build        = [string]$_.Build
                Version      = [string]$_.NameLevel
                ServicPack   = [string]$_.SPLevel
                CULevel      = [string]$_.CULevel
                KBLevel      = [string]$_.KBLevel
                BuildLevel   = [string]$_.BuildLevel
                SupportUntil = [string]$_.SupportedUntil
            }
        } | Out-UDGridData
    }
}

New-UDPage -Name "SQLmem" -Id 'sqlmem' -Content {
    New-UDGrid -Title "SQL Server Memory Usage: $($Cache:ConnectionInfo.Server)" -Endpoint {
        Get-DbaDbMemoryUsage -SqlInstance $Cache:ConnectionInfo.Server | Foreach-Object {
            [pscustomobject]@{
                HostName    = [string]$_.ComputerName
                Instance    = [string]$_.InstanceName
                Database    = [string]$_.Database
                PageType    = [string]$_.PageType
                PercentUsed = [string]$_.PercentUsed
                Size        = [string]$_.Size
            }
        } | Out-UDGridData
    }
}

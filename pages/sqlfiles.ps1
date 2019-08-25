New-UDPage -Name "SQLFiles" -Id 'sqlfiles' -Content {
    New-UDGrid -Title "SQL Server Database Files: $($Cache:ConnectionInfo.Server)" -Endpoint {
        Get-DbaDbFile -SqlInstance $Cache:ConnectionInfo.Server | Foreach-Object {
            [pscustomobject]@{
                InstanceName = [string]$_.InstanceName
                Database     = [string]$_.Database
                LogicalName  = [string]$_.LogicalName
                PhysicalFile = [string]$_.PhysicalName
                State        = [string]$_.State
                MaxSize      = [string]$_.MaxSize
                CurrentSize  = [string]$_.Size
                AutoGrowth   = "$([string]$_.Growth) $($_.GrowthType)"
            }
        } | Out-UDGridData
    }
}

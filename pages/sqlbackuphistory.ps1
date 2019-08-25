New-UDPage -Name "SQLBackupHistory" -Id 'sqlbackuphistory' -Content {
    New-UDGrid -Title "SQL Server Backup History: $($Cache:ConnectionInfo.Server)" -Endpoint {
        Get-DbaDbBackupHistory -SqlInstance $Cache:ConnectionInfo.Server |
            Sort-Object End -Descending | Foreach-Object {
                [pscustomobject]@{
                    Instance  = [string]$_.SqlInstance
                    Database  = [string]$_.Database
                    UserName  = [string]$_.UserName
                    StartTime = [string]$_.Start
                    EndTime   = [string]$_.End
                    TotalSize = [string]$_.TotalSize
                    Type      = [string]$_.Type
                    Target    = [string]$_.DeviceType
                    Recovery  = [string]$_.RecoveryModel
                }
            } | Out-UDGridData
    }
}
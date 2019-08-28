New-UDPage -Name "sqlagentjobhistory" -Id 'sqlagentjobhistory' -Content {
    New-UDGrid -Title "SQL Server Agent Job History: $($Cache:ConnectionInfo.Server)" -Endpoint {
        Get-DbaAgentJobHistory -SqlInstance $Cache:ConnectionInfo.Server |
            Sort-Object End -Descending | Foreach-Object {
                [pscustomobject]@{
                    Instance  = [string]$_.SqlInstance
                    JobName   = [string]$_.JobName
                    StepName  = [string]$_.StepName
                    Status    = [string]$_.Status
                    UserName  = [string]$_.UserName
                    RunDate   = [string]$_.RunDate
                    Duration  = [string]$_.Duration
                }
            } | Out-UDGridData
    }
}
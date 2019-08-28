New-UDPage -Name "sqlagentjobs" -Id 'sqlagentjobs' -Content {
    New-UDGrid -Title "SQL Agent Jobs: $($Cache:ConnectionInfo.Server)" -Endpoint {
        Get-DbaAgentJob -SqlInstance $Cache:ConnectionInfo.Server | Foreach-Object {
            [pscustomobject]@{
                Name          = [string]$_.Name
                Owner         = [string]$_.OwnerLoginName
                CurrentStatus = [string]$_.CurrentRunStatus
                LastRunDate   = [string]$_.LastRunDate
                LastResult    = [string]$_.LastRunOutcome
            }
        } | Out-UDGridData
    }
}

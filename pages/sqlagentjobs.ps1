New-UDPage -Name "sqlagentjobs" -Id 'sqlagentjobs' -Content {
    $SiteHost = $Cache:ConnectionInfo.Server
    New-UDGrid -Title "SQL Agent Jobs: $SiteHost" -Endpoint {
        Get-DbaAgentJob -SqlInstance $SiteHost | Foreach-Object {
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

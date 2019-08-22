New-UDPage -Name "SQL Agent Jobs" -Icon database -Content {
    New-UDGrid -Title "SQL Agent Jobs: $SiteHost" -Endpoint {
        $SiteHost = $Cache:ConnectionInfo.Server
        $SiteCode = $Cache:ConnectionInfo.SiteCode
        Get-DbaAgentJob -SqlInstance $SiteHost | 
            Select Name,OwnerLoginName,CurrentRunStatus,LastRunDate,LastRunOutcome | Out-UDGridData
    }
}

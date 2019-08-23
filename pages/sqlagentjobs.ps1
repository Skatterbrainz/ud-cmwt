New-UDPage -Name "SQL Agent Jobs" -Icon database -Content {
    New-UDGrid -Title "SQL Agent Jobs: $($Cache:ConnectionInfo.Server)" -Endpoint {
        Get-DbaAgentJob -SqlInstance $Cache:ConnectionInfo.Server | 
            Select Name,OwnerLoginName,CurrentRunStatus,LastRunDate,LastRunOutcome | Out-UDGridData
    }
}

New-UDPage -Name "CMCompStatus" -Icon app_store -Content {
	New-UDGrid -Title "Configuration Manager Component Status" -Endpoint {
        $SiteHost = $Cache:ConnectionInfo.Server
        $SiteCode = $Cache:ConnectionInfo.SiteCode
        $query = "SELECT DISTINCT
ComponentName,
case
    when (Status = 0) then 'Good'
    when (Status = 1) then 'Warning'
    when (Status = 2) then 'Fail'
    end as Status,
case
    when (state = 0) then 'Stopped'
    when (state = 1) then 'Started'
    when (state = 2) then 'Paused'
    when (state = 3) then 'Installing'
    when (state = 4) then 'Re-installing'
    when (state = 5) then 'De-installing'
    end as [State],
LastContacted,
MAX([Infos]) as Info,
MAX([Warnings]) as Warning,
MAX([Errors]) as [Error]
FROM
vSMS_ComponentSummarizer
GROUP BY
ComponentName, LastContacted, Status, State"
        Invoke-DbaQuery -SqlInstance $SiteHost -Database "CM_$SiteCode" -Query $query |
            Select ComponentName,Status,State,Info,Warning,Error,LastContacted |
                Out-UDGridData
    }
}

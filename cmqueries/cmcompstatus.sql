SELECT DISTINCT
    ComponentName,
    case
        when (Status = 0) then 'Good'
        when (Status = 1) then 'Warning'
        when (Status = 2) then 'Error'
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
    dbo.vSMS_ComponentSummarizer
GROUP BY
    ComponentName, LastContacted, Status, State
order by
    ComponentName
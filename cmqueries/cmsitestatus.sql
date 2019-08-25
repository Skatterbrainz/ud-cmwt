SELECT DISTINCT
    case
      when (Status = 0) then 'Good'
      when (Status = 1) then 'Warning'
      when (Status = 2) then 'Error'
      end as SiteStatus,
    Role,
    SiteCode,
    case
      when (AvailabilityState = 0) then 'Online'
      when (AvailabilityState = 1) then '1'
      when (AvailabilityState = 2) then '2'
      when (AvailabilityState = 3) then 'Offline'
      when (AvailabilityState = 4) then '4'
      else 'Unknown'
      end as Availability,
    SiteSystem,
    TimeReported
FROM dbo.v_SiteSystemSummarizer
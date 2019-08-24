New-UDPage -Name "CMSiteStatus" -Icon app_store -Content {
	New-UDGrid -Title "Configuration Manager Site Status" -Endpoint {
        $SiteHost = $Cache:ConnectionInfo.Server
        $SiteCode = $Cache:ConnectionInfo.SiteCode
        $query = "SELECT DISTINCT
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
FROM v_SiteSystemSummarizer"
        Invoke-DbaQuery -SqlInstance $SiteHost -Database "CM_$SiteCode" -Query $query | Foreach-Object {
            $sysname = (([string]$_.SiteSystem) -split '\\')[2]
            [pscustomobject]@{
                SiteSystem   = [string]$sysname.ToLower()
                Role         = [string]$_.Role
                SiteStatus   = [string]$_.SiteStatus
                Availability = [string]$_.Availability
                TimeReported = [string]$_.TimeReported
            }
        } | Out-UDGridData
    }
}

New-UDPage -Name "CMBoundaryGroups" -Icon app_store -Content {
	New-UDGrid -Title "Configuration Manager Boundary Groups" -Endpoint {
        $SiteHost = $Cache:ConnectionInfo.Server
        $SiteCode = $Cache:ConnectionInfo.SiteCode
        $query = "SELECT DISTINCT
Name as DisplayName,
GroupID as BGroupID,
Description,
Flags,
DefaultSiteCode,
CreatedOn,
MemberCount as Boundaries,
SiteSystemCount as SiteSystems
FROM dbo.vSMS_BoundaryGroup
ORDER BY Name"
        Invoke-DbaQuery -SqlInstance $SiteHost -Database "CM_$SiteCode" -Query $query |
            Select DisplayName,BGroupID,Description,Boundaries,SiteSystems | Out-UDGridData
    }
}

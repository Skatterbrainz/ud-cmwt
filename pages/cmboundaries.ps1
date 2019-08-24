New-UDPage -Name "CMBoundaries" -Icon app_store -Content {
	New-UDGrid -Title "Configuration Manager Site Boundaries" -Endpoint {
        $SiteHost = $Cache:ConnectionInfo.Server
        $SiteCode = $Cache:ConnectionInfo.SiteCode
        $query = "SELECT DISTINCT
dbo.vSMS_Boundary.DisplayName,
dbo.vSMS_Boundary.BoundaryID,
dbo.vSMS_Boundary.Value AS BValue,
CASE
    WHEN BoundaryType = 0 THEN 'IP Subnet'
    WHEN BoundaryType = 1 THEN 'Active Directory Site'
    WHEN BoundaryType = 2 THEN 'IPv6 Prefix'
    WHEN BoundaryType = 3 THEN 'IP Address Range'
    ELSE 'UnKnown'
    END AS BoundaryType,
CASE
    WHEN BoundaryFlags = 0 THEN 'Fast'
    WHEN BoundaryFlags = 1 THEN 'Slow'
    END AS BoundaryFlags,
dbo.vSMS_Boundary.CreatedBy,
dbo.vSMS_Boundary.CreatedOn,
dbo.vSMS_Boundary.ModifiedBy,
dbo.vSMS_Boundary.ModifiedOn,
dbo.vSMS_BoundaryGroupMembers.GroupID,
dbo.vSMS_BoundaryGroup.Name AS BGName
FROM
dbo.vSMS_Boundary INNER JOIN
dbo.vSMS_BoundaryGroupMembers ON
dbo.vSMS_Boundary.BoundaryID = dbo.vSMS_BoundaryGroupMembers.BoundaryID
INNER JOIN
dbo.vSMS_BoundaryGroup ON
dbo.vSMS_BoundaryGroupMembers.GroupID = dbo.vSMS_BoundaryGroup.GroupID
ORDER BY DisplayName"

        Invoke-DbaQuery -SqlInstance $SiteHost -Database "CM_$SiteCode" -Query $query |
            Select DisplayName,BoundaryID,BoundaryType,BoundaryFlags,BGName | Out-UDGridData
    }
}

SELECT DISTINCT
    sb.DisplayName,
    sb.BoundaryID,
    sb.Value AS BValue,
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
    sb.CreatedBy,
    sb.CreatedOn,
    sb.ModifiedBy,
    sb.ModifiedOn,
    bgm.GroupID,
    bg.Name AS BGName
FROM
    dbo.vSMS_Boundary AS sb INNER JOIN
    dbo.vSMS_BoundaryGroupMembers AS bgm ON sb.BoundaryID = bgm.BoundaryID INNER JOIN
    dbo.vSMS_BoundaryGroup AS bg ON bgm.GroupID = bg.GroupID
ORDER BY
    sb.DisplayName
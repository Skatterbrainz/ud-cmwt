SELECT DISTINCT
    Name as DisplayName,
    GroupID as BGroupID,
    Description,
    Flags,
    DefaultSiteCode,
    CreatedOn,
    MemberCount as Boundaries,
    SiteSystemCount as SiteSystems
FROM
    dbo.vSMS_BoundaryGroup
ORDER BY
    Name
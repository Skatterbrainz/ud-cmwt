SELECT
    cm.Name AS ComputerName,
    cm.ResourceID,
    cm.CollectionID,
    sys.Client_Version0 AS ClientVersion,
    sys.Operating_System_Name_and0 AS OSName,
    sys.Build01 AS OSBuild,
    sys.AD_Site_Name0 AS ADSiteName,
    cs.Model0 AS Model
FROM
    v_ClientCollectionMembers AS cm INNER JOIN
    v_R_System AS sys ON cm.ResourceID = sys.ResourceID LEFT OUTER JOIN
    v_GS_COMPUTER_SYSTEM AS cs ON cm.ResourceID = cs.ResourceID
ORDER BY
    cm.Name
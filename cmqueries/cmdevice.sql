SELECT DISTINCT
    sys.ResourceID,
    sys.Name0 AS Name,
    CASE WHEN (sys.Client0 = 1) THEN 'Yes' ELSE 'No' END AS Client,
    sys.Client_Version0 AS ClientVersion,
    sys.AD_Site_Name0 AS ADSiteName,
    sys.Operating_System_Name_and0 AS OSName,
    sys.Build01 AS OSBuild, ws.UserName,
    ws.LastHardwareScan AS LastHwScan,
    ws.LastDDR,
    ws.LastPolicyRequest AS LastPolicyReq,
    ws.LastMPServerName AS LastMP,
    ws.IsVirtualMachine AS IsVM,
    cs.Manufacturer0 AS Manufacturer,
    cs.Model0 AS Model,
    se.SerialNumber0 AS SerialNumber,
    se.ChassisTypes0 AS ChassisType,
    ws.LastHealthEvaluationResult as LastHealthEval,
    ws.SystemType,
    cs.NumberOfProcessors0 AS Processors
FROM
    v_R_System AS sys LEFT OUTER JOIN
    v_GS_PHYSICAL_MEMORY AS pm ON sys.ResourceID = pm.ResourceID LEFT OUTER JOIN
    v_GS_SYSTEM_ENCLOSURE AS se ON sys.ResourceID = se.ResourceID LEFT OUTER JOIN
    v_GS_COMPUTER_SYSTEM AS cs ON sys.ResourceID = cs.ResourceID LEFT OUTER JOIN
    vWorkstationStatus AS ws ON sys.ResourceID = ws.ResourceID
ORDER BY sys.Name0
SELECT distinct
    sys.Name0 AS ComputerName,
    sys.ResourceID,
    uss.LastScanState,
    uss.LastScanTime,
    uss.LastStatusMessageID,
    uss.LastErrorCode,
    uss.LastWUAVersion,
    sys.AD_Site_Name0 AS ADSiteName,
    sys.Operating_System_Name_and0 AS OSName,
    sys.Build01 AS OSBuild,
    cs.Manufacturer0 AS Manufacturer,
    cs.Model0 AS Model,
    nac.MACAddress0 AS MAC,
    nac.IPAddress0 AS IPAddress
FROM
    v_UpdateScanStatus AS uss INNER JOIN
    v_R_System AS sys ON uss.ResourceID = sys.ResourceID LEFT OUTER JOIN
    v_GS_NETWORK_ADAPTER_CONFIGURATION AS nac ON uss.ResourceID = nac.ResourceID LEFT OUTER JOIN
    v_GS_COMPUTER_SYSTEM AS cs ON uss.ResourceID = cs.ResourceID
WHERE (uss.LastErrorCode <> 0) AND (nac.IPEnabled0 = 1)
ORDER BY ComputerName
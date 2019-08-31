SELECT
    sys.ResourceID,
    sys.Name0 as ComputerName,
    os.Caption0 as OSName,
    os.Version0 as OSVersion,
    os.BuildNumber0 as OSBuild,
    os.OSArchitecture0 as Architecture,
    case
        when (sys.Client0 = 1) then 'Yes'
        else 'No' end as Client,
    ws.ClientVersion,
    ws.LastHardwareScan as LastHwInv,
    sys.AD_Site_Name0 as ADSiteName,
    cs.Manufacturer0 as Manufacturer,
    cs.Model0 as Model,
    ws.LastDDR, ws.LastPolicyRequest AS LastPolicyReq,
    ws.LastMPServerName AS LastMP,
    ws.IsVirtualMachine AS IsVM,
    se.SerialNumber0 as SerialNum
FROM
    v_R_System AS sys LEFT OUTER JOIN
    v_GS_SYSTEM_ENCLOSURE AS se ON sys.ResourceID = se.ResourceID LEFT OUTER JOIN
    v_GS_COMPUTER_SYSTEM AS cs ON sys.ResourceID = cs.ResourceID LEFT OUTER JOIN
    v_GS_OPERATING_SYSTEM AS os ON sys.ResourceID = os.ResourceID LEFT OUTER JOIN
    vWorkstationStatus AS ws ON sys.ResourceID = ws.ResourceID
ORDER BY sys.Name0
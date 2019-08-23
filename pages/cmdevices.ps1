New-UDPage -Name "CMDevices" -Icon desktop -Content {
	New-UDGrid -Title "Configuration Manager Devices" -Endpoint {
        $SiteHost = $Cache:ConnectionInfo.Server
        $SiteCode = $Cache:ConnectionInfo.SiteCode
        $query = "SELECT DISTINCT 
sys.ResourceID, sys.Name0 AS Name, 
case when (sys.Client0 = 1) then 'Yes'
else 'No' end as Client, 
sys.Client_Version0 AS ClientVersion, 
sys.AD_Site_Name0 AS ADSiteName, 
sys.Operating_System_Name_and0 AS OSName, 
sys.Build01 as OSBuild,
ws.UserName, 
ws.LastHardwareScan AS LastHwScan, 
ws.LastDDR, ws.LastPolicyRequest AS LastPolicyReq, 
ws.LastMPServerName AS LastMP, ws.IsVirtualMachine AS IsVM, cs.Manufacturer0 AS Manufacturer, 
cs.Model0 AS Model, se.SerialNumber0 AS SerialNumber
FROM dbo.v_R_System AS sys LEFT OUTER JOIN
dbo.v_GS_SYSTEM_ENCLOSURE AS se ON sys.ResourceID = se.ResourceID LEFT OUTER JOIN
dbo.v_GS_COMPUTER_SYSTEM AS cs ON sys.ResourceID = cs.ResourceID LEFT OUTER JOIN
dbo.vWorkstationStatus AS ws ON sys.ResourceID = ws.ResourceID
order by sys.Name0"
        Invoke-DbaQuery -SqlInstance $SiteHost -Database "CM_$SiteCode" -Query $query | 
            Select Name,OSName,OSBuild,Client,ADSiteName,Model | Out-UDGridData
    }
}

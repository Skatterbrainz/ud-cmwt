SELECT DISTINCT
    sda.DeviceName,
	sda.ResourceID,
	sys.User_Name0 as LastUser,
	case
		when (sda.IsCompliant = 1) then 'Yes'
		else 'No' end as IsCompliant,
	sda.AssignmentName,
	sda.AssignmentID,
	sda.AssignmentUniqueID,
	sda.CollectionName,
	sda.CollectionID,
    sda.LastEnforcementErrorID,
	sda.StatusInfo,
	sda.StatusErrorCode,
	sda.StatusStateID,
    sda.StatusDescription,
	sda.StatusTime,
	sys.AD_Site_Name0 AS ADSiteName,
    sys.Operating_System_Name_and0 AS OSName,
	sys.Build01 AS OSBuild,
	nac.MACAddress0 AS MAC,
	nac.IPAddress0 AS IPAddress
FROM vSMS_SUMDeploymentStatusPerAsset AS sda INNER JOIN
    v_R_System sys ON sda.ResourceID = sys.ResourceID LEFT OUTER JOIN
    v_GS_NETWORK_ADAPTER_CONFIGURATION AS nac ON sda.ResourceID = nac.ResourceID LEFT OUTER JOIN
    v_GS_COMPUTER_SYSTEM AS cs ON sda.ResourceID = cs.ResourceID
WHERE (nac.IPEnabled0 = 1)
ORDER BY sda.DeviceName
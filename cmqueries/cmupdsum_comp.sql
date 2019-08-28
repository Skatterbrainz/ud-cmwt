SELECT DISTINCT
	sda.AssignmentName,
	case
		when (sda.IsCompliant = 1) then 'Yes'
		else 'No' end as Compliant,
	COUNT(*) as Clients
FROM vSMS_SUMDeploymentStatusPerAsset AS sda
GROUP BY AssignmentName,IsCompliant
ORDER BY sda.AssignmentName
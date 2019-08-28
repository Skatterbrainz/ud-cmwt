/*
 http://eskonr.com/2017/07/sccm-configmgr-get-count-of-software-updates-with-its-severity-criticalimportantmoderate-and-low/
 following DROP statement requires SQL Server 2016 or later
*/
DROP TABLE IF EXISTS T1;

SELECT
DISTINCT [CI_ID], COUNT(*) AS Required
INTO T1
FROM v_UpdateState_Combined as uc
WHERE stateid = 2
GROUP BY CI_ID

SELECT DISTINCT
	ui.Title,
	ui.Description,
	ui.InfoURL,
	t1.Required,
	ui.DatePosted,
	ui.DateRevised,
	case
		when (ui.Severity = 2) then 'Low'
		when (ui.Severity = 6) then 'Moderate'
		when (ui.Severity = 8) then 'Important'
		when (ui.Severity = 10) then 'Critical'
		else 'None'
		end as Severity,
	ui.ArticleID,
	case when (ui.IsDeployed = 1) then 'Yes' else 'No' end as Deployed,
	ui.EffectiveDate,
	case when (ui.IsSuperseded = 1) then 'Yes' else 'No' end as Superseded,
	case when (ui.IsExpired = 1) then 'Yes' else 'No' end as Expired
FROM
	dbo.v_UpdateInfo as ui INNER JOIN
	T1 on T1.CI_ID = ui.CI_ID

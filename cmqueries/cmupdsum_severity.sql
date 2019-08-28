/*
thanks to Eswar Koneti...
http://eskonr.com/2017/07/sccm-configmgr-get-count-of-software-updates-with-its-severity-criticalimportantmoderate-and-low/
*/
;with cte as (select
    CI_ID,
    BulletinID,
    ArticleID,
    Title,
    DatePosted,
    DateRevised,
	case when (isExpired = 0) then 'No' else 'Yes' end as IsExpired,
	case when (isSuperseded = 0) then 'No' else 'Yes' end as IsSuperseded,
    CI_UniqueID,
        case
        when (ui.severity=0 and ui.CustomSeverity=0) or ui.severity is null then 'None'
        when ui.CustomSeverity=6 then 'Moderate'
        when ui.CustomSeverity=8 then 'Important'
        when ui.CustomSeverity=10 then 'Critical'
        when ui.CustomSeverity=2 then 'Low'
        when ui.Severity=2 and ui.CustomSeverity=0 then 'Low'
        when ui.Severity=6 and ui.CustomSeverity=0  then 'Moderate'
        when ui.Severity=8 and ui.CustomSeverity=0  then 'Important'
        when ui.Severity=10 and ui.CustomSeverity=0  then 'Critical'
        end as 'Severity'
    from v_UpdateInfo ui
where
   ui.title not like '%Itanium%'
)
select Severity, count(*) [Count]
from cte
group by Severity
order by [Count] desc
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
		when (ui.severity=0 and ui.CustomSeverity=0) or ui.severity is null then '0 None'
		when ui.CustomSeverity=6 then '6 Moderate'
		when ui.CustomSeverity=8 then '8 Important'
		when ui.CustomSeverity=10 then '10 Critical'
		when ui.CustomSeverity=2 then '2 Low'
		when ui.Severity=2 and ui.CustomSeverity=0 then '2 Low'
		when ui.Severity=6 and ui.CustomSeverity=0  then '6 Moderate'
		when ui.Severity=8 and ui.CustomSeverity=0  then '8 Important'
		when ui.Severity=10 and ui.CustomSeverity=0  then '10 Critical'
		end as 'Severity'
    from v_UpdateInfo ui
Where
   ui.title not like '%Itanium%'
)
select IsSuperseded, count(*) [Count]
from cte
group by IsSuperseded
order by IsSuperseded
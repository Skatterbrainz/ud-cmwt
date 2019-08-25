select distinct
    Name,
    CollectionID as ID,Comment,
    membercount as Members
from
    dbo.v_collection
where
    CollectionType = 2
order by Name
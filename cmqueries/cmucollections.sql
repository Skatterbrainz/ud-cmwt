select distinct
    Name,
    CollectionID as ID,Comment,
    membercount as Members
from
    dbo.v_collection
where
    CollectionType = 1
order by
    Name

select distinct
    Name,
    CollectionType,
    CollectionID as ID,
    Comment,
    membercount as Members
from
    dbo.v_collection
order by Name
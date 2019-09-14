SELECT DISTINCT
	coll.CollectionID,
	coll.Name AS CollectionName,
	coll.MemberCount as Members,
	cv.Name AS VariableName,
	cv.Value,
	case when (cv.IsMasked = 1) then 'Yes' else 'No' end as Masked
FROM
	dbo.v_Collection AS coll INNER JOIN
    dbo.v_CollectionVariable AS cv ON coll.CollectionID = cv.CollectionID
ORDER BY CollectionName, VariableName
SELECT DISTINCT
    coll.CollectionID,
    coll.Name AS CollectionName,
    coll.MemberCount,
    crq.RuleName,
    crq.QueryID,
    crq.QueryExpression,
    crq.LimitToCollectionID
FROM
    v_Collection AS coll INNER JOIN
    dbo.v_CollectionRuleQuery AS crq ON coll.CollectionID = crq.CollectionID
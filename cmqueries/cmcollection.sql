SELECT DISTINCT
    CollectionID,
    SiteID,
    CollectionName AS Name,
    CollectionComment AS Comment,
    ResultTableName AS ResultTable,
    LastChangeTime,
    LimitToCollectionID,
    LastRefreshRequest,
    LastRefreshTime,
    LastIncrementalRefreshTime,
    LastMemberChangeTime,
    LimitToCollectionName,
    PowerConfigsCount AS PowerConfigs,
    CollectionVariablesCount AS Variables,
    case when (IsBuiltIn = 1) then 'Yes' else 'No' end as BuiltIn,
    MemberCount AS Members,
    ObjectPath AS ConsolePath,
    ServiceWindowsCount AS ServiceWindows
FROM v_Collections AS c
ORDER BY CollectionName
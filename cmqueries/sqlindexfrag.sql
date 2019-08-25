SELECT
    OBJECT_NAME(ips.OBJECT_ID) AS ObjName,
    i.name as IndexName,
    ips.index_id as IndexID,
    index_type_desc as IndexType,
    ROUND(avg_fragmentation_in_percent, 2) as AvgFragPct,
    ROUND(avg_page_space_used_in_percent, 2) as AvgSpaceUsedPct,
    page_count as PageCount
FROM
    sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'SAMPLED') AS ips INNER JOIN
    sys.indexes AS i ON ips.object_id = i.object_id AND ips.index_id = i.index_id
ORDER BY
    avg_fragmentation_in_percent DESC
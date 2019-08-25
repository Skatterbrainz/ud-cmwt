New-UDPage -Name "SQLIndexFrag" -Id 'sqlindexfrag' -Content {
    New-UDGrid -Title "SQL Server Index Fragmentation: $($Cache:ConnectionInfo.Server)" -Endpoint {
        $SiteHost = $Cache:ConnectionInfo.Server
        $SiteCode = $Cache:ConnectionInfo.SiteCode
        $BasePath = $Cache:ConnectionInfo.BasePath
        $qfile    = Join-Path $BasePath "cmqueries\sqlindexfrag.sql"
        Invoke-DbaQuery -SqlInstance $SiteHost -Database "CM_$SiteCode" -File $qfile |
            Select-Object IndexName,IndexID,IndexType,AvgFragPct,AvgSpaceUsedPct,PageCount | Out-UDGridData
    }
}

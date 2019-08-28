New-UDPage -Name "sqlindexfrag" -Id 'sqlindexfrag' -Content {
    New-UDGrid -Title "SQL Server Index Fragmentation" -Endpoint {
        $qname    = "sqlindexfrag.sql"
        $SiteHost = $Cache:ConnectionInfo.Server
        $Database = $Cache:ConnectionInfo.CmDatabase
		$BasePath = $Cache:ConnectionInfo.QfilePath
		$qfile    = Join-Path $BasePath $qname
        Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -File $qfile |
            Select-Object IndexName,IndexID,IndexType,AvgFragPct,AvgSpaceUsedPct,PageCount | Out-UDGridData
    }
}

New-UDPage -Name "CMSupSynch" -Id 'cmsupsynch' -Content {
	New-UDGrid -Title "Configuration Manager SUP Synchronization Status" -Endpoint {
        $SiteHost = $Cache:ConnectionInfo.Server
        $SiteCode = $Cache:ConnectionInfo.SiteCode
        $BasePath = $Cache:ConnectionInfo.BasePath
        $qfile    = Join-Path $BasePath "cmqueries\cmsupsynch.sql"
        Invoke-DbaQuery -SqlInstance $SiteHost -Database "CM_$SiteCode" -File $qfile |
            Out-UDGridData
    }
}

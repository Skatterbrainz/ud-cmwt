New-UDPage -Name "CMUCollections" -Id 'cmucollections' -Content {
	New-UDGrid -Title "Configuration Manager User Collections" -Endpoint {
        $SiteHost = $Cache:ConnectionInfo.Server
        $SiteCode = $Cache:ConnectionInfo.SiteCode
        $BasePath = $Cache:ConnectionInfo.BasePath
        $qfile    = Join-Path $BasePath "cmqueries\cmucollections.sql"
        Invoke-DbaQuery -SqlInstance $SiteHost -Database "CM_$SiteCode" -File $qfile |
            Select Name,ID,Comment,Members | Out-UDGridData
    }
}

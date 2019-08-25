New-UDPage -Name "CMDCollections" -Id 'cmdcollections' -Content {
	New-UDGrid -Title "Configuration Manager Device Collections" -Endpoint {
        $SiteHost = $Cache:ConnectionInfo.Server
        $SiteCode = $Cache:ConnectionInfo.SiteCode
		$BasePath = $Cache:ConnectionInfo.BasePath
		$qfile    = Join-Path $BasePath "cmqueries\cmdcollections.sql"
        Invoke-DbaQuery -SqlInstance $SiteHost -Database "CM_$SiteCode" -File $qfile |
            Select Name,ID,Type,Comment,Members | Out-UDGridData
    }
}

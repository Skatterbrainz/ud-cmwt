New-UDPage -Name "CMDepSummary" -Id 'cmdepsummary' -Content {
	New-UDGrid -Title "Configuration Manager Deployment Summaries" -Endpoint {
        $SiteHost = $Cache:ConnectionInfo.Server
        $SiteCode = $Cache:ConnectionInfo.SiteCode
		$BasePath = $Cache:ConnectionInfo.BasePath
		$qfile    = Join-Path $BasePath "cmqueries\cmdepsummary.sql"
        Invoke-DbaQuery -SqlInstance $SiteHost -Database "CM_$SiteCode" -File $qfile |
            Select-Object SoftwareName,CollectionName,FeatureType,Total,Success,Failed,InProgress,Unknown,Other |
                Out-UDGridData
    }
}

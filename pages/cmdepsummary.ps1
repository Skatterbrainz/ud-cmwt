New-UDPage -Name "CMDepSummary" -Id 'cmdepsummary' -Content {
	New-UDGrid -Title "Configuration Manager Deployment Summaries" -Endpoint {
        $qname    = "cmdepsummary.sql"
        $SiteHost = $Cache:ConnectionInfo.Server
        $Database = $Cache:ConnectionInfo.CmDatabase
		$BasePath = $Cache:ConnectionInfo.QfilePath
		$qfile    = Join-Path $BasePath $qname
        Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -File $qfile |
            Out-UDGridData
    }
}

New-UDPage -Name "cmsupsynch" -Id 'cmsupsynch' -Content {
	New-UDGrid -Title "Configuration Manager SUP Synchronization Status" -Endpoint {
        $qname    = "cmsupsynch.sql"
        $SiteHost = $Cache:ConnectionInfo.Server
        $Database = $Cache:ConnectionInfo.CmDatabase
		$BasePath = $Cache:ConnectionInfo.QfilePath
		$qfile    = Join-Path $BasePath $qname
        Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -File $qfile |
            Out-UDGridData
    }
}

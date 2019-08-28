New-UDPage -Name "cmucollections" -Id 'cmucollections' -Content {
	New-UDGrid -Title "Configuration Manager User Collections" -Endpoint {
        $qname    = "cmucollections.sql"
        $SiteHost = $Cache:ConnectionInfo.Server
        $Database = $Cache:ConnectionInfo.CmDatabase
		$BasePath = $Cache:ConnectionInfo.QfilePath
		$qfile    = Join-Path $BasePath $qname
        Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -File $qfile |
            Select-Object Name,ID,Comment,Members | Out-UDGridData
    }
}

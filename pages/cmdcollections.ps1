New-UDPage -Name "cmdcollections" -Id 'cmdcollections' -Content {
	New-UDGrid -Title "Configuration Manager Device Collections" -Endpoint {
        $qname    = "cmdcollections.sql"
        $SiteHost = $Cache:ConnectionInfo.Server
        $Database = $Cache:ConnectionInfo.CmDatabase
		$BasePath = $Cache:ConnectionInfo.QfilePath
		$qfile    = Join-Path $BasePath $qname
        Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -File $qfile |
            Select-Object Name,ID,Type,Comment,Members | Out-UDGridData
    }
}

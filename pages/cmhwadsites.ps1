New-UDPage -Name "cmhwadsites" -Id 'cmhwadsites' -Content {
	New-UDGrid -Title "Configuration Manager Inventory: AD Sites" -Endpoint {
        $qname    = "cmhwadsites.sql"
        $SiteHost = $Cache:ConnectionInfo.Server
        $Database = $Cache:ConnectionInfo.CmDatabase
		$BasePath = $Cache:ConnectionInfo.QfilePath
		$qfile    = Join-Path $BasePath $qname
		Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -File $qfile |
            Select-Object ADSiteName,Devices | Out-UDGridData
    }
}

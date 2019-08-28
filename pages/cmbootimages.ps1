New-UDPage -Name "cmbootimages" -Id 'cmbootimages' -Content {
	New-UDGrid -Title "Configuration Manager Software: Boot Images" -Endpoint {
        $qname    = "cmpackages.sql"
        $SiteHost = $Cache:ConnectionInfo.Server
        $Database = $Cache:ConnectionInfo.CmDatabase
		$BasePath = $Cache:ConnectionInfo.QfilePath
		$qfile    = Join-Path $BasePath $qname
		Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -File $qfile |
			Where-Object PackageType -eq 258 |
				Select-Object Name,PackageID,Version,Description | Out-UDGridData
    }
}

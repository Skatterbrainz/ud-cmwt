New-UDPage -Name "cmosimages" -Id 'cmosimages' -Content {
	New-UDGrid -Title "Configuration Manager Software: OS Images" -Endpoint {
        $qname    = "cmpackages.sql"
        $SiteHost = $Cache:ConnectionInfo.Server
        $Database = $Cache:ConnectionInfo.CmDatabase
		$BasePath = $Cache:ConnectionInfo.QfilePath
		$qfile    = Join-Path $BasePath $qname
		Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -File $qfile |
			Where-Object PackageType -eq 257 |
				Select-Object Name,PackageID,Version,Description | Out-UDGridData
    }
}

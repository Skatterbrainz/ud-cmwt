New-UDPage -Name "cmupdatepkgs" -Id 'cmupdatepkgs' -Content {
	New-UDGrid -Title "Configuration Manager Software: Software Update Packages" -Endpoint {
        $qname    = "cmpackages.sql"
        $SiteHost = $Cache:ConnectionInfo.Server
        $Database = $Cache:ConnectionInfo.CmDatabase
		$BasePath = $Cache:ConnectionInfo.QfilePath
		$qfile    = Join-Path $BasePath $qname
        Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -File $qfile |
			Where-Object PackageType -eq 5 |
                Select-Object Name,PackageID,Version,Description | Out-UDGridData
    }
}

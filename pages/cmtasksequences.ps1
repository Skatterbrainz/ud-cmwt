New-UDPage -Name "cmtasksequences" -Id 'cmtasksequences' -Content {
	New-UDGrid -Title "Configuration Manager Software: Task Sequences" -Endpoint {
        $qname    = "cmpackages.sql"
        $SiteHost = $Cache:ConnectionInfo.Server
        $Database = $Cache:ConnectionInfo.CmDatabase
		$BasePath = $Cache:ConnectionInfo.QfilePath
		$qfile    = Join-Path $BasePath $qname
        Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -File $qfile |
			Where-Object PackageType -eq 4 |
                Select-Object Name,PackageID,Description | Out-UDGridData
    }
}

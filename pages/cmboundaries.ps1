New-UDPage -Name "cmboundaries" -Content {
	New-UDGrid -Title "Configuration Manager Site Boundaries" -Endpoint {
        $qname    = "cmboundaries.sql"
        $SiteHost = $Cache:ConnectionInfo.Server
        $Database = $Cache:ConnectionInfo.CmDatabase
		$BasePath = $Cache:ConnectionInfo.QfilePath
		$qfile    = Join-Path $BasePath $qname
        Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -File $qfile |
            Select-Object DisplayName,BoundaryID,BoundaryType,BoundaryFlags,BGName | Out-UDGridData
    }
}

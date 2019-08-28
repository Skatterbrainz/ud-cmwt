New-UDPage -Name "cmboundarygroups" -Id 'cmboundarygroups' -Content {
	New-UDGrid -Title "Configuration Manager Boundary Groups" -Endpoint {
        $qname    = "cmboundarygroups.sql"
        $SiteHost = $Cache:ConnectionInfo.Server
        $Database = $Cache:ConnectionInfo.CmDatabase
		$BasePath = $Cache:ConnectionInfo.QfilePath
		$qfile    = Join-Path $BasePath $qname
        Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -File $qfile |
            Select-Object DisplayName,BGroupID,Description,Boundaries,SiteSystems | Out-UDGridData
    }
}

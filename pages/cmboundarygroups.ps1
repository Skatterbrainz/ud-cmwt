New-UDPage -Name "CMBoundaryGroups" -Id 'cmboundarygroups' -Content {
	New-UDGrid -Title "Configuration Manager Boundary Groups" -Endpoint {
        $SiteHost = $Cache:ConnectionInfo.Server
        $SiteCode = $Cache:ConnectionInfo.SiteCode
        $BasePath = $Cache:ConnectionInfo.BasePath
        $qfile    = Join-Path $BasePath "cmqueries\cmboundarygroups.sql"
        Invoke-DbaQuery -SqlInstance $SiteHost -Database "CM_$SiteCode" -File $qfile |
            Select-Object DisplayName,BGroupID,Description,Boundaries,SiteSystems | Out-UDGridData
    }
}

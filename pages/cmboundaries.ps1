New-UDPage -Name "CMBoundaries" -Id 'cmboundaries' -Content {
	New-UDGrid -Title "Configuration Manager Site Boundaries" -Endpoint {
        $SiteHost = $Cache:ConnectionInfo.Server
        $SiteCode = $Cache:ConnectionInfo.SiteCode
        $BasePath = $Cache:ConnectionInfo.BasePath
        $qfile    = Join-Path $BasePath "cmqueries\cmboundaries.sql"
        Invoke-DbaQuery -SqlInstance $SiteHost -Database "CM_$SiteCode" -File $qfile |
            Select-Object DisplayName,BoundaryID,BoundaryType,BoundaryFlags,BGName | Out-UDGridData
    }
}

New-UDPage -Name "cmboundarygroups" -Content {
	New-UDGrid -Title "Configuration Manager Boundary Groups" -Endpoint {
        Get-CmwtDbQuery -QueryName "cmboundarygroups" |
            Select-Object DisplayName,BGroupID,Description,Boundaries,SiteSystems | Out-UDGridData
    }
}

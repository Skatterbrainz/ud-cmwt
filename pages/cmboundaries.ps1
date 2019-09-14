New-UDPage -Name "cmboundaries" -Content {
	New-UDGrid -Title "Configuration Manager Site Boundaries" -Endpoint {
        Get-CmwtDbQuery -QueryName "cmboundaries" |
            Select-Object DisplayName,BoundaryID,BoundaryType,BoundaryFlags -Unique | Out-UDGridData
    }
}

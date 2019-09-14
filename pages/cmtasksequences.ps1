New-UDPage -Name "cmtasksequences" -Content {
	New-UDGrid -Title "Configuration Manager Software: Task Sequences" -Endpoint {
        Get-CmwtDbQuery -QueryName "cmpackages" |
			Where-Object PackageType -eq 4 |
                Select-Object Name,PackageID,Description | Out-UDGridData
    }
}

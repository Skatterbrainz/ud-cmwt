New-UDPage -Name "cmdepsummary" -Content {
	New-UDGrid -Title "Configuration Manager Deployment Summaries" -Endpoint {
        Get-CmwtDbQuery -QueryName "cmdepsummary" | Out-UDGridData
    }
}

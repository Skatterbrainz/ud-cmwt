New-UDPage -Name "cmhwmodels" -Content {
	New-UDGrid -Title "Configuration Manager Inventory: Device Models" -Endpoint {
        Get-CmwtDbQuery -QueryName "cmhwmodels" |
            Select-Object Model,Devices | Out-UDGridData
    }
}

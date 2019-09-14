New-UDPage -Name "cmhwdhcp" -Content {
	New-UDGrid -Title "Configuration Manager Inventory: DHCP Servers" -Endpoint {
        Get-CmwtDbQuery -QueryName "cmhwdhcp" |
            Select-Object Model,Devices | Out-UDGridData
    }
}

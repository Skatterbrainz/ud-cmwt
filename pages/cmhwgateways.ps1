New-UDPage -Name "cmhwgateways" -Content {
	New-UDGrid -Title "Configuration Manager Inventory: IP Gateways" -Endpoint {
        Get-CmwtDbQuery -QueryName "cmhwgateways" |
            Select-Object IPGateway,Devices | Out-UDGridData
    }
}

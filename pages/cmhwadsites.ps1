New-UDPage -Name "cmhwadsites" -Content {
	New-UDGrid -Title "Configuration Manager Inventory: AD Sites" -Endpoint {
		Get-CmwtDbQuery -QueryName "cmhwadsites" |
            Select-Object ADSiteName,Devices | Out-UDGridData
    }
}

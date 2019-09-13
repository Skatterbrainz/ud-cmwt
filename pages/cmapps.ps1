New-UDPage -Name "cmapps" -Content {
	New-UDGrid -Title "Configuration Manager Software: Applications" -Endpoint {
		Get-CmwtDbQuery -QueryName "cmpackages" |
			Where-Object PackageType -eq 8 |
	           	Select-Object Name,PackageID,Version,Description | Out-UDGridData
    }
}

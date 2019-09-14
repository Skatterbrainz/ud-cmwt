New-UDPage -Name "cmbootimages" -Content {
	New-UDGrid -Title "Configuration Manager Software: Boot Images" -Endpoint {
		Get-CmwtDbQuery -QueryName "cmpackages" |
			Where-Object PackageType -eq 258 |
				Select-Object Name,PackageID,Version,Description | Out-UDGridData
    }
}

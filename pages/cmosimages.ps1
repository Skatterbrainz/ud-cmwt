New-UDPage -Name "cmosimages" -Content {
	New-UDGrid -Title "Configuration Manager Software: OS Images" -Endpoint {
		Get-CmwtDbQuery -QueryName "cmpackages" |
			Where-Object PackageType -eq 257 |
				Select-Object Name,PackageID,Version,Description | Out-UDGridData
    }
}

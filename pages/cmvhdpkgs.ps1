New-UDPage -Name "cmvhdpkgs" -Content {
	New-UDGrid -Title "Configuration Manager VHD Packages" -Endpoint {
		Get-CmwtDbQuery -QueryName "cmpackages" |
			Where-Object PackageType -eq 260 |
            	Select-Object Name,PackageID,Version,Description | Out-UDGridData
    }
}

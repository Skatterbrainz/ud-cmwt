New-UDPage -Name "cmupdatepkgs" -Content {
	New-UDGrid -Title "Configuration Manager Software: Software Update Packages" -Endpoint {
        Get-CmwtDbQuery -QueryName "cmpackages" |
			Where-Object PackageType -eq 5 |
                Select-Object Name,PackageID,Version,Description | Out-UDGridData
    }
}

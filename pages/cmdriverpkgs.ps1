New-UDPage -Name "cmdriverpkgs" -Content {
	New-UDGrid -Title "Configuration Manager Software: Driver Packages" -Endpoint {
        Get-CmwtDbQuery -QueryName "cmpackages" |
			Where-Object PackageType -eq 3 |
	           	Select-Object Name,PackageID,Version,Description | Out-UDGridData
    }
}

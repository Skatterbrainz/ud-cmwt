New-UDPage -Name "cmosupgrades" -Content {
	New-UDGrid -Title "Configuration Manager Software: OS Upgrade Packages" -Endpoint {
        Get-CmwtDbQuery -QueryName "cmpackages" |
			Where-Object PackageType -eq 259 |
				Select-Object Name,PackageID,Version,Description | Out-UDGridData
    }
}

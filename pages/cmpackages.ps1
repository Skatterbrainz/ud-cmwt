New-UDPage -Name "cmpackages" -Content {
	New-UDGrid -Title "Configuration Manager Software: Packages" -Endpoint {
		Get-CmwtDbQuery -QueryName "cmpackages" |
        	Where-Object PackageType -eq 0 | Foreach-Object {
				$name  = [string]$_.Name
				$pkgid = [string]$_.PackageID
				[pscustomobject]@{
					Name        = New-UDElement -Tag "a" -Attributes @{ href="/cmpackage/$pkgid/1" } -Content { $name }
					PackageID   = $pkgid
					Version     = [string]$_.Version
					Description = [string]$_.Description
				}
			} | Out-UDGridData
    }
}

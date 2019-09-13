New-UDPage -Name "cmsitestatus" -Content {
	New-UDGrid -Title "Configuration Manager Site Status" -Endpoint {
		Get-CmwtDbQuery -QueryName "cmsitestatus" | Foreach-Object {
			$sysname = (([string]$_.SiteSystem) -split '\\')[2]
			[pscustomobject]@{
				SiteSystem   = [string]$sysname.ToLower()
				Role         = [string]$_.Role
				SiteStatus   = [string]$_.SiteStatus
				Availability = [string]$_.Availability
				TimeReported = [string]$_.TimeReported
			}
		} | Out-UDGridData
    }
}

New-UDPage -Name "CMSiteStatus" -Id 'cmsitestatus' -Content {
	New-UDGrid -Title "Configuration Manager Site Status" -Endpoint {
		$SiteHost = $Cache:ConnectionInfo.Server
		$SiteCode = $Cache:ConnectionInfo.SiteCode
		$BasePath = $Cache:ConnectionInfo.BasePath
		$qfile    = Join-Path $BasePath "cmqueries\cmsitestatus.sql"
		Invoke-DbaQuery -SqlInstance $SiteHost -Database "CM_$SiteCode" -File $qfile | Foreach-Object {
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

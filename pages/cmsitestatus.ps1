New-UDPage -Name "cmsitestatus" -Id 'cmsitestatus' -Content {
	New-UDGrid -Title "Configuration Manager Site Status" -Endpoint {
        $qname    = "cmsitestatus.sql"
        $SiteHost = $Cache:ConnectionInfo.Server
        $Database = $Cache:ConnectionInfo.CmDatabase
		$BasePath = $Cache:ConnectionInfo.QfilePath
		$qfile    = Join-Path $BasePath $qname
		Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -File $qfile | Foreach-Object {
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

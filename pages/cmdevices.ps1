New-UDPage -Name "cmdevices" -Id 'cmdevices' -Content {
	New-UDGrid -Title "Configuration Manager Devices" -Endpoint {
        $qname    = "cmdevices.sql"
        $SiteHost = $Cache:ConnectionInfo.Server
        $Database = $Cache:ConnectionInfo.CmDatabase
		$BasePath = $Cache:ConnectionInfo.QfilePath
		$qfile    = Join-Path $BasePath $qname
        Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -File $qfile | Foreach-Object {
            $resid = [string]$_.ResourceID
            $name  = [string]$_.Name
            [pscustomobject]@{
                Name    = New-UDElement -Tag "a" -Attributes @{ href="/cmdevice/$resid/1" } -Content { $name }
                ResourceID = $resid
                OSName  = [string]$_.OSName
                OSBuild = [string]$_.OSBuild
                Client  = [string]$_.ClientVersion
                ADSite  = [string]$_.ADSiteName
                Model   = [string]$_.Model
            }
        } | Out-UDGridData
    }
}

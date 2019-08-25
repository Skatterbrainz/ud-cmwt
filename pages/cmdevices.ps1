New-UDPage -Name "CMDevices" -Id 'cmdevices' -Content {
	New-UDGrid -Title "Configuration Manager Devices" -Endpoint {
        $SiteHost = $Cache:ConnectionInfo.Server
        $SiteCode = $Cache:ConnectionInfo.SiteCode
        $BasePath = $Cache:ConnectionInfo.BasePath
        $qfile    = Join-Path $BasePath "cmqueries\cmusers.sql"
        Invoke-DbaQuery -SqlInstance $SiteHost -Database "CM_$SiteCode" -File $qfile |
            Select-Object Name,OSName,OSBuild,Client,ADSiteName,Model | Out-UDGridData
    }
}

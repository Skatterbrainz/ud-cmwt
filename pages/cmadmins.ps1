New-UDPage -Name "CMAdmins" -Icon app_store -Content {
	New-UDGrid -Title "Configuration Manager Site Administrators" -Endpoint {
        $SiteHost = $Cache:ConnectionInfo.Server
        $SiteCode = $Cache:ConnectionInfo.SiteCode
        $BasePath = $Cache:ConnectionInfo.BasePath
        $qfile    = Join-Path $BasePath "cmqueries\cmusers.sql"
        Invoke-DbaQuery -SqlInstance $SiteHost -Database "CM_$SiteCode" -File $qfile |
            Out-UDGridData
    }
}

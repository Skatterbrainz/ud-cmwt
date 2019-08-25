New-UDPage -Name "CMCompStatus" -Id 'cmcompstatus' -Content {
	New-UDGrid -Title "Configuration Manager Component Status" -Endpoint {
        $SiteHost = $Cache:ConnectionInfo.Server
        $SiteCode = $Cache:ConnectionInfo.SiteCode
        $BasePath = $Cache:ConnectionInfo.BasePath
        $qfile    = Join-Path $BasePath "cmqueries\cmcompstatus.sql"
        Invoke-DbaQuery -SqlInstance $SiteHost -Database "CM_$SiteCode" -File $qfile |
            Select-Object ComponentName,Status,State,Info,Warning,Error,LastContacted |
                Out-UDGridData
    }
}

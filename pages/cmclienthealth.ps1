New-UDPage -Name "cmclienthealth" -Title "ConfigMgr Client Health" -Content {
    New-UDGrid -Id 'grid1' -Title "Software Updates Scan Exceptions" -Endpoint {
        $SiteHost = $Cache:ConnectionInfo.Server
        $Database = $Cache:ConnectionInfo.CmDatabase
        $BasePath = $Cache:ConnectionInfo.BasePath
        $qfile = Join-Path $BasePath "cmqueries\cmclientscans.sql"
        Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -File $qfile |
            Out-UDGridData
    }
    New-UDGrid -Id 'grid2' -Title "" -Endpoint {
        
    }
}
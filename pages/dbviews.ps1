New-UDPage -Name "dbviews" -Id 'dbviews' -Content {
    New-UDGrid -Title "SQL Database Views: CM_$SiteCode" -Endpoint {
        $SiteHost = $Cache:ConnectionInfo.Server
        $Database = $Cache:ConnectionInfo.CmDatabase
        Get-DbaDbView -SqlInstance $SiteHost -Database $Database |
            Select-Object Name,Owner,CreateDate,DateLastModified | Out-UDGridData
    }
}

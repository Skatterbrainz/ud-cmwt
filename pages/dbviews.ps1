New-UDPage -Name "DBViews" -Id 'cbviews' -Content {
    New-UDGrid -Title "SQL Database Views: CM_$SiteCode" -Endpoint {
        $SiteHost = $Cache:ConnectionInfo.Server
        $SiteCode = $Cache:ConnectionInfo.SiteCode
        Get-DbaDbView -SqlInstance $SiteHost -Database "CM_$SiteCode" |
            Select-Object Name,Owner,CreateDate,DateLastModified | Out-UDGridData
    }
}

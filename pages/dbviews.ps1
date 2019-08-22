New-UDPage -Name "SQL Database Views" -Icon database -Content {
    New-UDGrid -Title "SQL Database Views: CM_$SiteCode" -Endpoint {
        $SiteHost = $Cache:ConnectionInfo.Server
        $SiteCode = $Cache:ConnectionInfo.SiteCode
        Get-DbaDbView -SqlInstance $SiteHost -Database "CM_$SiteCode" | 
            Select Name,Owner,CreateDate,DateLastModified | Out-UDGridData
    }
}

#Start-UDDashboard -Dashboard $Dashboard -Port 8082 -AutoReload
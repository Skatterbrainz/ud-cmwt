New-UDPage -Name "cmcompstatus" -Id 'cmcompstatus' -Content {
	New-UDGrid -Id 'grid1' -Title "Configuration Manager Component Status" -Endpoint {
        $qname    = "cmcompstatus.sql"
        $SiteHost = $Cache:ConnectionInfo.Server
        $Database = $Cache:ConnectionInfo.CmDatabase
        $qfile    = Join-Path $Cache:ConnectionInfo.QfilePath $qname
        Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -File $qfile |
            Select-Object ComponentName,Status,State,Info,Warning,Error,LastContacted |
                Out-UDGridData
    }
}

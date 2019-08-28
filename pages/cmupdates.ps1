New-UDPage -Name "cmupdates" -Id 'cmupdates' -Content {
    New-UDGrid -Title "Configuration Manager Software: All Software Updates" -Endpoint {
        $qname    = "cmupdsum_all.sql"
        $SiteHost = $Cache:ConnectionInfo.Server
        $Database = $Cache:ConnectionInfo.CmDatabase
        $BasePath = $Cache:ConnectionInfo.QfilePath
        $qfile    = Join-Path $BasePath $qname
        Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -File $qfile |
            Select-Object Title,Severity,Required,DatePosted,DateRevised,ArticleID,Deployed,Expired,Superseded |
                Out-UDGridData
    }
}

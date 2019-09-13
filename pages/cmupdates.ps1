New-UDPage -Name "cmupdates" -Content {
    New-UDGrid -Title "Configuration Manager Software: All Software Updates" -Endpoint {
        Get-CmwtDbQuery -QueryName "cmupdsum_all" |
            Select-Object Title,Severity,Required,DatePosted,DateRevised,ArticleID,Deployed,Expired,Superseded |
                Out-UDGridData
    }
}

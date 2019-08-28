New-UDPage -Name "cmupdatecompliance" -Id 'cmupdatecompliance' -Content {
    New-UDGrid -Title "Configuration Manager Software: Software Update Compliance" -Endpoint {
        $qname    = "cmupdatecompliance.sql"
        $SiteHost = $Cache:ConnectionInfo.Server
        $Database = $Cache:ConnectionInfo.CmDatabase
        $BasePath = $Cache:ConnectionInfo.QfilePath
        $qfile    = Join-Path $BasePath $qname
        Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -File $qfile |
            Select-Object AssignmentName,DeviceName,ResourceID,IsCompliant,CollectionName |
                Out-UDGridData
    }
}

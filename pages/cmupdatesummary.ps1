New-UDPage -Name "cmupdatesummary" -Id 'cmupdatesummary' -Content {
    New-UDCard -Title "Configuration Manager Software: Software Update Summary" -Content {""}
    New-UDRow -Columns {
        New-UDColumn -Endpoint {
            New-UDGrid -Title "Compliance" -Endpoint {
                $qname    = "cmupdsum_comp.sql"
                $SiteHost = $Cache:ConnectionInfo.Server
                $Database = $Cache:ConnectionInfo.CmDatabase
                $BasePath = $Cache:ConnectionInfo.QfilePath
                $qfile    = Join-Path $BasePath $qname
                Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -File $qfile |
                    Select-Object AssignmentName,Compliant,Clients | Out-UDGridData
            }
        } # column
        New-UDColumn -Endpoint {
            New-UDGrid -Title "Severity" -Endpoint {
                $qname    = "cmupdsum_severity.sql"
                $SiteHost = $Cache:ConnectionInfo.Server
                $Database = $Cache:ConnectionInfo.CmDatabase
                $BasePath = $Cache:ConnectionInfo.QfilePath
                $qfile    = Join-Path $BasePath $qname
                Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -File $qfile |
                    Select-Object Severity,Count | Out-UDGridData
            }
        }
        New-UDColumn -Endpoint {
            New-UDGrid -Title "Superseded" -Endpoint {
                $qname    = "cmupdsum_superseded.sql"
                $SiteHost = $Cache:ConnectionInfo.Server
                $Database = $Cache:ConnectionInfo.CmDatabase
                $BasePath = $Cache:ConnectionInfo.QfilePath
                $qfile    = Join-Path $BasePath $qname
                Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -File $qfile |
                    Select-Object IsSuperseded,Count | Out-UDGridData
            }
        }
        New-UDColumn -Endpoint {
            New-UDGrid -Title "Expired" -Endpoint {
                $qname    = "cmupdsum_expired.sql"
                $SiteHost = $Cache:ConnectionInfo.Server
                $Database = $Cache:ConnectionInfo.CmDatabase
                $BasePath = $Cache:ConnectionInfo.QfilePath
                $qfile    = Join-Path $BasePath $qname
                Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -File $qfile |
                    Select-Object Expired,Count | Out-UDGridData
            }
        } # column
    } # row
}

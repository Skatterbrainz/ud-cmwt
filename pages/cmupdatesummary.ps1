New-UDPage -Name "cmupdatesummary" -Content {
    New-UDCard -Title "Configuration Manager Software: Software Update Summary" -Content {""}
    New-UDRow -Columns {
        New-UDColumn -Endpoint {
            New-UDGrid -Title "Compliance" -Endpoint {
                Get-CmwtDbQuery -QueryName "cmupdsum_comp" |
                    Select-Object AssignmentName,Compliant,Clients | Out-UDGridData
            }
        } # column
        New-UDColumn -Endpoint {
            New-UDGrid -Title "Severity" -Endpoint {
                Get-CmwtDbQuery -QueryName "cmupdsum_severity" |
                    Select-Object Severity,Count | Out-UDGridData
            }
        }
        New-UDColumn -Endpoint {
            New-UDGrid -Title "Superseded" -Endpoint {
                Get-CmwtDbQuery -QueryName"cmupdsum_superseded" |
                    Select-Object IsSuperseded,Count | Out-UDGridData
            }
        }
        New-UDColumn -Endpoint {
            New-UDGrid -Title "Expired" -Endpoint {
                Get-CmwtDbQuery -QueryName "cmupdsum_expired" |
                    Select-Object Expired,Count | Out-UDGridData
            }
        } # column
    } # row
}

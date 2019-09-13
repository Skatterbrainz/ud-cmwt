New-UDPage -Name "cmupdatecompliance" -Content {
    New-UDGrid -Title "Configuration Manager Software: Software Update Compliance" -Endpoint {
        Get-CmwtDbQuery -QueryName "cmupdatecompliance" |
            Select-Object AssignmentName,DeviceName,ResourceID,IsCompliant,CollectionName |
                Out-UDGridData
    }
}

New-UDPage -Name "cmcompstatus" -Content {
	New-UDGrid -Title "Configuration Manager Component Status" -Endpoint {
        Get-CmwtDbQuery -QueryName "cmcompstatus" |
            Select-Object ComponentName,Status,State,Info,Warning,Error,LastContacted |
                Out-UDGridData
    }
}

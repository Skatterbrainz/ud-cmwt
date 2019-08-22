New-UDPage -Name "Processes" -Icon tachometer -Content { 
    New-UDGrid -Title "Processes" -Endpoint {
        Get-Process -ComputerName $Cache:ConnectionInfo.Server | 
            Select ProcessName,Id,Path | Out-UDGridData
    }
}
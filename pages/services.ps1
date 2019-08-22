New-UDPage -Name "Services" -Icon tachometer -Content { 
    New-UDGrid -Title "Services" -Endpoint {
        Get-Service -ComputerName $Cache:ConnectionInfo.Server | 
            Select ServiceName,DisplayName,Status,StartType | Out-UDGridData
    }
}

New-UDPage -Name "Services" -Icon tachometer -Content {
    New-UDGrid -Title "Services" -Endpoint {
        Get-Service -ComputerName $Cache:ConnectionInfo.Server | ForEach-Object {
            [pscustomobject]@{
                DisplayName = [string]$_.DisplayName
                ServiceName = [string]$_.ServiceName
                StartType   = [string]$_.StartType
                Status      = [string]$_.Status
            }
        } | Out-UDGridData
    }
}

New-UDPage -Name "services/:hostname" -Content {
    param ($hostname)
    New-UDGrid -Title "Services" -Endpoint {
        Get-Service -ComputerName $hostname | ForEach-Object {
            [pscustomobject]@{
                DisplayName = [string]$_.DisplayName
                ServiceName = [string]$_.ServiceName
                StartType   = [string]$_.StartType
                Status      = [string]$_.Status
            }
        } | Out-UDGridData
    }
}

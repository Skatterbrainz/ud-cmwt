New-UDPage -Name "processes/:hostname" -Content {
    param ($hostname)
    New-UDGrid -Title "$hostname System Processes" -Endpoint {
        Get-Process -ComputerName $hostname |
            Select-Object ProcessName,Id,Path | Out-UDGridData
    }
}
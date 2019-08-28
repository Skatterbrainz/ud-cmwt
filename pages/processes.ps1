New-UDPage -Name "processes" -Id "processes" -Icon tachometer -Content {
    $SiteHost = $Cache:ConnectionInfo.Server
    New-UDGrid -Title "$SiteHost System Processes" -Endpoint {
        Get-Process -ComputerName $Cache:ConnectionInfo.Server |
            Select-Object ProcessName,Id,Path | Out-UDGridData
    }
}
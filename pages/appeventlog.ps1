New-UDPage -Name "appeventlog" -Icon tachometer -Content {
    New-UDGrid -Title "Windows Application Event Log" -Endpoint {
        Get-WinEvent -Force -ComputerName $Cache:ConnectionInfo.Server -LogName Application -ErrorAction SilentlyContinue |
            Where-Object {$_.LevelDisplayName -ne 'Information'} |
                Select TimeCreated,ID,ProviderName,Message -First 50 | Out-UDGridData
    }
}

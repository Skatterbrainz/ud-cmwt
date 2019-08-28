New-UDPage -Name "syseventlog" -Icon tachometer -Content {
    New-UDGrid -Title "Windows System Event Log" -Endpoint {
        Get-WinEvent -Force -ComputerName $Cache:ConnectionInfo.Server -LogName System -ErrorAction SilentlyContinue |
            Where-Object {$_.LevelDisplayName -ne 'Information'} |
                Select-Object TimeCreated,ID,ProviderName,Message -First 50 | Out-UDGridData
    }
}

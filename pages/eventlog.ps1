New-UDPage -Name "EventLog" -Icon tachometer -Content { 
    New-UDGrid -Title "Windows Event Logs" -Endpoint {
        Get-WinEvent -Force -ComputerName $Cache:ConnectionInfo.Server -LogName System -ErrorAction SilentlyContinue | 
            Where-Object {$_.LevelDisplayName -ne 'Information'} | 
                Select TimeCreated,ID,ProviderName,Message -First 50 | Out-UDGridData
    }
}

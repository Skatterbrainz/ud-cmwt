New-UDPage -Name "syseventlog/:hostname" -Content {
    param ($hostname)
    New-UDGrid -Title "Windows System Event Log" -Endpoint {
        Get-WinEvent -Force -ComputerName $hostname -LogName System -ErrorAction SilentlyContinue |
            Where-Object {$_.LevelDisplayName -ne 'Information'} |
                Select-Object TimeCreated,ID,ProviderName,Message -First 50 | Out-UDGridData
    }
}

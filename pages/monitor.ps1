New-UDPage -Name 'monitor' -Id 'monitor' -Content {
    New-UDCard -Title "Memory Graph" -Content {
        New-UDMonitor -Type Line -Title "Available Memory" -RefreshInterval 1 -DataPointHistory 100 -Endpoint {
            Get-Counter '\Memory\Available MBytes' |
                Select-Object -ExpandProperty CounterSamples |
                    Select-Object -ExpandProperty CookedValue | Out-UDMonitorData
        }
    }
}
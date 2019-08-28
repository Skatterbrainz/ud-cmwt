New-UDPage -Name "sqlservices" -Id 'sqlservices' -Content {
    New-UDGrid -Title "SQL Services: $($Cache:ConnectionInfo.Server)" -Endpoint {
        Get-DbaService -ComputerName $Cache:ConnectionInfo.Server | Foreach-Object {
            [pscustomobject]@{
                DisplayName  = [string]$_.DisplayName
                ComputerName = [string]$_.ComputerName
                ServiceName  = [string]$_.SQLServerReportingServices
                Type         = [string]$_.ServiceType
                Instance     = [string]$_.InstanceName
                Account      = [string]$_.StartName
                State        = [string]$_.State
                StartMode    = [string]$_.StartMode
            }
        } | Out-UDGridData
    }
}

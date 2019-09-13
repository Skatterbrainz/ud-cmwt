New-UDPage -Name "cmclienthealth" -Content {
    New-UDGrid -Title "Software Updates Scan Exceptions" -Endpoint {
        Get-CmwtDbQuery -QueryName "cmclientscans" |
            Out-UDGridData
    }
}

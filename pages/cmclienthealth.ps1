New-UDPage -Name "cmclienthealth" -Content {
    New-UDGrid -Title "ConfigMgr Client Health" -Endpoint {
        Get-CmwtDbQuery -QueryName "cmclienthealthsummary" |
            Select-Object ComputerName,UserName,LastHW,LastSW,HwInvAge,SwInvAge,ClientRemediationSuccess |
                Out-UDGridData
    }
}
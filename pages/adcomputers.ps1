New-UDPage -Name "ADComputers" -Icon desktop -Content {
    New-UDGrid -Title "Active Directory Computers ($env:USERDNSDOMAIN)" -Endpoint {
        Get-ADSIComputer | Select Name,Enabled,LastLogon,LastPasswordSet | Out-UDGridData
    }
}
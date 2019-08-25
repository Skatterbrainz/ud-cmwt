New-UDPage -Name "ADDomain" -ID 'addomain' -Content {
    New-UDGrid -Title "Active Directory Domain" -Endpoint {
        Get-ADSIDomain | Out-UDGridData
    }
}
New-UDPage -Name "adprinters" -Id "adprinters" -Icon desktop -Content {
    New-UDGrid -Title "Active Directory Print Queues ($env:USERDNSDOMAIN)" -Endpoint {
        Get-ADSIPrintQueue -NoResultLimit | Out-UDGridData
    }
}
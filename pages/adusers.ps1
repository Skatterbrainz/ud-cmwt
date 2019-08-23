New-UDPage -Name "ADUsers" -Icon users -Content {
    New-UDGrid -Title "Active Directory Users ($env:USERDNSDOMAIN)" -Endpoint {
        Get-ADSIUser -NoResultLimit | 
            Select DisplayName,SamAccountName,Enabled,UserPrincipalName,Department,Title | Out-UDGridData
    }
}

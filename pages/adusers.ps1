New-UDPage -Name "ADUsers" -Icon users -Content {
    New-UDGrid -Title "Active Directory Users ($env:USERDNSDOMAIN)" -Endpoint {
        Get-ADSIUser -NoResultLimit | Foreach-Object {
            $sam = [string]$_.SamAccountName
            [pscustomobject]@{
                DisplayName    = [string]$_.DisplayName
                SamAccountName = New-UDElement -Tag "a" -Attributes @{ href="/aduser/$sam"} -Content { $sam }
                Enabled    = [string]$_.Enabled
                UPN        = [string]$_.UserPrincipalName
                Department = [string]$_.Department
                Title      = [string]$_.Title
            }
        } | Out-UDGridData
    }
}

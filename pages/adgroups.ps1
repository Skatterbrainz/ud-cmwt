New-UDPage -Name "ADGroups" -Icon users_cog -Content {
    New-UDGrid -Title "Active Directory Security Groups ($env:USERDNSDOMAIN)" -Endpoint {
        Get-ADSIGroup -IsSecurityGroup:$True | Foreach-Object {
            $gsam = $_.SamAccountName
            $mbrs = (Get-ADSIGroupMember -Identity $gsam).Count
            [pscustomobject]@{
                Name    = [string]$_.Name
                Members = [int]$mbrs
                Scope   = [string]$_.ContextType
                Description = [string]$_.Description
            }
        } | Out-UDGridData
    }
}

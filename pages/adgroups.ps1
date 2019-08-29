New-UDPage -Name "adgroups" -Id "adgroups" -Content {
    New-UDGrid -Title "Active Directory Security Groups ($env:USERDNSDOMAIN)" -Endpoint {
        Get-ADSIGroup -IsSecurityGroup:$True | Foreach-Object {
            $gsam = [string]$_.SamAccountName
            $name = [string]$_.Name
            $mbrs = (Get-ADSIGroupMember -Identity $gsam).Count
            [pscustomobject]@{
                Name           = New-UDElement -Tag "a" -Attributes @{ href="/adgroup/$name"} -Content { $name }
                SamAccountName = $gsam
                Members        = [int]$mbrs
                Scope          = [string]$_.ContextType
                Description    = [string]$_.Description
            }
        } | Out-UDGridData
    }
}

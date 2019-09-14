New-UDPage -Url "/aduser/:username" -Endpoint {
    param ($username)
    $aduser = Get-ADSIUser -Identity $username
    $mail = [string]$_.EmailAddress
    New-UDCard -Title "Active Directory User: $username" -Content {""}
    New-UDTable -Title "General Properties" -Header @("Attribute","Value") -Endpoint {
        $aduser | Foreach-Object {
            $Data = @(
                [pscustomobject]@{ attribute = "SamAccountName"; value = [string]$_.SamAccountName}
                [pscustomobject]@{ attribute = "DisplayName"; value = [string]$_.DisplayName}
                [pscustomobject]@{ attribute = "FirstName"; value = [string]$_.GivenName}
                [pscustomobject]@{ attribute = "MiddleName"; value = [string]$_.MiddleName}
                [pscustomobject]@{ attribute = "LastName"; value = [string]$_.Surname}
                [pscustomobject]@{ attribute = "EmployeeID"; value = [string]$_.EmployeeId}
                [pscustomobject]@{ attribute = "Enabled"; value = [string]$_.Enabled}
                [pscustomobject]@{ attribute = "Description"; value = [string]$_.Description}
                [pscustomobject]@{ attribute = "Name"; value = [string]$_.Name}
                [pscustomobject]@{ attribute = "Email"; value = $mail}
                [pscustomobject]@{ attribute = "Telephone"; value = [string]$_.VoiceTelephoneNumber}
            )
            $Data | Out-UDTableData -Property @("Attribute","Value")
        }
    }
    New-UDTable -Title "Account Properties" -Header @("Attribute","Value") -Endpoint {
        $aduser | Foreach-Object {
            $Data = @(
                [pscustomobject]@{ attribute = "UPN"; value = [string]$_.UserPrincipalName}
                [pscustomobject]@{ attribute = "SID"; value = [string]$_.Sid}
                [pscustomobject]@{ attribute = "GUID"; value = [string]$_.Guid}
                [pscustomobject]@{ attribute = "DistinguishedName"; value = [string]$_.DistinguishedName}
                [pscustomobject]@{ attribute = "HomeDirectory"; value = [string]$_.HomeDirectory}
                [pscustomobject]@{ attribute = "HomeDrive"; value = [string]$_.HomeDrive}
                [pscustomobject]@{ attribute = "ScriptPath"; value = [string]$_.ScriptPath}
            )
            $Data | Out-UDTableData -Property @("Attribute","Value")
        }
    }
    New-UDTable -Title "Security Information" -Header @("Attribute","Value") -Endpoint {
        $aduser | Foreach-Object {
            $Data = @(
                [pscustomobject]@{ attribute = "AccountExpires"; value = [string]$_.AccountExpirationDate}
                [pscustomobject]@{ attribute = "LastLogon"; value = [string]$_.LastLogon}
                [pscustomobject]@{ attribute = "LastPwdSet"; value = [string]$_.LastPasswordSet}
                [pscustomobject]@{ attribute = "LastBadPwd"; value = [string]$_.LastBadPasswordAttempt}
                [pscustomobject]@{ attribute = "PwdNotRequired"; value = [string]$_.PasswordNotRequired}
                [pscustomobject]@{ attribute = "PwdNeverExpires"; value = [string]$_.PasswordNeverExpires}
                [pscustomobject]@{ attribute = "UserCantChangePwd"; value = [string]$_.UserCannotChangePassword}
                [pscustomobject]@{ attribute = "SmartcardLogon"; value = [string]$_.SmartcardLogonRequired}
                #PermittedWorkstations{}
                #PermittedLogonTimes
                #DelegationPermitted
                #BadLogonCount
                #AccountLockoutTime
                #AllowReversiblePasswordEncryption
                #Certificates {}
            )
            $Data | Out-UDTableData -Property @("Attribute","Value")
        }
    }
}
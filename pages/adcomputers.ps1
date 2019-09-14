New-UDPage -Name "adcomputers" -Id "adcomputers" -Icon desktop -Content {
    New-UDGrid -Title "Active Directory Computers ($env:USERDNSDOMAIN)" -Endpoint {
        Get-ADSIComputer | Foreach-Object {
            $llogon = $_.LastLogon
            #$lpwd   = $_.LastPasswordSet
            $name = [string]$_.Name
            if (![string]::IsNullOrEmpty($llogon)) {
                $lldays = (New-TimeSpan -Start $([datetime]$llogon) -End $(Get-Date)).Days
            }
            else {
                $lldays = $null
            }
            #$lpdays = (New-TimeSpan -Start $lpwd -End (Get-Date)).Days
            [pscustomobject]@{
                Name        = New-UDElement -Tag "a" -Attributes @{ href="/adcomputer/$name"} -Content { $name }
                Enabled     = $_.Enabled
                Description = [string]$_.Description
                LastLogon   = $llogon
                DaysAgo     = $lldays
            }
        } | Out-UDGridData
    }
}
New-UDPage -Url "/adcomputer/name" -Endpoint {
    param ($name, $tabnum = 1)
    $adcomp = Get-ADSIComputer -Identity $name
    New-UDRow {
        New-UDButton -Id 'b1' -Text "General" -OnClick { Invoke-UDRedirect -Url "adcomputer/$name/1" } -Flat
        New-UDButton -Id 'b2' -Text "Groups" -OnClick { Invoke-UDRedirect -Url "adcomputer/$name/2" } -Flat
        New-UDButton -Id 'b3' -Text "Hardware" -OnClick { Invoke-UDRedirect -Url "adcomputer/$name/3" } -Flat
        New-UDButton -Id 'b4' -Text "Software" -OnClick { Invoke-UDRedirect -Url "adcomputer/$name/4" } -Flat
    }
    New-UDRow {
        switch ($tabnum) {
            1 {
                New-UDTable -Title "General" -Headers @("Property","Value") -Endpoint {
                    $Data = @(
                        [pscustomobject]@{ property = "Name"; value = [string]$adcomp.Name }
                        [pscustomobject]@{ property = "Description"; value = [string]$adcomp.Description }
                        [pscustomobject]@{ property = "LastLogon"; value = [string]$adcomp.LastLogon }
                        [pscustomobject]@{ property = "LastPasswordSet"; value = [string]$adcomp.LastPasswordSet }
                        [pscustomobject]@{ property = "Enabled"; value = [string]$adcomp.Enabled }
                        [pscustomobject]@{ property = "SamAccountName"; value = [string]$adcomp.SamAccountName }
                        [pscustomobject]@{ property = "SID"; value = [string]$adcomp.Sid }
                        [pscustomobject]@{ property = "GUID"; value = [string]$adcomp.Guid }
                        [pscustomobject]@{ property = "DistinguishedName"; value = [string]$adcomp.DistinguishedName }
                        [pscustomobject]@{ property = "DelegationPermitted"; value = [string]$adcomp.DelegationPermitted }
                    )
                    $Data | Out-UDTableData -Property @("Property", "Value")
                }
            }
            default {
                New-UDCard -Title "Coming Soon" -Content {""}
            }
        } # switch
    }
}

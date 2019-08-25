New-UDPage -Name "ADSummary" -Id 'adsummary' -Content {
    New-UDTable -Title "Active Directory Summary: $($env:USERDNSDOMAIN)" -Header @("Name", "Count") -Endpoint {
        $computers = $(Get-ADSIComputer).Count
        $users     = $(Get-ADSIUser).Count
        $groups    = $(Get-ADSIGroup).Count
        $dcs       = $(Get-ADSIDomainController).Count
        $sites     = $(Get-ADSISite).Count
        $Data = @(
            [PSCustomObject]@{ name = "Computers"; count = $computers }
            [PSCustomObject]@{ name = "Users"; count = $users }
            [PSCustomObject]@{ name = "Groups"; count = $groups }
            [PSCustomObject]@{ name = "Sites"; count = $sites }
            [PSCustomObject]@{ name = "Domain Controllers"; count = $dcs }
        )
        $Data | Out-UDTableData -Property @("name", "count")
    }
    New-UDTable -Title "FSMO Role Owners" -Header @("Role", "ComputerName") -Endpoint {
        $fsmo      = Get-ADSIFsmo
        $Data = @(
            [PSCustomObject]@{ role = "PDC Emulator"; computername = [string]$fsmo.PdcRoleOwner }
            [PSCustomObject]@{ role = "Schema Master"; computername = [string]$fsmo.SchemaRoleOwner }
            [PSCustomObject]@{ role = "Infrastructure Master"; computername = [string]$fsmo.InfrastructureRoleOwner }
            [PSCustomObject]@{ role = "RID Master"; computername = [string]$fsmo.RidRoleOwner }
            [PSCustomObject]@{ role = "Domain Naming Master"; computername = [string]$fsmo.NamingRoleOwner }
        )
        $Data | Out-UDTableData -Property @("role", "computername")
    }
}
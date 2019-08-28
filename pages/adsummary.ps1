New-UDPage -Name "adsummary" -Id 'adsummary' -Content {
    New-UDCard -Title "Active Directory Summary: $($env:USERDNSDOMAIN)" -Content {""}
    New-UDTable -Title "Objects Summary" -Header @("Name", "Count") -Endpoint {
        $computers = $(Get-ADSIComputer).Count
        $users     = $(Get-ADSIUser).Count
        $groups    = $(Get-ADSIGroup).Count
        $dcs       = $(Get-ADSIDomainController).Count
        $sites     = $(Get-ADSISite).Count
        $gpos      = $(Get-ADSIGroupPolicyObject).Count
        #$subnets   = $(Get-ADSISiteSubnet).Count
        $links     = $(Get-ADSISiteLink).Count
        $Data = @(
            [PSCustomObject]@{ name = "Computers"; count = $computers }
            [PSCustomObject]@{ name = "Users"; count = $users }
            [PSCustomObject]@{ name = "Groups"; count = $groups }
            [PSCustomObject]@{ name = "Domain Controllers"; count = $dcs }
            [PSCustomObject]@{ name = "Group Policy Objects"; count = $gpos }
            [PSCustomObject]@{ name = "Sites"; count = $sites }
            [PSCustomObject]@{ name = "Site Links"; count = $links }
            #[PSCustomObject]@{ name = "Subnets"; count = $subnets }
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
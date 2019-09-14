New-UDPage -Name "addomain" -ID 'addomain' -Content {
    New-UDGrid -Title "Active Directory Domain" -Endpoint {
        Get-ADSIDomain |
            Select-Object Name,Forest,Parent,DomainMode,PdcRoleOwner,RidRoleOwner,InfrastructureRoleOwner | Foreach-Object {
                [pscustomobject]@{
                    Name       = [string]$_.Name
                    Forest     = [string]$_.Forest
                    Parent     = [string]$_.Parent
                    DomainMode = [string]$_.DomainMode
                    PDCOwner   = [string]$_.PdcRoleOwner
                    RIDOwner   = [string]$_.RidRoleOwner
                    IMRole     = [string]$_.InfrastructureRoleOwner
                }
            } | Out-UDGridData
    }
}
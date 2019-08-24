New-UDPage -Name "CMAdmins" -Icon app_store -Content {
	New-UDGrid -Title "Configuration Manager Site Administrators" -Endpoint {
        $SiteHost = $Cache:ConnectionInfo.Server
        $SiteCode = $Cache:ConnectionInfo.SiteCode
        $query = "SELECT
vRBAC_AdminRoles.RoleName,
vRBAC_AdminRoles.RoleNameL,
vRBAC_Admins.LogonName as UserName,
vRBAC_Admins.DisplayName,
vRBAC_Admins.DistinguishedName,
vRBAC_AdminRoles.AdminID,
vRBAC_AdminRoles.RoleID,
vRBAC_Admins.AdminSID,
vRBAC_Admins.IsGroup,
case
    when (vRBAC_Admins.AccountType = 0) then 'User'
    when (vRBAC_Admins.AccountType = 1) then 'Group'
    when (vRBAC_Admins.AccountType = 2) then 'Machine'
    when (vRBAC_Admins.AccountType = 128) then 'UnverifiedUser'
    when (vRBAC_Admins.AccountType = 129) then 'UnverifiedGroup'
    when (vRBAC_Admins.AccountType = 130) then 'UnverifiedMachine'
    end as AccountType
FROM
vRBAC_AdminRoles INNER JOIN
vRBAC_Admins ON vRBAC_AdminRoles.AdminID = vRBAC_Admins.AdminID"
        Invoke-DbaQuery -SqlInstance $SiteHost -Database "CM_$SiteCode" -Query $query |
            Out-UDGridData
    }
}

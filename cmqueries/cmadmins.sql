select distinct
    ar.RoleName,
    ar.RoleNameL,
    aa.LogonName as UserName,
    aa.DisplayName,
    aa.DistinguishedName,
    ar.AdminID,
    ar.RoleID,
    aa.AdminSID,
    aa.IsGroup,
    case
        when (aa.AccountType = 0) then 'User'
        when (aa.AccountType = 1) then 'Group'
        when (aa.AccountType = 2) then 'Machine'
        when (aa.AccountType = 128) then 'UnverifiedUser'
        when (aa.AccountType = 129) then 'UnverifiedGroup'
        when (aa.AccountType = 130) then 'UnverifiedMachine'
        end as AccountType
FROM
    vRBAC_AdminRoles as ar INNER JOIN
    vRBAC_Admins as aa ON ar.AdminID = aa.AdminID
order by
    RoleName
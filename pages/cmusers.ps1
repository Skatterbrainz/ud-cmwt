New-UDPage -Name "CMUsers" -Icon desktop -Content {
	New-UDGrid -Title "Configuration Manager Users" -Endpoint {
        $SiteHost = $Cache:ConnectionInfo.Server
        $SiteCode = $Cache:ConnectionInfo.SiteCode
        $query = "SELECT distinct ResourceID, User_Name0 AS UserName,
User_Principal_Name0 AS UPN, SID0 AS SID, Full_User_Name0 AS FullName,
AD_Object_Creation_Time0 AS DateCreated
FROM dbo.v_R_User AS us order by Full_User_Name0"
        Invoke-DbaQuery -SqlInstance $SiteHost -Database "CM_$SiteCode" -Query $query |
            Select UserName,FullName,UPN,SID,DateCreated | Out-UDGridData
    }
}

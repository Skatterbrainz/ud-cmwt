select distinct
    ResourceID,
    User_Name0 AS UserName,
    User_Principal_Name0 AS UPN,
    Full_User_Name0 AS FullName,
    AD_Object_Creation_Time0 AS DateCreated
from
    dbo.v_R_User AS us
order by
    Full_User_Name0
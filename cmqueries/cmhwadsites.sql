select distinct
    AD_Site_Name0 as ADSiteName,
    COUNT(*) as Devices
from v_r_system
group by AD_Site_Name0
order by AD_Site_Name0

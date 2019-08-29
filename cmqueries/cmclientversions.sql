select distinct
    sys.client_version0 as ClientVersion,
    Count(*) as Devices
from v_r_system sys
group by sys.client_version0
order by sys.client_version0
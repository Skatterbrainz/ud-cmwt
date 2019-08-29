select distinct
    DefaultIPGateway0 as IPGateway,
    COUNT(*) as Devices
from v_GS_NETWORK_ADAPTER_CONFIGURATION
group by DefaultIPGateway0
order by DefaultIPGateway0
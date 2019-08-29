select distinct
    DHCPServer0 as DHCPServer,
    COUNT(*) as Devices
from v_GS_NETWORK_ADAPTER_CONFIGURATION
group by DHCPServer0
order by DHCPServer0
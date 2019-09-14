select distinct
    Model0 as Model,
    COUNT(*) as Devices
from v_GS_COMPUTER_SYSTEM
group by Model0
order by Model0
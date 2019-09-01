SELECT DISTINCT
	ResourceID,
	IPAddress0 as IPAddress,
	MACAddress0 as MAC,
	IPSubnet0 as Mask,
	DefaultIPGateway0 as Gateway,
	case when (DHCPEnabled0 = 1) then 'Yes' else 'No' end as DHCPEnabled,
	DNSDomain0 as DNSDomain,
	DHCPServer0 as DHCPServer,
	DNSHostName0 as HostName
FROM dbo.v_GS_NETWORK_ADAPTER_CONFIGURATION
WHERE IPEnabled0 = 1
ORDER BY ResourceID
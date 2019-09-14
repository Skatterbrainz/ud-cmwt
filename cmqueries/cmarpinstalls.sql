SELECT DISTINCT
	T1.ResourceID,T1.ProductName,T1.Publisher,T1.Version,T1.ProductCode,T1.Platform FROM (
SELECT DISTINCT
	ResourceID,
    DisplayName0 as ProductName,
    Publisher0 as Publisher,
    Version0 as Version,
	ProdID0 as ProductCode,
    '32-bit' as Platform
FROM
    v_GS_ADD_REMOVE_PROGRAMS
UNION
SELECT DISTINCT
	ResourceID,
    DisplayName0 as ProductName,
    Publisher0 as Publisher,
    Version0 as Version,
	ProdID0 as ProductCode,
    '64-bit' as Platform
FROM
    v_GS_ADD_REMOVE_PROGRAMS_64
) AS T1
ORDER BY T1.ResourceID,T1.ProductName,T1.Publisher,T1.Version
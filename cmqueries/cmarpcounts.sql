SELECT DISTINCT
	T1.ProductName,T1.Publisher,T1.Version,T1.Platform,T1.Installs FROM (
SELECT DISTINCT
    DisplayName0 as ProductName,
    Publisher0 as Publisher,
    Version0 as Version,
    '32-bit' as Platform,
    COUNT(*) as Installs
FROM
    v_GS_ADD_REMOVE_PROGRAMS
GROUP BY
    DisplayName0,Publisher0,Version0
UNION
SELECT DISTINCT
    DisplayName0 as ProductName,
    Publisher0 as Publisher,
    Version0 as Version,
    '64-bit' as Platform,
    COUNT(*) as Installs
FROM
    v_GS_ADD_REMOVE_PROGRAMS_64
GROUP BY
    DisplayName0,Publisher0,Version0
) AS T1
ORDER BY T1.ProductName,T1.Publisher,T1.Version
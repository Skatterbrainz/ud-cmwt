SELECT DISTINCT
	Caption0 as OSName,
	Version0 as OSVersion,
	BuildNumber0 as OSBuild,
	OSArchitecture0 as Architecture,
	COUNT(*) as Installs
FROM
    v_GS_OPERATING_SYSTEM
GROUP BY
	Caption0,Version0,BuildNumber0,OSArchitecture0
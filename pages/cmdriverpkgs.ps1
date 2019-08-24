New-UDPage -Name "CMDriverPkgs" -Icon app_store -Content {
	New-UDGrid -Title "Configuration Manager Driver Packages" -Endpoint {
        $SiteHost = $Cache:ConnectionInfo.Server
        $SiteCode = $Cache:ConnectionInfo.SiteCode
        $ptype = 3
        $query = "SELECT DISTINCT
PackageID, Name, Version, Description, PkgSourcePath,
CASE WHEN (PackageType = 0) THEN 'Package'
WHEN (PackageType = 3) THEN 'Driver Package'
WHEN (PackageType = 4) THEN 'Task Sequence Package'
WHEN (PackageType = 5) THEN 'Software Update Package'
WHEN (PackageType = 6) THEN 'Device Settings Package'
WHEN (PackageType = 7) THEN 'Virtual Package'
WHEN (PackageType = 8) THEN 'Application'
WHEN (PackageType = 257) THEN 'OS Image Package'
WHEN (PackageType = 258) THEN 'Boot Image Package'
WHEN (PackageType = 259) THEN 'OS Upgrade Package'
WHEN (PackageType = 260) THEN 'VHD Package' END AS PkgType
FROM dbo.v_Package
WHERE PackageType = $ptype
ORDER BY Name"
        Invoke-DbaQuery -SqlInstance $SiteHost -Database "CM_$SiteCode" -Query $query |
            Select Name,PackageID,Version,Description | Out-UDGridData
    }
}

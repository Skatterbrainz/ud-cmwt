﻿New-UDPage -Name "CMPackages" -Icon app_store -Content {
	New-UDGrid -Title "Configuration Manager Packages" -Endpoint {
        $SiteHost = $Cache:ConnectionInfo.Server
        $SiteCode = $Cache:ConnectionInfo.SiteCode
        $ptype = 0
        $query = "SELECT DISTINCT
PackageID, Name, Version, Description, PkgSourcePath
FROM dbo.v_Package WHERE PackageType = $ptype ORDER BY Name"
        Invoke-DbaQuery -SqlInstance $SiteHost -Database "CM_$SiteCode" -Query $query |
            Select Name,PackageID,Version,Description | Out-UDGridData
    }
}

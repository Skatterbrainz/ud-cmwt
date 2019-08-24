New-UDPage -Name "CMBootImages" -Icon app_store -Content {
	New-UDGrid -Title "Configuration Manager Boot Images" -Endpoint {
        $SiteHost = $Cache:ConnectionInfo.Server
        $SiteCode = $Cache:ConnectionInfo.SiteCode
        $ptype = 258
        $query = "SELECT DISTINCT
PackageID, Name, Version, Description, PkgSourcePath
FROM dbo.v_Package WHERE PackageType = $ptype ORDER BY Name"
        Invoke-DbaQuery -SqlInstance $SiteHost -Database "CM_$SiteCode" -Query $query |
            Select Name,PackageID,Version,Description | Out-UDGridData
    }
}

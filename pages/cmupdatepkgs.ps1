New-UDPage -Name "CMUpdatePkgs" -Id 'cmupdatepkgs' -Content {
	New-UDGrid -Title "Configuration Manager Software: Software Update Packages" -Endpoint {
        $SiteHost = $Cache:ConnectionInfo.Server
        $SiteCode = $Cache:ConnectionInfo.SiteCode
        $BasePath = $Cache:ConnectionInfo.BasePath
        $qfile    = Join-Path $BasePath "cmqueries\cmpackages.sql"
        Invoke-DbaQuery -SqlInstance $SiteHost -Database "CM_$SiteCode" -File $qfile |
                Where-Object PackageType -eq 5 |
                Select-Object Name,PackageID,Version,Description | Out-UDGridData
    }
}

New-UDPage -Name "CMOSImages" -Id 'cmosimages' -Content {
	New-UDGrid -Title "Configuration Manager Software: OS Images" -Endpoint {
        $SiteHost = $Cache:ConnectionInfo.Server
        $SiteCode = $Cache:ConnectionInfo.SiteCode
        $BasePath = $Cache:ConnectionInfo.BasePath
        $qfile    = Join-Path $BasePath "cmqueries\cmpackages.sql"
        Invoke-DbaQuery -SqlInstance $SiteHost -Database "CM_$SiteCode" -File $qfile |
                Where-Object PackageType -eq 257 |
                Select-Object Name,PackageID,Version,Description | Out-UDGridData
    }
}

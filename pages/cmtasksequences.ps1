New-UDPage -Name "CMTaskSequences" -Id 'cmtasksequences' -Content {
	New-UDGrid -Title "Configuration Manager Software: Task Sequences" -Endpoint {
        $SiteHost = $Cache:ConnectionInfo.Server
        $SiteCode = $Cache:ConnectionInfo.SiteCode
        $BasePath = $Cache:ConnectionInfo.BasePath
        $qfile    = Join-Path $BasePath "cmqueries\cmpackages.sql"
        Invoke-DbaQuery -SqlInstance $SiteHost -Database "CM_$SiteCode" -File $qfile |
			Where-Object PackageType -eq 4 |
                Select-Object Name,PackageID,Description | Out-UDGridData
    }
}

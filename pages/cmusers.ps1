New-UDPage -Name "CMUsers" -Id 'cmusers' -Content {
	New-UDGrid -Title "Configuration Manager Users" -Endpoint {
		$SiteHost = $Cache:ConnectionInfo.Server
		$SiteCode = $Cache:ConnectionInfo.SiteCode
		$BasePath = $Cache:ConnectionInfo.BasePath
		$qfile    = Join-Path $BasePath "cmqueries\cmusers.sql"
		Invoke-DbaQuery -SqlInstance $SiteHost -Database "CM_$SiteCode" -File $qfile -EnableException |
			Select UserName,FullName,UPN,SID,DateCreated | Out-UDGridData
	}
}

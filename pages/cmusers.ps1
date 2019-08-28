New-UDPage -Name "cmusers" -Id 'cmusers' -Content {
	New-UDGrid -Title "Configuration Manager Users" -Endpoint {
		$qname    = "cmusers.sql"
        $SiteHost = $Cache:ConnectionInfo.Server
        $Database = $Cache:ConnectionInfo.CmDatabase
		$BasePath = $Cache:ConnectionInfo.QfilePath
		$qfile    = Join-Path $BasePath $qname
		Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -File $qfile -EnableException |
			Select-Object UserName,FullName,UPN,SID,DateCreated | Out-UDGridData
	}
}

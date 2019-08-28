New-UDPage -Name "cmadmins" -Icon app_store -Content {
	New-UDGrid -Title "Configuration Manager Site Administrators" -Endpoint {
        $qname    = "cmadmins.sql"
        $SiteHost = $Cache:ConnectionInfo.Server
        $Database = $Cache:ConnectionInfo.CmDatabase
		$BasePath = $Cache:ConnectionInfo.QfilePath
		$qfile    = Join-Path $BasePath $qname
        Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -File $qfile |
            Select-Object UserName,RoleName,DisplayName,AccountType | Out-UDGridData
    }
    New-UDRow {
        New-UDParagraph -Text "$SiteHost $Database $qfile"
    }
}

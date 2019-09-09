New-UDPage -Name "cmclienthealth" -Content {
    New-UDGrid -Title "Software Updates Scan Exceptions" -Endpoint {
        $qname    = "cmclientscans.sql"
        $SiteHost = $Cache:ConnectionInfo.Server
        $Database = $Cache:ConnectionInfo.CmDatabase
		$BasePath = $Cache:ConnectionInfo.QfilePath
		$qfile    = Join-Path $BasePath $qname
        Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -File $qfile |
            Out-UDGridData
    }
}

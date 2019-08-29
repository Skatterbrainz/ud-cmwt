New-UDPage -Name "cmhwdhcp" -Id 'cmhwdhcp' -Content {
	New-UDGrid -Title "Configuration Manager Inventory: DHCP Servers" -Endpoint {
        $qname    = "cmhwdhcp.sql"
        $SiteHost = $Cache:ConnectionInfo.Server
        $Database = $Cache:ConnectionInfo.CmDatabase
		$BasePath = $Cache:ConnectionInfo.QfilePath
		$qfile    = Join-Path $BasePath $qname
		Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -File $qfile |
            Select-Object Model,Devices | Out-UDGridData
    }
}

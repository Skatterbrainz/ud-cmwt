New-UDPage -Name "cmhwgateways" -Id 'cmhwgateways' -Content {
	New-UDGrid -Title "Configuration Manager Inventory: IP Gateways" -Endpoint {
        $qname    = "cmhwgateways.sql"
        $SiteHost = $Cache:ConnectionInfo.Server
        $Database = $Cache:ConnectionInfo.CmDatabase
		$BasePath = $Cache:ConnectionInfo.QfilePath
		$qfile    = Join-Path $BasePath $qname
		Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -File $qfile |
            Select-Object IPGateway,Devices | Out-UDGridData
    }
}

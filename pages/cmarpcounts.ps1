New-UDPage -Name "cmarpcounts" -Content {
	New-UDGrid -Title "Configuration Manager Software Inventory" -Endpoint {
        $qname    = "cmarpcounts.sql"
        $SiteHost = $Cache:ConnectionInfo.Server
        $Database = $Cache:ConnectionInfo.CmDatabase
		$BasePath = $Cache:ConnectionInfo.QfilePath
		$qfile    = Join-Path $BasePath $qname
        Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -File $qfile | Foreach-Object {
            $pn = [string]$_.ProductName
            $vn = [string]$_.Publisher
            $pv = [string]$_.Version
            [pscustomobject]@{
                ProductName = $pn
                Publisher = $vn
                Versions  = $pv
                Installs  = [int]$_.Installs
            }
        } | Out-UDGridData
    }
}

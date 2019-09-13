New-UDPage -Name "cmarpcounts" -Content {
	New-UDGrid -Title "Configuration Manager Software Inventory" -Endpoint {
        Get-CmwtDbQuery -QueryName "cmarpcounts" | Foreach-Object {
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

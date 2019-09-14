New-UDPage -Name "cmsupsynch" -Content {
	New-UDGrid -Title "Configuration Manager SUP Synchronization Status" -Endpoint {
        Get-CmwtDbQuery -QueryName "cmsupsynch" | Out-UDGridData
    }
}

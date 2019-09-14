New-UDPage -Name "cmdevices" -Content {
	New-UDGrid -Title "Configuration Manager Devices" -Endpoint {
        Get-CmwtDbQuery -QueryName "cmdevices" | Foreach-Object {
            $resid = [string]$_.ResourceID
            $name  = [string]$_.Name
            [pscustomobject]@{
                Name    = New-UDElement -Tag "a" -Attributes @{ href="/cmdevice/$resid/general" } -Content { $name }
                ResourceID = $resid
                OSName  = [string]$_.OSName
                OSBuild = [string]$_.OSBuild
                Client  = [string]$_.ClientVersion
                ADSite  = [string]$_.ADSiteName
                Model   = [string]$_.Model
            }
        } | Out-UDGridData
    }
}

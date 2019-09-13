New-UDPage -Name "cmoscounts" -Content {
	New-UDGrid -Title "Configuration Manager - Operating Systems" -Endpoint {
        Get-CmwtDbQuery -QueryName "cmoscounts" | Foreach-Object {
            $osn = [string]$_.OSName
            $osv = [string]$_.OSVersion
            $osb = [string]$_.OSBuild
            $osa = [string]$_.Architecture
            $oslink = New-UDElement -Tag "a" -Attributes @{ href="/cmosclients/$osn/$osv/$osb/$osa"} -Content { $osn }
            [pscustomobject]@{
                OSName  = $oslink
                Version = $osv
                Build   = $osb
                Architecture = $osa
                Installs  = [int]$_.Installs
            }
        } | Out-UDGridData
    }
}

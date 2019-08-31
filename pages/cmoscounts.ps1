New-UDPage -Name "cmoscounts" -Id 'cmoscounts' -Content {
	New-UDGrid -Title "Configuration Manager - Operating Systems" -Endpoint {
        $qname    = "cmoscounts.sql"
        $SiteHost = $Cache:ConnectionInfo.Server
        $Database = $Cache:ConnectionInfo.CmDatabase
		$BasePath = $Cache:ConnectionInfo.QfilePath
		$qfile    = Join-Path $BasePath $qname
        Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -File $qfile | Foreach-Object {
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

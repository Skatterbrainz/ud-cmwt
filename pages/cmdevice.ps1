New-UDPage -Url "/cmdevice/:resourceid/:tabnum" -Endpoint {
    param ($resourceid, $tabnum)
    switch ($tabnum) {
        '1' { $qname = "cmdevice.sql" }
        '2' { $qname = "cmdevicehw.sql" }
        '3' { $qname = "cmdevicesw.sql" }
        '4' { $qname = "cmdevicecolls.sql" }
        '5' { $qname = "cmdevicedeps.sql" }
        default { $qname = "cmdevice.sql" }
    }
    $SiteHost = $Cache:ConnectionInfo.Server
    $Database = $Cache:ConnectionInfo.CmDatabase
    $BasePath = $Cache:ConnectionInfo.QfilePath
    $qfile    = Join-Path $BasePath $qname
    New-UDRow {
        New-UDButton -Id 'b1' -Text "General" -OnClick { Invoke-UDRedirect -Url "cmdevice/$resourceid/1" } -Flat
        New-UDButton -Id 'b2' -Text "Hardware" -OnClick { Invoke-UDRedirect -Url "cmdevice/$resourceid/2" } -Flat
        New-UDButton -Id 'b3' -Text "Software" -OnClick { Invoke-UDRedirect -Url "cmdevice/$resourceid/3" } -Flat
        New-UDButton -Id 'b4' -Text "Collections" -OnClick { Invoke-UDRedirect -Url "cmdevice/$resourceid/4" } -Flat
        New-UDButton -Id 'b5' -Text "Deployments" -OnClick { Invoke-UDRedirect -Url "cmdevice/$resourceid/5" } -Flat
        New-UDButton -Id 'b6' -Text "Networking" -OnClick { Invoke-UDRedirect -Url "cmdevice/$resourceid/6" } -Flat
    }
    New-UDRow {
        switch ($tabnum) {
            '1' {
                New-UDTable -Title "General" -Headers @("Property","Value") -Endpoint {
                    $cdata = Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -File $qfile |
                        Where-Object {$_.ResourceID -eq $resourceid} | Select-Object -First 1
                    $mfr     = $cdata.Manufacturer
                    $model   = $cdata.Model
                    $osname  = $cdata.OSName
                    $adsite  = $cdata.ADSiteName
                    $linkmfr = New-UDElement -Tag "a" -Attributes @{ href="/cmfind/device/mfr/$mfr"} -Content { $mfr }
                    $linkmod = New-UDElement -Tag "a" -Attributes @{ href="/cmfind/device/model/$model"} -Content { $model }
                    $linkos  = New-UDElement -Tag "a" -Attributes @{ href="/cmfind/device/osname/$osname"} -Content { $osname }
                    $linkads = New-UDElement -Tag "a" -Attributes @{ href="/cmfind/device/adsitename/$adsite"} -Content { $adsite }
                    $Data = @(
                        [pscustomobject]@{ property = "Name"; value = [string]$cdata.Name }
                        [pscustomobject]@{ property = "ResourceID"; value = [string]$cdata.ResourceID }
                        [pscustomobject]@{ property = "Manufacturer"; value = $linkmfr }
                        [pscustomobject]@{ property = "Model"; value = $linkmod }
                        [pscustomobject]@{ property = "SerialNumber"; value = [string]$cdata.SerialNumber }
                        [pscustomobject]@{ property = "Client"; value = [string]$cdata.Client }
                        [pscustomobject]@{ property = "ClientVersion"; value = [string]$cdata.ClientVersion }
                        [pscustomobject]@{ property = "ADSiteName"; value = $linkads }
                        [pscustomobject]@{ property = "OSName"; value = $linkos }
                        [pscustomobject]@{ property = "OSBuild"; value = [string]$cdata.OSBuild }
                        [pscustomobject]@{ property = "UserName"; value = [string]$cdata.UserName }
                        [pscustomobject]@{ property = "LastHwScan"; value = [string]$cdata.LastHwScan }
                        [pscustomobject]@{ property = "LastDDR"; value = [string]$cdata.LastDDR }
                        [pscustomobject]@{ property = "LastPolicyReq"; value = [string]$cdata.LastPolicyReq }
                        [pscustomobject]@{ property = "LastMP"; value = [string]$cdata.LastMP }
                        [pscustomobject]@{ property = "IsVM"; value = [string]$cdata.IsVM }
                        [pscustomobject]@{ property = "ChassisType"; value = [string]($cdata.ChassisType -join ' ') }
                        [pscustomobject]@{ property = "LastHealthEval"; value = [string]$cdata.LastHealthEval }
                        [pscustomobject]@{ property = "SystemType"; value = [string]$cdata.SystemType }
                        [pscustomobject]@{ property = "Processors"; value = [string]$cdata.Processors }
                    )
                    $Data | Out-UDTableData -Property @("Property", "Value")
                }
            }
        } # switch
    } # row
}

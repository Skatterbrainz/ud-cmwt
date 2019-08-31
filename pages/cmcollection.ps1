New-UDPage -Url "/cmcollection/:collid/:tabnum" -Endpoint {
    param ($collid,$tabnum)
    switch ($tabnum) {
        '1' { $qname = "cmcollection.sql" }
        '2' { $qname = "cmcollmembers.sql" }
        '3' { $qname = "coll3.sql" }
        default { $qname = "cmcollection.sql" }
    }
    $SiteHost = $Cache:ConnectionInfo.Server
    $Database = $Cache:ConnectionInfo.CmDatabase
    $BasePath = $Cache:ConnectionInfo.QfilePath
    $qfile = Join-Path $BasePath $qname
    New-UDRow {
        New-UDButton -Id 'b1' -Text "General" -OnClick { Invoke-UDRedirect -Url "cmcollection/$collid/1" } -Flat
        New-UDButton -Id 'b2' -Text "Members" -OnClick { Invoke-UDRedirect -Url "cmcollection/$collid/2" } -Flat
        New-UDButton -Id 'b3' -Text "QueryRules" -OnClick { Invoke-UDRedirect -Url "cmcollection/$collid/3" } -Flat
        New-UDButton -Id 'b4' -Text "PowerCfgs" -OnClick { Invoke-UDRedirect -Url "cmcollection/$collid/4" } -Flat
        New-UDButton -Id 'b5' -Text "Deployments" -OnClick { Invoke-UDRedirect -Url "cmcollection/$collid/5" } -Flat
    }
    New-UDRow {
        switch ($tabnum) {
            '1' {
                New-UDTable -Title "General" -Headers @("Property","Value") -Endpoint {
                    $cdata = Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -File $qfile -EnableException |
                        Where-Object {$_.SiteID -eq $collid}
                    $Data = @(
                        [pscustomobject]@{ property = "Name"; value = [string]$cdata.Name }
                        [pscustomobject]@{ property = "CollectionID"; value = [string]$cdata.CollectionID }
                        [pscustomobject]@{ property = "Comment"; value = [string]$cdata.Comment }
                        [pscustomobject]@{ property = "LimitToCollID"; value = [string]$cdata.LimitToCollectionID }
                        [pscustomobject]@{ property = "LimitToCollection"; value = [string]$cdata.LimitToCollectionName }
                        [pscustomobject]@{ property = "ResultTable"; value = [string]$cdata.ResultTable }
                        [pscustomobject]@{ property = "ServiceWindows"; value = [string]$cdata.ServiceWindows }
                        [pscustomobject]@{ property = "Variables"; value = [string]$cdata.Variables }
                        [pscustomobject]@{ property = "PowerConfigs"; value = [string]$cdata.PowerConfigs }
                        [pscustomobject]@{ property = "LastChanged"; value = [string]$cdata.LastChangeTime }
                        [pscustomobject]@{ property = "LastRefresh"; value = [string]$cdata.LastRefreshTime }
                        [pscustomobject]@{ property = "BuiltIn"; value = [string]$cdata.BuiltIn }
                        [pscustomobject]@{ property = "ConsolePath"; value = [string]$cdata.ConsolePath }
                    )
                    $Data | Out-UDTableData -Property @("Property", "Value")
                }
            }
            '2' {
                New-UDGrid -Title "Collection Members" -Endpoint {
                    Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -File $qfile -EnableException |
                        Where-Object {$_.CollectionID -eq $collid} | Foreach-Object {
                            $resid = [string]$_.ResourceID
                            $name  = [string]$_.ComputerName
                            [pscustomobject]@{
                                Name          = New-UDElement -Tag "a" -Attributes @{ href="/cmdevice/$resid"} -Content { $name }
                                ClientVersion = [string]$_.ClientVersion
                                Model         = [string]$_.Model
                                OSName        = [string]$_.OSName
                                OSBuild       = [string]$_.OSBuild
                                ADSiteName    = [string]$_.ADSiteName
                            }
                    } | Out-UDGridData
                }
            }
            '3' {}
            '4' {}
            '5' {}
        }
    }
}

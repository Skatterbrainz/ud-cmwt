New-UDPage -Url "/cmcollection/:collid/:tabnum" -Endpoint {
    param ($collid,$tabnum)
    switch ($tabnum) {
        '1' { $qname = "cmcollection.sql" }
        '2' { $qname = "cmcollmembers.sql" }
        '3' { $qname = "cmcollqueryrules.sql" }
        '4' { $qname = ""}
        '6' { $qname = "cmcollvariables.sql" }
        default { $qname = "cmcollection.sql" }
    }
    New-UDRow {
        New-UDButton -Id 'b1' -Text "General" -OnClick { Invoke-UDRedirect -Url "/cmcollection/$collid/1" } -Flat
        New-UDButton -Id 'b2' -Text "Members" -OnClick { Invoke-UDRedirect -Url "/cmcollection/$collid/2" } -Flat
        New-UDButton -Id 'b3' -Text "QueryRules" -OnClick { Invoke-UDRedirect -Url "/cmcollection/$collid/3" } -Flat
        New-UDButton -Id 'b4' -Text "PowerCfgs" -OnClick { Invoke-UDRedirect -Url "/cmcollection/$collid/4" } -Flat
        New-UDButton -Id 'b5' -Text "Deployments" -OnClick { Invoke-UDRedirect -Url "/cmcollection/$collid/5" } -Flat
        New-UDButton -Id 'b6' -Text "Variables" -OnClick { Invoke-UDRedirect -Url "/cmcollection/$collid/6" } -Flat
    }
    New-UDRow {
        switch ($tabnum) {
            '1' {
                New-UDTable -Title "General" -Headers @("Property","Value") -Endpoint {
                    $cdata = Get-CmwtDbQuery -QueryName $qname | Where-Object {$_.SiteID -eq $collid}
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
                    Get-CmwtDbQuery -QueryName $qname |
                        Where-Object {$_.CollectionID -eq $collid} | Foreach-Object {
                            $resid   = [string]$_.ResourceID
                            $name    = [string]$_.ComputerName
                            $model   = [string]$_.Model
                            $osname  = [string]$_.OSName
                            $osbuild = [string]$_.OSBuild
                            $adsite  = [string]$_.ADSiteName
                            $oslink  = New-UDElement -Tag "a" -Attributes @{ href="/cmfind/device/osname/$osname" } -Content { $osname }
                            $adlink  = New-UDElement -Tag "a" -Attributes @{ href="/cmfind/device/adsitename/$adsite" } -Content { $adsite }
                            $oblink  = New-UDElement -Tag "a" -Attributes @{ href="/cmfind/device/osbuild/$osbuild" } -Content { $osbuild }
                            $mdlink  = New-UDElement -Tag "a" -Attributes @{ href="/cmfind/device/model/$model" } -Content { $model }
                            [pscustomobject]@{
                                Name          = New-UDElement -Tag "a" -Attributes @{ href="/cmdevice/$resid/1" } -Content { $name }
                                ClientVersion = [string]$_.ClientVersion
                                Model         = $mdlink
                                OSName        = $oslink
                                OSBuild       = $oblink
                                ADSiteName    = $adlink
                            }
                    } | Out-UDGridData
                }
            }
            '3' {
                New-UDGrid -Title "Collection Query Rules" -Endpoint {
                    Get-CmwtDbQuery -QueryName $qname |
                        Where-Object {($null -ne $_.RuleName) -and ($_.CollectionID -eq $collid)} | Foreach-Object {
                        [pscustomobject]@{
                            CollectionID   = [string]$_.CollectionID
                            CollectionName = [string]$_.CollectionName
                            Members        = [int]$_.MemberCount
                            RuleName       = [string]$_.RuleName
                            LimitCollID    = [string]$_.LimitToCollectionID
                        }
                    } | Out-UDGridData
                }
            }
            '4' {}
            '5' {}
            '6' {
                New-UDGrid -Title "Collection Variables" -Endpoint {
                    @(Get-CmwtDbQuery -QueryName $qname |
                        Where-Object {$_.CollectionID -eq $collid} |
                            Select-Object VariableName,Value,Masked) | Out-UDGridData
                }
            }
        }
    }
}

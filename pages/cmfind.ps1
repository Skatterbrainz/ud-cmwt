New-UDPage -Url "/cmfind/:cmclass/:prop/:value" -Endpoint {
    param ($cmclass,$prop,$value)
    switch ($prop) {
        'osname'  {
            $pagetitle = "Devices by Operating System"
            $qname     = "cmdevices.sql"
            $proplist  = @("Name","ResourceID","Model","OSName","OSBuild","Client","ADSite")
        }
        'osbuild' {
            $pagetitle = "Devices by Operating System BuildNumber"
            $qname     = "cmdevices.sql"
            $proplist  = @("Name","ResourceID","Model","OSName","OSBuild","Client","ADSite")
        }
        'model'   {
            $pagetitle = "Devices by Model"
            $qname     = "cmdevices.sql"
            $proplist  = @("Name","ResourceID","Model","OSName","OSBuild","Client","ADSite")
        }
        'mfr'     {
            $pagetitle = "Devices by Manufacturer"
            $qname     = "cmdevice.sql"
            $proplist  = @("Name","ResourceID","Model","OSName","OSBuild","Client","ADSite")
        }
        'adsitename' {
            if ($cmclass -eq 'device') {
                $pagetitle = "Devices by AD Site"
                $qname     = "cmdevices.sql"
                $proplist  = @("Name","ResourceID","Model","OSName","OSBuild","Client","ADSite")
            }
            else {
                $pagetitle = "Users by AD Site"
                $qname     = "cmusers.sql"
                $proplist  = @("UserName","ResourceID","DisplayName")
            }
        }
        default   { $pagetitle = "Error" }
    }
    $sval = $value -replace '%20',' '
    $pagetitle += "`: $value"
    $SiteHost = $Cache:ConnectionInfo.Server
    $Database = $Cache:ConnectionInfo.CmDatabase
    $BasePath = $Cache:ConnectionInfo.QfilePath
    $qfile    = Join-Path $BasePath $qname
    $cdata = @(Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -File $qfile | Where-Object {$_."$prop" -eq $sval})

    New-UDRow {
        New-UDGrid -Title "$pagetitle ($sval)" -Endpoint {
            switch ($prop) {
                'model' {
                    $cdata | Foreach-Object {
                        $resid   = [string]$_.ResourceID
                        $name    = [string]$_.Name
                        $model   = [string]$_.Model
                        $osname  = [string]$_.OSName
                        $osbuild = [string]$_.OSBuild
                        $adsite  = [string]$_.ADSiteName
                        [pscustomobject]@{
                            Name    = New-UDElement -Tag "a" -Attributes @{ href="/cmdevice/$resid/1" } -Content { $name }
                            ResourceID = $resid
                            OSName  = New-UDElement -Tag "a" -Attributes @{ href="/cmfind/device/osname/$osname" } -Content { $osname }
                            OSBuild = New-UDElement -Tag "a" -Attributes @{ href="/cmfind/device/osbuild/$osbuild" } -Content { $osbuild }
                            Client  = [string]$_.ClientVersion
                            ADSite  = New-UDElement -Tag "a" -Attributes @{ href="/cmfind/device/adsite/$adsite" } -Content { $adsite }
                            Model   = New-UDElement -Tag "a" -Attributes @{ href="/cmfind/device/model/$model" } -Content { $model }
                        }
                    } | Out-UDGridData
                }
                'osname' {
                    $cdata | Foreach-Object {
                        $resid   = [string]$_.ResourceID
                        $name    = [string]$_.Name
                        $model   = [string]$_.Model
                        $osname  = [string]$_.OSName
                        $osbuild = [string]$_.OSBuild
                        $adsite  = [string]$_.ADSiteName
                        [pscustomobject]@{
                            Name    = New-UDElement -Tag "a" -Attributes @{ href="/cmdevice/$resid/1" } -Content { $name }
                            ResourceID = $resid
                            OSName  = New-UDElement -Tag "a" -Attributes @{ href="/cmfind/device/osname/$osname" } -Content { $osname }
                            OSBuild = New-UDElement -Tag "a" -Attributes @{ href="/cmfind/device/osbuild/$osbuild" } -Content { $osbuild }
                            Client  = [string]$_.ClientVersion
                            ADSite  = New-UDElement -Tag "a" -Attributes @{ href="/cmfind/device/adsite/$adsite" } -Content { $adsite }
                            Model   = New-UDElement -Tag "a" -Attributes @{ href="/cmfind/device/model/$model" } -Content { $model }
                        }
                    } | Out-UDGridData
                }
            } # switch
        } # grid
    } # row
}
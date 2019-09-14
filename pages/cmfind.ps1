New-UDPage -Url "/cmfind/:cmclass/:prop/:value" -Endpoint {
    param ($cmclass,$prop,$value)
    switch ($prop) {
        'osname'  {
            $pagetitle = "Devices by Operating System"
            $qname     = "cmdevices.sql"
        }
        'osbuild' {
            $pagetitle = "Devices by Operating System BuildNumber"
            $qname     = "cmdevices.sql"
        }
        'model'   {
            $pagetitle = "Devices by Model"
            $qname     = "cmdevices.sql"
        }
        'manufacturer'     {
            $pagetitle = "Devices by Manufacturer"
            $qname     = "cmdevice.sql"
        }
        'adsitename' {
            if ($cmclass -eq 'device') {
                $pagetitle = "Devices by AD Site"
                $qname     = "cmdevices.sql"
            }
            else {
                $pagetitle = "Users by AD Site"
                $qname     = "cmusers.sql"
            }
        }
        default   { $pagetitle = "Error" }
    }
    $sval = $value -replace '%20',' '
    $pagetitle += "`: $value"
    $cdata = @(Get-CmwtDbQuery -QueryName $qname | Where-Object {$_."$prop" -eq $sval})

    New-UDRow {
        New-UDGrid -Title "$pagetitle ($sval)" -Endpoint {
            switch ($cmclass) {
                'device' {
                    $cdata | Foreach-Object {
                        $resid   = [string]$_.ResourceID
                        $name    = [string]$_.Name
                        $model   = [string]$_.Model
                        $osname  = [string]$_.OSName
                        $osbuild = [string]$_.OSBuild
                        $adsite  = [string]$_.ADSiteName
                        $clientver = [string]$_.ClientVersion
                        $mfr    = [string]$_.Manufacturer
                        [pscustomobject]@{
                            Name    = New-UDElement -Tag "a" -Attributes @{ href="/cmdevice/$resid/1" } -Content { $name }
                            ResourceID = $resid
                            OSName  = New-UDElement -Tag "a" -Attributes @{ href="/cmfind/device/osname/$osname" } -Content { $osname }
                            OSBuild = New-UDElement -Tag "a" -Attributes @{ href="/cmfind/device/osbuild/$osbuild" } -Content { $osbuild }
                            Client  = $clientver
                            ADSite  = New-UDElement -Tag "a" -Attributes @{ href="/cmfind/device/adsitename/$adsite" } -Content { $adsite }
                            Manufacturer = New-UDElement -Tag "a" -Attributes @{ href="/cmfind/device/manufacturer/$mfr" } -Content { $mfr }
                            Model   = New-UDElement -Tag "a" -Attributes @{ href="/cmfind/device/model/$model" } -Content { $model }
                        }
                    } | Out-UDGridData
                }
            }
        } # grid
    } # row
}
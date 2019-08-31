New-UDPage -Url "/cmfind/:cmclass/:prop/:value" -Endpoint {
    param ($cmclass,$prop,$value)
    switch ($prop) {
        'osname'  {
            $pagetitle = "Devices by Operating System"
            $qname = "cmdevices.sql"
        }
        'osbuild' {
            $pagetitle = "Devices by Operating System BuildNumber"
            $qname = "cmdevices.sql"
        }
        'model'   {
            $pagetitle = "Devices by Model"
            $qname = "cmdevices.sql"
        }
        'mfr'     {
            $pagetitle = "Devices by Manufacturer"
            $qname = "cmdevice.sql"
        }
        'adsitename' {
            if ($cmclass -eq 'device') {
                $pagetitle = "Devices by AD Site"
                $qname = "cmdevices.sql"
            }
            else {
                $pagetitle = "Users by AD Site"
                $qname = "cmusers.sql"
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
    New-UDRow {
        New-UDGrid -Title "$pagetitle ($sval)" -Endpoint {
            $cdata = @(Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -File $qfile | Where-Object {$_."$prop" -eq $sval})
            $cdata | Foreach-Object {
                    $resid = [string]$_.ResourceID
                    $name  = [string]$_.Name
                    [pscustomobject]@{
                        Name    = New-UDElement -Tag "a" -Attributes @{ href="/cmdevice/$resid/1" } -Content { $name }
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
}
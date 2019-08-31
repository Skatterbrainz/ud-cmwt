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
    $qfile = Join-Path $BasePath $qname
    New-UDRow {
        New-UDButton -Id 'b1' -Text "General" -OnClick { Invoke-UDRedirect -Url "cmcollection/$collid/1" } -Flat
        New-UDButton -Id 'b2' -Text "Hardware" -OnClick { Invoke-UDRedirect -Url "cmcollection/$collid/2" } -Flat
        New-UDButton -Id 'b3' -Text "Software" -OnClick { Invoke-UDRedirect -Url "cmcollection/$collid/3" } -Flat
        New-UDButton -Id 'b4' -Text "Collections" -OnClick { Invoke-UDRedirect -Url "cmcollection/$collid/4" } -Flat
        New-UDButton -Id 'b5' -Text "Deployments" -OnClick { Invoke-UDRedirect -Url "cmcollection/$collid/5" } -Flat
    }
    New-UDRow {
        switch ($tabnum) {
            '1' {}
            '2' {}
            '3' {}
            '4' {}
            '5' {}
        }
    }
}

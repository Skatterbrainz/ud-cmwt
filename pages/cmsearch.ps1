New-UDPage -Name "cmsearch" -Endpoint {
    New-UDInput -Title "Search ConfigMgr Inventory" -Content {
        New-UDInputField -Name 'searchval' -Placeholder "Search Value" -Type textbox
        New-UDInputField -Name 'tdevices' -Placeholder "Device Names" -Type checkbox
        New-UDInputField -Name 'tmods' -Placeholder "Device Models" -Type checkbox
        New-UDInputField -Name 'tusers' -Placeholder "User Names" -Type checkbox
        New-UDInputField -Name 'tcolls' -Placeholder "Collections" -Type checkbox
        New-UDInputField -Name 'tapps' -Placeholder "Applications" -Type checkbox
        New-UDInputField -Name 'tpackages' -Placeholder "Packages" -Type checkbox
        New-UDInputField -Name 'tsw' -Placeholder "Installed Software" -Type checkbox
        New-UDInputField -Name 'ttaskseqs' -Placeholder "TaskSequences" -Type checkbox
    } -Endpoint {
        param($searchval,$tdevices,$tusers,$tmods,$tcolls,$tapps,$tpackages,$ttaskseqs)
        #$targets = ($tdevices,$tusers,$tcolls,$tmods,$tapps,$tpackages,$ttaskseqs)
        $url = "cmsearchresults/$searchval/"
        if ($tdevices -eq $true)  { $url += 'd=1,' }
        if ($tusers -eq $true)    { $url += 'u=1,' }
        if ($tcolls -eq $true)    { $url += 'c=1,' }
        if ($tapps -eq $true)     { $url += 'a=1,' }
        if ($tpackages -eq $true) { $url += 'p=1,' }
        if ($ttaskseqs -eq $true) { $url += 't=1,' }
        if ($tsw -eq $true)       { $url += 's=1,' }
        if ($tmods -eq $true)     { $url += 'm=1' }
        $url = $url.TrimEnd(',')
        Invoke-UDRedirect -Url $url
    }
}
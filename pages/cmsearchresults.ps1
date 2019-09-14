New-UDPage -Url "/cmsearchresults/:srchval/:targets" -Endpoint {
    param ($srchval,$targets)
    $targets = $targets -split ','
    # d,u,c,a,p,t,s,m
    $targets | Foreach-Object {
        $key = $_.Substring(0,1)
        if ($key -eq 'd') {
            New-UDGrid -Title "Device Names: $srchval" -Endpoint {
                Get-CmwtDbQuery -QueryName "cmdevices" |
                    Where-Object {$_.Name -match $srchval} |
                        Select-Object Name,Client,Model,OSName,UserName,ADSiteName,SerialNumber | Out-UDGridData
            }
        }
        if ($key -eq 'm') {
            New-UDGrid -Title "Device Models: $srchval" -Endpoint {
                Get-CmwtDbQuery -QueryName "cmdevices" |
                    Where-Object {$_.Model -match $srchval} |
                        Select-Object Name,Client,Model,OSName,UserName,ADSiteName,SerialNumber | Out-UDGridData
            }
        }
        if ($key -eq 'u') {
            New-UDGrid -Title "User Names: $srchval" -Endpoint {}
        }
        if ($key -eq 'a') {
            New-UDGrid -Title "Applications: $srchval" -Endpoint {}
        }
        if ($key -eq 'p') {
            New-UDGrid -Title "Packages: $srchval" -Endpoint {}
        }
        if ($key -eq 't') {
            New-UDGrid -Title "Task Sequences: $srchval" -Endpoint {}
        }
        if ($key -eq 's') {
            New-UDGrid -Title "Installed Software: $srchval" -Endpoint {}
        }
    }
}
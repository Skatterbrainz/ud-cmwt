New-UDPage -Url "/cmdevice/:resourceid/:tabnum" -Endpoint {
    param ([string]$resourceid, [int]$tabnum = 1)
    switch ($tabnum) {
        1 { $qname = "cmdevice.sql" }
        2 { $qname = "cmdevicehw.sql" }
        3 { $qname = "cmdevicesw.sql" }
        4 { $qname = "cmdevicecolls.sql" }
        5 { $qname = "cmclienthealthsummary.sql" }
        default { $qname = "cmdevice.sql" }
    }
    $SiteHost = $Cache:ConnectionInfo.Server
    $Database = $Cache:ConnectionInfo.CmDatabase
    $BasePath = $Cache:ConnectionInfo.QfilePath
    $compdata = @(Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -File (Join-Path $BasePath "cmdevicename.sql") |
        Where-Object {$_.ResourceID -eq $resourceid} )
    if ($compdata.Count -gt 0) {
        $compname = [string]$compdata[0].ComputerName
    }
    else {
        $compname = "Unknown"
    }
    New-UDRow {
        New-UDButton -Id 'b1' -Text "General" -OnClick { Invoke-UDRedirect -Url "cmdevice/$resourceid/1" } -Flat
        New-UDButton -Id 'b2' -Text "Hardware" -OnClick { Invoke-UDRedirect -Url "cmdevice/$resourceid/2" } -Flat
        New-UDButton -Id 'b3' -Text "Software" -OnClick { Invoke-UDRedirect -Url "cmdevice/$resourceid/3" } -Flat
        New-UDButton -Id 'b4' -Text "Collections" -OnClick { Invoke-UDRedirect -Url "cmdevice/$resourceid/4" } -Flat
        New-UDButton -Id 'b5' -Text "Client Status" -OnClick { Invoke-UDRedirect -Url "cmdevice/$resourceid/5" } -Flat
        New-UDButton -Id 'b6' -Text "Networking" -OnClick { Invoke-UDRedirect -Url "cmdevice/$resourceid/6" } -Flat
    }
    New-UDRow {
        switch ($tabnum) {
            1 {
                New-UDTable -Title "$compname - General" -Headers @("Property","Value") -Endpoint {
                    $qfile = Join-Path $BasePath "cmdevice.sql"
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
            2 {
                # hardware inventory
                #$cs = Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -Query "select * from v_GS_COMPUTER_SYSTEM where resourceid=$resid"
                New-UDGrid -Title "$compname - Hardware" -Endpoint {
                    $qfile = ""
                }
                New-UDGrid -Title "$compname - Logical Disks" -Endpoint {
                    $qfile = Join-Path $BasePath "cmlogicaldisks.sql"
                    $dataset = $null
                    $dataset = Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -File $qfile |
                        Where-Object {$_.ResourceID -eq $resourceid} |
                            Select-Object Drive,Label,Description,Size,FreeSpace,Used,FileSystem,SerialNum
                    $dataset | Out-UDGridData
                }
                New-UDGrid -Title "$compname - Processors" -Endpoint {
                    $qfile = Join-Path $BasePath "cmprocessors.sql"
                    $dataset = $null
                    $dataset = Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -File $qfile |
                        Where-Object {$_.ResourceID -eq $resourceid} |
                            Select-Object Name,Manufacturer,Bits,MaxClock,Cores,LogicalProcs,VMCapable
                    $dataset | Out-UDGridData
                }
            }
            3 {
                # software inventory
                New-UDGrid -Title "$compname - Installed Software" -Endpoint {
                    $qfile = Join-Path $BasePath "cmarpinstalls.sql"
                    $dataset = $null
                    $dataset = Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -File $qfile |
                        Where-Object {$_.ResourceID -eq $resourceid} |
                            Select-Object ProductName,Publisher,Version,ProductCode,Platform
                    $dataset | Out-UDGridData
                }
            }
            4 {
                New-UDGrid -Title "$compname - Collections" -Endpoint {
                    $dataset = $null
                    $qcoll = "SELECT DISTINCT
ccm.CollectionID, coll.Name AS CollectionName, coll.Comment
FROM v_ClientCollectionMembers AS ccm INNER JOIN
v_Collection AS coll ON ccm.CollectionID = coll.CollectionID
WHERE (ccm.ResourceID = $resourceid) order by coll.Name"
                    $dataset = @(Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -Query $qcoll |
                        Where-Object {$_.ResourceID -eq $resourceid})
                    $dataset | Out-UDGridData
                }
            }
            5 {
                New-UDTable -Title "$compname - Client Status" -Headers @("Property","Value") -Endpoint {
                    $qfile = Join-Path $BasePath "cmclienthealthsummary.sql"
                    $cdata = Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -File $qfile |
                        Where-Object {$_.ResourceID -eq $resourceid} | Select-Object -First 1
                    $lasthw  = "$([string]$cdata.LastHW) ($([int]$cdata.HwInvAge) days ago)"
                    $lastsw  = "$([string]$cdata.LastSW) ($([int]$cdata.SwInvAge) days ago)"
                    $lastddr = "$([string]$cdata.LastDDR) ($((New-TimeSpan -Start $cdata.LastDDR -End $(Get-Date)).Days) days ago)"
                    $laston  = "$([string]$cdata.LastOnline) ($((New-TimeSpan -Start $cdata.LastOnline -End $(Get-Date)).Days) days ago)"
                    $lastpol = "$([string]$cdata.LastPolicyRequest) ($((New-TimeSpan -Start $cdata.LastPolicyRequest -End $(Get-Date)).Days) days ago)"
                    $Data = @(
                        [pscustomobject]@{ property = "Name"; value = [string]$cdata.ComputerName }
                        [pscustomobject]@{ property = "UserName"; value = [string]$cdata.UserName }
                        [pscustomobject]@{ property = "ClientState"; value = [string]$cdata.ClientStateDescription }
                        [pscustomobject]@{ property = "ActiveStatus"; value = [string]$cdata.ClientActiveStatus }
                        [pscustomobject]@{ property = "LastActive"; value = [string]$cdata.LastActiveTime }
                        [pscustomobject]@{ property = "ActiveDDR"; value = [string]$cdata.IsActiveDDR }
                        [pscustomobject]@{ property = "ActiveHW"; value = [string]$cdata.IsActiveHW }
                        [pscustomobject]@{ property = "ActiveSW"; value = [string]$cdata.IsActiveSW }
                        [pscustomobject]@{ property = "ActivePolicy"; value = [string]$cdata.ISActivePolicyRequest }
                        [pscustomobject]@{ property = "ActiveStatus"; value = [string]$cdata.IsActiveStatusMessages }
                        [pscustomobject]@{ property = "LastOnline"; value = $laston }
                        [pscustomobject]@{ property = "LastDDR"; value = $lastddr }
                        [pscustomobject]@{ property = "LastHWInv"; value = $lasthw }
                        [pscustomobject]@{ property = "LastSWInv"; value = $lastsw }
                        [pscustomobject]@{ property = "LastPolicyRequest"; value = $lastpol }
                        [pscustomobject]@{ property = "LastStatusMessage"; value = [string]$cdata.LastStatusMessage }
                        [pscustomobject]@{ property = "LastHealthEval"; value = [string]$cdata.LastHealthEvaluation }
                        [pscustomobject]@{ property = "LastResult"; value = [string]$cdata.LastResult }
                        [pscustomobject]@{ property = "LastEvaluation"; value = [string]$cdata.LastEval }
                        [pscustomobject]@{ property = "RemediationStatus"; value = [string]$cdata.ClientRemediationSuccess }
                        [pscustomobject]@{ property = "ExpectPolicyRequest"; value = [string]$cdata.ExpectedNextPolicyRequest }
                    )
                    $Data | Out-UDTableData -Property ("Property","Value")
                }
            }
            6 {
                New-UDGrid -Title "$compname - Network Adapters" -Endpoint {
                    $qfile = Join-Path $BasePath "cmnetadapters.sql"
                    $dataset = $null
                    $dataset = @(Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -File $qfile |
                        Where-Object {$_.ResourceID -eq $resourceid} |
                            Select-Object IPAddress,MAC,Mask,Gateway,DHCPEnabled,DNSDomain,DHCPServer)
                    $dataset | Out-UDGridData
                }
            }
            <#
            New-UDSideNavItem -Text "Processes" -Url "processes" -Icon tachometer
            New-UDSideNavItem -Text "Services" -PageName "services" -Icon tachometer
            New-UDSideNavItem -Text "System Event Log" -PageName "syseventlog" -Icon tachometer
            New-UDSideNavItem -Text "App Event Log" -PageName "appeventlog" -Icon tachometer
            #>
        } # switch
    } # row
}

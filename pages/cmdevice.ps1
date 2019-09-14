New-UDPage -Url "/cmdevice/:resourceid/:propname" -Endpoint {
    param ($resourceid, $propname = "general")

    $compdata = @(Get-CmwtDbQuery -QueryName "cmdevicename" | Where-Object {$_.ResourceID -eq $resourceid} )
    if ($compdata.Count -gt 0) {
        $compname = [string]$compdata[0].ComputerName
    }
    else {
        $compname = "Unknown"
    }

    New-UDRow {
        New-UDColumn -Endpoint {
            $proplist = @("General","Hardware","Processors","Disks","Networking","Software","Processes","Services","SysEvents","AppEvents","Collections","ClientStatus")
            $bx = 1
            foreach($prop in $proplist) {
                $url = "cmdevice/$resourceid/$prop"
                New-UDButton -Id "b$bx" -Text $prop -OnClick { Invoke-UDRedirect -Url $url } -Flat
                $bx++
            }
        }
    }
    <#
    New-UDRow {
        New-UDInput -Title "" -Id 'form1' -Content {
            [string[]]$proplist = @("General","Hardware","Processors","Disks","Networking","Software","Processes","Services","SysEvents","AppEvents","Collections","ClientStatus")
            $defitem = $propname
            New-UDInputField -Type 'select' -Name 'prop' -Placeholder 'Property Group' -DefaultValue $defitem -Values $proplist
        } -Endpoint {
            param($prop)
            [string]$url = "cmdevice/$resourceid/$prop"
            Invoke-UDRedirect -Url $url
        }
    }
    #>
    New-UDRow {
        switch ($propname) {
            "general" {
                New-UDTable -Title "$compname - General" -Headers @("Property","Value") -Endpoint {
                    $cdata = Get-CmwtDbQuery -QueryName "cmdevice" | Where-Object {$_.ResourceID -eq $resourceid} | Select-Object -First 1
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
            "hardware" {
                # hardware inventory
                New-UDTable -Title "$compname - Client Status" -Headers @("Property","Value") -Endpoint {
                    $cdata = Get-CmwtDbQuery -QueryText "select Name0 as Name,Manufacturer0 as Manufacturer,Model0 as Model from v_GS_COMPUTER_SYSTEM where resourceid=$resourceid"
                    $Data = @(
                        [pscustomobject]@{ property = "Name"; value = [string]$cdata.Name }
                        [pscustomobject]@{ property = "Manufacturer"; value = [string]$cdata.Manufacturer }
                        [pscustomobject]@{ property = "Model"; value = [string]$cdata.Model }
                    )
                    $Data | Out-UDTableData -Property @("Property","Value")
                }
            }
            "processors" {
                New-UDGrid -Title "$compname - Processors" -Endpoint {
                    $dataset = Get-CmwtDbQuery -QueryName "cmprocessors" |
                        Where-Object {$_.ResourceID -eq $resourceid} |
                            Select-Object Name,Manufacturer,Bits,MaxClock,Cores,LogicalProcs,VMCapable
                    $dataset | Out-UDGridData
                }
            }
            "disks" {
                New-UDGrid -Title "$compname - Logical Disks" -Endpoint {
                    $dataset = Get-CmwtDbQuery -QueryName "cmlogicaldisks" |
                        Where-Object {$_.ResourceID -eq $resourceid} |
                            Select-Object Drive,Label,Description,Size,FreeSpace,Used,FileSystem,SerialNum
                    $dataset | Out-UDGridData
                }
            }
            "software" {
                # software inventory
                New-UDGrid -Title "$compname - Installed Software" -Endpoint {
                    $dataset = Get-CmwtDbQuery -QueryName "cmarpinstalls" |
                        Where-Object {$_.ResourceID -eq $resourceid} |
                            Select-Object ProductName,Publisher,Version,ProductCode,Platform
                    $dataset | Out-UDGridData
                }
            }
            "collections" {
                New-UDGrid -Title "$compname - Collections" -Endpoint {
                    $qcoll = "SELECT DISTINCT
ccm.CollectionID, coll.Name AS CollectionName, coll.Comment
FROM v_ClientCollectionMembers AS ccm INNER JOIN
v_Collection AS coll ON ccm.CollectionID = coll.CollectionID
WHERE (ccm.ResourceID = $resourceid) order by coll.Name"
                    $dataset = @(Get-CmwtDbQuery -QueryText $qcoll | Where-Object {$_.ResourceID -eq $resourceid})
                    $dataset | Out-UDGridData
                }
            }
            "clientstatus" {
                New-UDTable -Title "$compname - Client Status" -Headers @("Property","Value") -Endpoint {
                    $cdata = Get-CmwtDbQuery -QueryName "cmclienthealthsummary" |
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
            "networking" {
                New-UDGrid -Title "$compname - Network Adapters" -Endpoint {
                    $dataset = @(Get-CmwtDbQuery -QueryName "cmnetadapters" |
                        Where-Object {$_.ResourceID -eq $resourceid} |
                            Select-Object IPAddress,MAC,Mask,Gateway,DHCPEnabled,DNSDomain,DHCPServer)
                    $dataset | Out-UDGridData
                }
            }
            "processes" {
                New-UDGrid -Title "$compname - Processes" -Endpoint {
                    Get-Process -ComputerName $compname |
                        Select-Object ProcessName,Id,Path | Out-UDGridData
                }
            }
            "services" {
                New-UDGrid -Title "$compname - Services" -Endpoint {
                    Get-Service -ComputerName $compname | ForEach-Object {
                        [pscustomobject]@{
                            DisplayName = [string]$_.DisplayName
                            ServiceName = [string]$_.ServiceName
                            StartType   = [string]$_.StartType
                            Status      = [string]$_.Status
                        }
                    } | Out-UDGridData
                }
            }
            "sysevents" {
                New-UDGrid -Title "$compname - System Event Log" -Endpoint {
                    Get-WinEvent -Force -ComputerName $compname -LogName System -MaxEvents 50 -ErrorAction SilentlyContinue |
                        Select-Object TimeCreated,ID,ProviderName,Message | Out-UDGridData
                }
            }
            "appevents" {
                New-UDGrid -Title "$compname - Application Event Log" -Endpoint {
                    Get-WinEvent -Force -ComputerName $compname -LogName Application -MaxEvents 50 -ErrorAction SilentlyContinue |
                        Select-Object TimeCreated,ID,ProviderName,Message | Out-UDGridData
                }
            }
            default {
                New-UDCard -Title "$compname - VOID" -Content {"Invalid Property: $propname"}
            }
        } # switch
    } # row
}

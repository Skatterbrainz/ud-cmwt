New-UDPage -Name "cmsummary" -Id 'cmsummary' -Content {
    New-UDCard -Id 'card1' -Title "Site Information" -Horizontal -Endpoint {
        New-UDRow {
            New-UDColumn -Content {
                New-UDTable -Title "Site Information" -Headers @("Property","Value") -Endpoint {
                    $SiteHost = $Cache:ConnectionInfo.Server
                    $Database = $Cache:ConnectionInfo.CmDatabase
                    $siteinfo = Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -Query "select * from v_Site"
                    $Data = @(
                        [pscustomobject]@{ property = "SiteCode"; value = [string]$siteinfo.SiteCode }
                        [pscustomobject]@{ property = "SiteName"; value = [string]$siteinfo.SiteName }
                        [pscustomobject]@{ property = "Version"; value = [string]$siteinfo.Version }
                        [pscustomobject]@{ property = "InstallPath"; value = [string]$siteinfo.InstallDir }
                    )
                    $Data | Out-UDTableData -Property @("Property","Value")
                }
            } # column
            New-UDColumn -Content {
                New-UDTable -Title "Assets Summary" -Headers @("Resource","Count") -Endpoint {
                    $SiteHost = $Cache:ConnectionInfo.Server
                    $Database = $Cache:ConnectionInfo.CmDatabase
                    $devices  = Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -Query "select * from v_r_system"
                    $users    = Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -Query "select * from v_r_user"
                    $pkgs     = Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -Query "select * from v_package"
                    $Data = @(
                        [pscustomobject]@{ resource = "Devices"; count = [int]$devices.Count}
                        [pscustomobject]@{ resource = "Users"; count = [int]$users.Count}
                        [pscustomobject]@{ resource = "Packages"; count = [int]$pkgs.Count}
                    )
                    $Data | Out-UDTableData -Property @("Resource","Count")
                }
            } # column
            New-UDColumn {
                New-UDTable -Title "Client Versions" -Headers @("Version","Devices") -Endpoint {
                    $qname    = "cmclientversions.sql"
                    $SiteHost = $Cache:ConnectionInfo.Server
                    $Database = $Cache:ConnectionInfo.CmDatabase
                    $BasePath = $Cache:ConnectionInfo.QfilePath
                    $qfile    = Join-Path $BasePath $qname
                    $clients  = Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -File $qfile
                    $clients | ForEach-Object {
                        [pscustomobject]@{
                            Version  = [string]$_.ClientVersion
                            Devices  = [int]$_.Devices
                        }
                    } | Out-UDTableData -Property @("Version","Devices")
                }
            } # column
        } # row
        New-UDRow {
            New-UDButton -Id 'button1' -Text "SQL Information" -OnClick {
                Invoke-UDRedirect -Url './sqlsummary'
            }
        }
    } # card
}

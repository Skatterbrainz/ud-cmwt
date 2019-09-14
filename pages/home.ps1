New-UDPage -Name "Home" -Icon home -DefaultHomePage -Content {
    New-UDRow -Columns {
        New-UDColumn -Content {
            New-UDCard -id 'search' -Text "ConfigMgr Search" -Links @( New-UDLink -Url '/cmsearch' -Text "Search" )
            New-UDCard -Image (New-UDImage -Path $(Join-Path (Split-Path $PSScriptRoot) 'assets/splash1.png') -Height 250) -Links @(New-UDLink -Url "./cmsitestatus" -Text "$SiteCode Site Status")
        }
        New-UDColumn -Content {
            New-UDRow {
                New-UDCard -Title "$(Get-Date -f 'dddd MMMM dd, yyyy')" -Content {
                    New-UDHtml -Markup "<div class='left-align'>
<p>Configuration Manager Web Toolkit is built on Universal Dashboard Community Edition.</p>
<p>CMWT is an open source PowerShell project at <a href=`"https://github.com/Skatterbrainz/ud-cmwt`" target=`"_blank`">GitHub</a></p></div>"
                }
            } # row
            New-UDRow -Columns {
                New-UDColumn -Content {
                    New-UDCard -Id 'card1' -Title "Config Mgr" -Text "ConfigMgr Site $SiteCode Summary" -Links @(New-UDLink -Url "./cmsummary" -Text "Summary")
                }
                New-UDColumn -Content {
                    New-UDCard -id 'card2' -Title "Active Directory" -Text "Active Directory Domain Summary" -Links @(New-UDLink -Url "./adsummary" -Text "Summary")
                }
                New-UDColumn -Content {
                    New-UDCard -id 'card3' -Title "SQL Server" -Text "SQL Server Instance Summary" -Links @(New-UDLink -Url "./sqlsummary" -Text "Summary")
                }
            }
            New-UDRow {
                New-UDColumn -Content {
                    New-UDCard -Id 'card4' -Title "Compliance" -Text "Updates Compliance Summary" -Links @(New-UDLink -Url "./cmupdatecompliance" -Text "Summary")
                }
                New-UDColumn -Content {
                    New-UDCard -Id 'card5' -Title "Updates" -Text "CM Software Updates Summary" -Links @(New-UDLink -Url "./cmupdatesummary" -Text "Summary")
                }
                New-UDColumn -Content {
                    New-UDCard -Id 'card6' -Title "AzureAD Devices" -Text "AzureAD devices" -Links @(New-UDLink -Url "./aadcomputers" -Text "Summary")
                }
            }
            New-UDRow {
                New-UDHtml -Markup "<div>Host: $($env:COMPUTERNAME) `: User: $($env:USERNAME) `: Domain: $(($env:USERDNSDOMAIN).ToLower())</div>"
            }
        }
    }
}
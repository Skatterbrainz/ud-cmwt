New-UDPage -Name "Home" -Icon home -DefaultHomePage -Content {
    New-UDRow -Columns {
        New-UDColumn -Content {
            New-UDCard -Image (New-UDImage -Path $(Join-Path (Split-Path $PSScriptRoot) 'assets/splash1.png') -Height 250) -Links @(New-UDLink -Url "./cmsitestatus" -Text "Site Status")
        }
        New-UDColumn -Content {
            New-UDRow {
                New-UDCard -Content {
                    New-UDHtml -Markup "<div class='left-align'><h4>$(Get-Date -f 'dddd MMMM dd, yyyy')</h4>
<p>Configuration Manager Web Toolkit is built on Universal Dashboard Community Edition.</p>
<p>CMWT is an open source PowerShell project at <a href=`"https://github.com/Skatterbrainz/ud-cmwt`" target=`"_blank`">GitHub</a></p></div>"
                }
            } # row
            New-UDRow -Columns {
                New-UDColumn -Content {
                    New-UDCard -Id 'card1' -Title "Config Mgr" -Text "ConfigMgr Site Summary" -Links @(New-UDLink -Url "./cmsummary" -Text "Summary")
                }
                New-UDColumn -Content {
                    New-UDCard -id 'card2' -Title "Active Directory" -Text "Active Directory Summary" -Links @(New-UDLink -Url "./adsummary" -Text "Summary")
                }
                New-UDColumn -Content {
                    New-UDCard -id 'card3' -Title "SQL Server" -Text "SQL Server Summary" -Links @(New-UDLink -Url "./sqlsummary" -Text "Summary")
                }
            }
            New-UDRow {
                New-UDHtml -Markup "<div>Host: $($env:COMPUTERNAME) `: User: $($env:USERNAME) `: Domain: $(($env:USERDNSDOMAIN).ToLower())</div>"
            }
        }
    }
}
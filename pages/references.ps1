New-UDPage -Name "references" -Id "references" -Content {
    New-UDCard -Title "References and Resources" -Content {
        New-UDRow -Columns {
            New-UDColumn -Content {
                New-UDHtml -Markup "<table style=`"width:100%`;border:none`">
<tr><td>
<h4>Universal Dashboard</h4>
<ul>
<li><a href=`"https://docs.universaldashboard.io/`" target=`"_blank`">
UniversalDashboard - Documentation</a></li>
<li><a href=`"https://forums.universaldashboard.io`" target=`"_blank`">
UniversalDashboard - Community Forums</a></li>
</ul>
</td></tr></table>"
            }
            New-UDColumn -Content {
                New-UDHtml -Markup "<table style=`width:100%`;border:none`">
<h4>Modules</h4>
<p>(on which this project depends)</p>
<ul>
<li><a href=`"https://www.powershellgallery.com/packages/UniversalDashboard.Community/`" target=`"_blank`">
UniversalDashboard.Community</a></li>
<li><a href=`"https://dbatools.io/`" target=`"_blank`">DbaTools</a></li>
<li><a href=`"`" target=`"_blank`">AdsiPS</a></li>
</ul>
<tr><td>
</td></tr></table>"
            }
            New-UDColumn -Content {
                New-UDHtml -Markup "<table style=`width:100%`;border:none`">
<tr><td>
<h4>PowerShell</h4>
<ul>
<li><a href=`"https://powershell.org/`" target=`"_blank`">PowerShell.org</a></li>
<li><a href=`"https://www.reddit.com/r/PowerShell/new/`" target=`"_blank`">Reddit r/PowerShell</a></li>
<li><a href=`"https://poshtools.com/`" target=`"_blank`">PowerShell Tools</a></li>
<li><a href=`"https://www.youtube.com/results?search_query=powershell`" target=`"_blank`">YouTube PowerShell content</a></li>
</ul>
</td></tr></table>"
            }
            New-UDColumn -Content {
                New-UDHtml -Markup "<table style=`"width:100%`;border:none`">
<tr><td>
<h4>Twitter</h4>
<ul>
<li><a href=`"https://twitter.com/adamdriscoll`" target=`"_blank`">@adamdriscoll</a></li>
<li><a href=`"https://twitter.com/skatterbrainzz`" target=`"_blank`">@skatterbrainzz</a></li>
<li><a href=`"https://twitter.com/skatterbrainzz/following`" target=`"_blank`">Geniuses I follow</a></li>
</ul>
</td></tr></table>"
            }
        }
    }
}
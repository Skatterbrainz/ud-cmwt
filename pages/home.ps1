﻿New-UDPage -Name "Home" -Icon home -DefaultHomePage -Content {
    New-UDRow -Columns {
        New-UDColumn -Content {
            New-UDCard -Image (New-UDImage -Path $(Join-Path (Split-Path $PSScriptRoot) 'assets/splash1.png') -Height 250)
        }
        New-UDColumn -Content {
            New-UDHtml -Markup "<div class='left-align'><h2>$(Get-Date -f 'dddd MMMM dd, yyyy')</h2>
<p>Configuration Manager Web Toolkit is built on Universal Dashboard Community Edition.</p>
<p>Visit <a href=`"`" target=`"_blank`">xx</a> for more information.</p>
<p>CMWT is open source at <a href=`"https://github.com/Skatterbrainz/ud-cmwt`" target=`"_blank`">GitHub</a></p>"
        }
    }
}
New-UDPage -Name "about" -Id "about" -Icon info -Content {
    New-UDCard -Title "About $($Cache:CMWT.AppName) $($Cache:CMWT.AppVersion)" -Content {
        New-UDRow {
            New-UDParagraph -Text "This project is still in early development. Check back often."
        }
        New-UDRow {
            New-UDHtml -Markup "<div class='left-align'>
<p>Configuration Manager Web Toolkit ($($Cache:CMWT.AppName)) is built on Universal Dashboard Community Edition.</p>
<p>$($Cache:CMWT.AppName) is an open source PowerShell project at <a href=`"https://github.com/Skatterbrainz/ud-cmwt`" target=`"_blank`">GitHub</a></p></div>
<div class='left-align'>
<p>If you would like to contribute to this project, please submit code changes through pull requests.</p>
<p>If you don't want to write any code, please submit ideas/bugs using the 'Issues' on the GitHub repo.</p>
<p>Thank you!</p><br/>
</div>"
        }
        New-UDButton -Id 'button1' -Text "Detailed Information" -OnClick {
            Invoke-UDRedirect -Url './cmwtinfo'
        }
    }
}
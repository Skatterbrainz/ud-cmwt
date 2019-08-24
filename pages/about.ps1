New-UDPage -Name "About" -Icon info -Content {
    New-UDCard -Title "About CMWT $($Cache:ConnectionInfo.AppVersion)" -Content {
        New-UDRow {
            New-UDParagraph -Text "This project is still in early development. Check back often."
        }
        New-UDRow {
            New-UDHtml -Markup "<div class='left-align'>
<p>Configuration Manager Web Toolkit (CMWT) is built on Universal Dashboard Community Edition.</p>
<p>CMWT is an open source PowerShell project at <a href=`"https://github.com/Skatterbrainz/ud-cmwt`" target=`"_blank`">GitHub</a></p></div>
<div class='left-align'>
<p>If you would like to contribute to this project, please submit code changes through pull requests.</p>
<p>If you don't want to write any code, please submit ideas/bugs using the 'Issues' on the GitHub repo.</p>
<p>Thank you!</p>
</div>
<div class='left-align'>
<b>Module Versions</b>
<p>UniversalDashboard.Community version: $((Get-Module 'UniversalDashboard.Community').Version -join '.')</p>
<p>DbaTools version: $((Get-Module 'dbatools').Version -join '.')</p>
<p>AdsiPS version: $((Get-Module 'adsips').Version -join '.')</p>
</div>"
        }
    }
}
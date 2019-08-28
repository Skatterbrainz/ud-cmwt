New-UDPage -Name "CMSummary" -Id 'cmsummary' -Content {
    New-UDCard -Id 'card1' -Title "Site Information" -Horizontal -Content {""}
    New-UDCard -Content {
        New-UDRow {
            $SiteHost = $Cache:ConnectionInfo.Server
            $Database = $Cache:ConnectionInfo.CmDatabase
            $siteinfo = Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -Query "select * from v_Site"
            $devices  = Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -Query "select * from v_r_system"
            $users    = Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -Query "select * from v_r_user"
            $models   = Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -Query "select distinct Manufacturer0,Model0,COUNT(*) as Qty from v_gs_computer_system group by Manufacturer0,Model0 order by Manufacturer0,Model0"
            $pkgs     = Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -Query "select * from v_package"

            New-UDHtml -Markup "<table id=table1 style='width:100%'>
    <tr><td style='width:50%;vertical-align:top'>
    <table style='width:100%'>
    <tr><td>Site Code</td><td>$($siteinfo.SiteCode)</td></tr>
    <tr><td>Site Name</td><td>$($siteinfo.SiteName)</td></tr>
    <tr><td>Site Version</td><td>$($siteinfo.Version)</td></tr>
    <tr><td>Install Path</td><td>$($siteinfo.InstallDir)</td></tr>
    </table>
    </td><td style='width:50%;vertical-align:top'>
    <table id=table1 style='width:50%'>
    <tr><td>Devices</td><td>$($devices.Count)</td></tr>
    <tr><td>Users</td><td>$($users.Count)</td></tr>
    <tr><td>Software Packages</td><td>$($pkgs.Count)</td></tr>
    <tr><td>Models</td><td>$($models.Count)</td></tr>
    </table></td></tr></table>"
        }
    }
}

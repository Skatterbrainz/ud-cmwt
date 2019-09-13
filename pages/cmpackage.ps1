New-UDPage -Url "/cmpackage/:pkgid/:tabnum" -Endpoint {
    param ([string]$pkgid, [int]$tabnum = 1)
    <#
    switch ($tabnum) {
        1 { $qname = """ }
        2 { $qname = "" }
        3 { $qname = "" }
        default { $qname = "" }
    }
    #>
    $pkg = Get-CmwtDbQuery -QueryText "select * from v_Package where PackageID=$pkgid"
    $Cache:PackageName = [string]$pkg.Name
    New-UDRow {
        New-UDButton -Id 'b1' -Text "General" -OnClick { Invoke-UDRedirect -Url "cmpackage/$pkgid/1" } -Flat
        New-UDButton -Id 'b2' -Text "Properties" -OnClick { Invoke-UDRedirect -Url "cmpackage/$pkgid/2" } -Flat
        New-UDButton -Id 'b3' -Text "Deployments" -OnClick { Invoke-UDRedirect -Url "cmpackage/$pkgid/3" } -Flat
        New-UDButton -Id 'b4' -Text "Distribution" -OnClick { Invoke-UDRedirect -Url "cmpackage/$pkgid/4" } -Flat
    }
    switch ($tabnum) {
        1 {
            New-UDTable -Title "Package: $($Cache:PackageName)" -Headers ("Property","Value") -Endpoint {
                $qx = "select * from v_Package where PackageID='$pkgid'"
                $cdata = Get-CmwtDbQuery -QueryText $qx
                $Data = @(
                    [pscustomobject]@{ property = "Name"; value = [string]$cdata.Name }
                    [pscustomobject]@{ property = "PackageID"; value = [string]$cdata.PackageID }
                    [pscustomobject]@{ property = "Version"; value = [string]$cdata.Version }
                    [pscustomobject]@{ property = "Language"; value = [string]$cdata.Language }
                    [pscustomobject]@{ property = "Manufacturer"; value = [string]$cdata.Manufacturer }
                    [pscustomobject]@{ property = "PreDownloadRule"; value = [string]$cdata.PreDownloadRule }
                    [pscustomobject]@{ property = "Description"; value = [string]$cdata.Description }
                    [pscustomobject]@{ property = "PackageType"; value = [string]$cdata.PackageType }
                    [pscustomobject]@{ property = "PkgSourcePath"; value = [string]$cdata.PkgSourcePath }
                    [pscustomobject]@{ property = "StoredPkgPath"; value = [string]$cdata.StoredPkgPath }
                    [pscustomobject]@{ property = "SourceVersion"; value = [string]$cdata.SourceVersion }
                    [pscustomobject]@{ property = "SourceDate"; value = [string]$cdata.SourceDate }
                )
                $Data | Out-UDTableData -Property @("Property", "Value")
            }
        }
        2 {
            New-UDTable -Title "Advanced Properties" -Headers ("Property","Value") -Endpoint {
                $qx = "select * from v_Package where PackageID='$pkgid'"
                $cdata = Get-CmwtDbQuery -QueryText $qx
                $Data = @(
                    [pscustomobject]@{ property = "PkgSourceFlag"; value = [string]$cdata.PkgSourceFlag }
                    [pscustomobject]@{ property = "ShareType"; value = [string]$cdata.ShareType }
                    [pscustomobject]@{ property = "ShareName"; value = [string]$cdata.ShareName }
                    [pscustomobject]@{ property = "SourceSite"; value = [string]$cdata.SourceSite }
                    [pscustomobject]@{ property = "ForcedDisconnectEnabled"; value = [string]$cdata.ForcedDisconnectEnabled }
                    [pscustomobject]@{ property = "ForcedDisconnectNumRetries"; value = [string]$cdata.ForcedDisconnectNumRetries }
                    [pscustomobject]@{ property = "ForcedDisconnectDelay"; value = [string]$cdata.ForcedDisconnectDelay }
                    [pscustomobject]@{ property = "Priority"; value = [string]$cdata.Priority }
                    [pscustomobject]@{ property = "PreferredAddressType"; value = [string]$cdata.PreferredAddressType }
                    [pscustomobject]@{ property = "IgnoreAddressSchedule"; value = [string]$cdata.IgnoreAddressSchedule }
                    [pscustomobject]@{ property = "LastRefreshTime"; value = [string]$cdata.LastRefreshTime }
                    [pscustomobject]@{ property = "PkgFlags"; value = [string]$cdata.PkgFlags }
                    [pscustomobject]@{ property = "MIFFilename"; value = [string]$cdata.MIFFilename }
                    [pscustomobject]@{ property = "MIFPublisher"; value = [string]$cdata.MIFPublisher }
                    [pscustomobject]@{ property = "MIFName"; value = [string]$cdata.MIFName }
                    [pscustomobject]@{ property = "MIFVersion"; value = [string]$cdata.MIFVersion }
                    [pscustomobject]@{ property = "ActionInProgress"; value = [string]$cdata.ActionInProgress }
                    [pscustomobject]@{ property = "ImageFlags"; value = [string]$cdata.ImageFlags }
                    [pscustomobject]@{ property = "SecurityKey"; value = [string]$cdata.SecurityKey }
                    [pscustomobject]@{ property = "ObjectTypeID"; value = [string]$cdata.ObjectTypeID }
                    [pscustomobject]@{ property = "TransformReadiness"; value = [string]$cdata.TransformReadiness }
                    [pscustomobject]@{ property = "TransformAnalysisDate"; value = [string]$cdata.TransformAnalysisDate }
                )
                $Data | Out-UDTableData -Property @("Property", "Value")
            }
        }
    }
}
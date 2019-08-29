New-UDPage -Url "/cmcollections/:type" -Endpoint {
    param ($type)
    switch ($type) { 2 {$ctype = 'Device'} 1 {$ctype = 'User'} default {$ctype = 'Other'}}
    $qname    = "cmcollections.sql"
    $SiteHost = $Cache:ConnectionInfo.Server
    $Database = $Cache:ConnectionInfo.CmDatabase
    $BasePath = $Cache:ConnectionInfo.QfilePath
    $qfile    = Join-Path $BasePath $qname
    $colls = Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -File $qfile |
        Where-Object {$_.CollectionType -eq $type} | Select-Object Name,ID,Comment,Members
    New-UDGrid -Title "Configuration Manager $ctype Collections" -Endpoint {
        $colls | Foreach-Object {
            $cid = [string]$_.ID
            [pscustomobject]@{
                Name    = [string]$_.Name
                ID      = New-UDElement -Tag "a" -Attributes @{ href="/cmcollection/$cid"} -Content { $cid }
                Comment = [string]$_.Comment
                Members = [int]$_.Members
            }
        } | Out-UDGridData
    }
}

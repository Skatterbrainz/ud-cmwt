New-UDPage -Url "/adgroup/:name" -Endpoint {
    param ($name)
    $adgroup = Get-ADSIGroup -Identity $name
    New-UDCard -Title "Active Directory Group: $name" -Content {"More to Come"}
}

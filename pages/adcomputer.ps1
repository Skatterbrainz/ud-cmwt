New-UDPage -Url "/adcomputer/:name" -Endpoint {
    param ($name)
    $adcomp = Get-ADSIComputer -Identity $name
    New-UDCard -Title "Active Directory Computer: $name" -Content {"More to Come"}
}

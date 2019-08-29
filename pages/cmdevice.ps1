New-UDPage -Url "/cmdevice/:resourceid" -Endpoint {
    param ($resourceid)
    New-UDCard -Title "Configuration Manager Device: $resourceid" -Content {""}
}

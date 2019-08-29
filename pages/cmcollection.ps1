New-UDPage -Url "/cmcollection/:collid" -Endpoint {
    param ($collid)
    New-UDCard -Title "Configuration Manager Collection: $collid" -Content {""}
}

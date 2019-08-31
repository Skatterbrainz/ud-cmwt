New-UDPage -Url "/cmosclients/:osname/:osversion/:osbuild/:osarch" -Endpoint {
    param ($osname, $osversion, $osbuild, $osarch)
    New-UDCard -Title "Configuration Manager Devices: $osname ($osversion) $osarch" -Content {""}
}

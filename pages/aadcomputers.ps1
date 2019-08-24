New-UDPage -Name "AADComputers" -Icon desktop -Content {
    New-UDGrid -Title "Azure AD Devices" -Endpoint {
        Connect-MsolService -Credential $([pscredential]$Cache:ConnectionInfo.Credential) -AzureEnvironment AzureCloud
        Get-MsolDevice -All | Select DisplayName,DeviceOsVersion,DeviceTrustType,Enabled | Out-UDGridData
    }
}

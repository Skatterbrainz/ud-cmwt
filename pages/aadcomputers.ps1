New-UDPage -Name "aadcomputers" -Id "aadcomputers" -Icon desktop -Content {
    New-UDGrid -Title "Azure AD Devices" -Endpoint {
		$Credential = $Cache:ConnectionInfo.Credential
        Connect-MsolService -Credential $Credential -AzureEnvironment AzureCloud
        Get-MsolDevice -All |
            Select-Object DisplayName,DeviceOsVersion,DeviceTrustType,Enabled | Out-UDGridData
    }
}

New-UDPage -Name "aadcomputers" -Id "aadcomputers" -Icon desktop -Content {
    New-UDGrid -Title "Azure AD Devices" -Endpoint {
		$Credential = $Cache:ConnectionInfo.Credential
        Connect-MsolService -Credential $Credential -AzureEnvironment AzureCloud
        Get-MsolDevice -All | Foreach-Object {
            $name = [string]$_.DisplayName
            [pscustomobject]@{
                DisplayName = New-UDElement -Tag "a" -Attributes @{ href="/aadcomputer/$name"} -Content { $name }
                OSName      = [string]$_.DeviceOsVersion
                TrustType   = [string]$_.DeviceTrustType
                Enabled     = [string]$_.Enabled
            }
        } | Out-UDGridData
    }
}

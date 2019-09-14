New-UDPage -Name "aadgroups" -Id "aadgroups" -Icon users -Content {
    New-UDGrid -Title "Azure AD Security Groups ($($Cache:CMWT.AzDomain))" -Endpoint {
		$Credential = $Cache:ConnectionInfo.Credential
        Connect-MsolService -Credential $Credential -AzureEnvironment AzureCloud
        Get-MsolGroup -GroupType Security -All |
            Select-Object DisplayName,Description,ObjectId | Out-UDGridData
    }
}

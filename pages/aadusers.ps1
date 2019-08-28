New-UDPage -Name "aadusers" -Id "aadusers" -Icon users -Content {
    New-UDGrid -Title "Azure AD Users ($($Cache:CMWT.AzDomain))" -Endpoint {
		$Credential = $Cache:ConnectionInfo.Credential
        Connect-MsolService -Credential $Credential -AzureEnvironment AzureCloud
        Get-MsolUser -All | Select-Object DisplayName,Department,Title,City,State | Out-UDGridData
    }
}

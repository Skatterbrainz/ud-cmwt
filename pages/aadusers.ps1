New-UDPage -Name "AADUsers" -Icon users -Content {
    New-UDGrid -Title "Azure AD Users ($($Cache:CMWT.AzDomain))" -Endpoint {
        $azcred = $([pscredential]$Cache:ConnectionInfo.Credential)
        Connect-MsolService -Credential $azcred -AzureEnvironment AzureCloud
        Get-MsolUser -All | Select DisplayName,Department,Title,City,State | Out-UDGridData
    }
}

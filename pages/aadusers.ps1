﻿New-UDPage -Name "AADUsers" -Icon users -Content {
    New-UDGrid -Title "Azure AD Users" -Endpoint {
        Connect-MsolService -Credential $([pscredential]$Cache:ConnectionInfo.Credential) -AzureEnvironment AzureCloud
        Get-MsolUser -All | Select DisplayName,Department,Title,City,State | Out-UDGridData
    }
}
New-UDPage -Name "cmadmins" -Content {
	New-UDGrid -Title "Configuration Manager Site Administrators" -Endpoint {
        Get-CmwtDbQuery -QueryName 'cmadmins' |
            Select-Object UserName,RoleName,DisplayName,AccountType | Out-UDGridData
    }
    New-UDRow {
        New-UDParagraph -Text "$SiteHost $Database $qfile"
    }
}

New-UDPage -Name "SQLSPN" -Id 'sqlspn' -Content {
    New-UDGrid -Title "SQL Server Service Principal Names (SPN): $($Cache:ConnectionInfo.Server)" -Endpoint {
        Get-DbaSpn -ComputerName $Cache:ConnectionInfo.Server | Foreach-Object {
            [pscustomobject]@{
                AccountName  = [string]$_.AccountName
                Service      = [string]$_.ServiceClass
                Port         = [string]$_.Port
                SPN          = [string]$_.SPN
            }
        } | Out-UDGridData
    }
}

# ud-cmwt

CMWT built on Universal Dashboard Community Edition

## Requirements

* PowerShell module: UniversalDashboard.Community (2.5.3 or later)
* PowerShell module: DbaTools (1.0 or later)
* PowerShell module: AdsiPS (1.0.0.7 or later)
* Windows 7 or later with PowerShell 5.1 or later
* Admin access to a Configuration Manager Current Branch site (on-prem, same AD domain)
* Admin access to the SQL Server instance for the ConfigMgr site
* Admin or User Admin access to an AzureAD tenant/subscription

## Examples

Install modules

```powershell
Install-Module UniversalDashboard.Community # or download
Install-Module ud-cmwt
```

Launch CMWT on port 8080 and access at "http://localhost:8080"

```powershell
$cred = Get-Credential # enter AzureAD credentials
Start-UDCmwtDashboard -Server "cm01" -SiteCode "P01" -Credential $cred
```

Launch CMWT on port 10001 at "http://localhost:10001"

```powershell
$cred = Get-Credential # enter AzureAD credentials
Start-UDCmwtDashboard -Server "cm01" -SiteCode "P01" -Credential $cred -Port 10001
```

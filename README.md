# ud-cmwt

CMWT built on Universal Dashboard Community Edition

* Note: This is not yet a published module.
* Download/Extract/Import-Module required for now.

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

Prepare a configuration JSON file

```powershell
Set-CmwtConfigJson -SmsProvider "CM01" -SqlHost "CM01" -SiteCode "CM01"
```

Prepare an AzureAD credentials file

```powershell
Export-CmwtCredential
```

Launch CMWT

```powershell
Start-UDCmwtDashboard
```

Refer to the [docs](https://github.com/Skatterbrainz/ud-cmwt/tree/master/doc) folder of this repositor for function examples and details.

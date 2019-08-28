# ud-cmwt

CMWT built on UniversalDashboard.Community Edition PowerShell module.


## Requirements

* PowerShell module: UniversalDashboard.Community (2.5.3 or later)
* Windows 7 or later with PowerShell 5.1 or later
* Admin access to a Configuration Manager Current Branch site (on-prem, same AD domain)
* Admin access to the SQL Server instance for the ConfigMgr site
* Admin or User Admin access to an AzureAD tenant/subscription

## Installation / Setup

* Open a PowerShell console (Run as Administrator) - Install the module
* Run the ```Set-CmwtConfigJson``` function to configure base settings.
* Run the ```Export-CmwtCredential``` function to store your AzureAD/Office365 credentials.
* Run the ```Start-UDCmwtDashboard``` function to start the web service.
* Open your browser and open "http://localhost:XXXX" (where XXXX is your chosen port number).
* Gaze in awe. Make jokes. Bitch and moan. Scoff and ridicule.  Submit feedback!

## Removal (In case you don't like it)

* Open a PowerShell console (Run as Administrator) - ```Uninstall-Module ud-cmwt```
* Delete the leftover .json configuration and credential files.

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

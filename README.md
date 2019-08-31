# ud-cmwt

CMWT built on [UniversalDashboard](https://universaldashboard.io/) Community Edition, PowerShell module.


## Requirements

* PowerShell module: [UniversalDashboard.Community](https://universaldashboard.io/) (2.5.3 or later)
* Windows 7 or later with PowerShell 5.1 or later
* Permissions/Rights:
  * Full Administrator rights to a Configuration Manager Current Branch site (on-prem, same AD domain)
  * Server or System Administrator rights to the SQL Server instance for the ConfigMgr site
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

## More Information

* Refer to the [docs](https://github.com/Skatterbrainz/ud-cmwt/tree/master/doc) folder of this repositor for function examples and details.
* Click on the [Wiki](https://github.com/Skatterbrainz/ud-cmwt/wiki) link for more information about this project and how it can be used.

## Support and Feedback

* Please use the [Issues](https://github.com/Skatterbrainz/ud-cmwt/issues) link above to submit any features you'd like to see added or improved in CMWT, or to submit a bug report.
* Visit the [UniversalDashboard Forums](https://forums.universaldashboard.io) for support and information about UniversalDashboard (Enterprise and Community Editions)

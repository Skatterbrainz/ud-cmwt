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

Launch CMWT on default port 8081 and access at "http://localhost:8081"

```powershell
Start-UDCmwtDashboard
```

Launch CMWT on port 10001 at "http://localhost:10001"

```powershell
$cred = Get-Credential # enter AzureAD credentials
Start-UDCmwtDashboard -Port 10001
```

Launch CMWT using command-line parameter values

```powershell
Start-UDCmwtDashboard -SmsProvider "CM01" -SqlHost "CM01" -SiteCode "P01"
```

## Roadmap / Notes

(** available now)

* Assets and Compliance
  * Devices (List**, CrossLink)
  * Device Collections (List**, Members, Add/Remove)
  * Users (List**, CrossLink)
  * User Collections (List**, Members, Add/Remove, Notify)
  * AD Computers (List**, Enable/Disable, ClientTools)
  * AD Users (List**, Enable, Disable, Unlock, Reset, AddGroup, RemoveGroup)
  * AD Security Groups (List**, Members, Add/Remove, Notify)
  * AAD Devices (List**)
  * AAD Users (List**, Notify)
  * AAD Groups (List, Members, Notify)
* Software Library
  * Applications (List**, Details, Content, Deployments)
  * Application Groups (List, Details, Content, Deployments)
  * Packages (List**, Details, Content, Deployments)
  * Software Updates
    * All Updates (List, Details, Groups)
    * Update Groups (List, Details, Members)
    * Update Packages (List**, Details, Members)
    * ADRs (List, Details)
  * Operating Systems
    * OS Images (List**, Details)
    * OS Upgrade Packages (List**, Details)
    * Drivers (List, Details, Packages)
    * Driver Packages (List**, Details, Members)
    * Boot Images (List**, Details, TaskSequences)
    * Task Sequences (List**, Details, Deployments, References)
  * Office 365
    * Office 365 Updates
  * Windows 10
    * Servicing Plans
  * Scripts
* Monitoring
  * Queries
  * Reports
  * Site Status
  * Component Status
  * Update Synchronization
  * App Deployments
  * Update Deployments
  * Client Health
  * Server Health
    * Processes (List**)
    * Services (List**)
    * System Event Logs (List**)
    * Application Event Logs (List)
* Diagnostics
  * Log File Viewer
  * CM Cache Viewer
* Administration
  * Hierarchy
    * Maintenance Tasks
    * Client Installation
    * Site Boundaries
    * Boundary Groups
    * Site Systems
    * Discovery Methods
  * Client Settings
  * Distribution Points
  * Distribution Groups
  * Security - Users
  * Security - Roles
  * Security - Scopes

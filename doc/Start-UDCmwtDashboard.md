---
external help file: ud-cmwt-help.xml
Module Name: ud-cmwt
online version:
schema: 2.0.0
---

# Start-UDCmwtDashboard

## SYNOPSIS
Launch CMWT UniversalDashboard instance

## SYNTAX

```
Start-UDCmwtDashboard [[-ConfigJson] <String>] [[-SmsProvider] <String>] [[-SqlHost] <String>]
 [[-SiteCode] <String>] [[-Credential] <PSCredential>] [[-Port] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Ummmmm, yeah, I just said that.

## EXAMPLES

### EXAMPLE 1
```
Start-UDCmwtDashboard
```

Start CMWT using default parameters from configuration file

### EXAMPLE 2
```
Start-UDCmwtDashboard -ConfigJson ".\myconfig.json"
```

Use specified configuration file

### EXAMPLE 3
```
Start-UDCmwtDashboard -SmsProvider "CM01" -SqlHost "CM01" -SiteCode "P01"
```

Start with direct parameter values

## PARAMETERS

### -ConfigJson
Path to CMWT configuration JSON file.
Default is "($env:USERPROFILE)\documents\cmwt-settings.json"
Use the Set-CmwtConfigJson function to create or update a configuration file.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: $(Join-Path $env:USERPROFILE "documents\cmwt-settings.json")
Accept pipeline input: False
Accept wildcard characters: False
```

### -SmsProvider
Configuration Manager SMS Provider host name
ConfigJson overrides this parameter

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SqlHost
Configuration Manager site database SQL Server host name
ConfigJson overrides this parameter

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SiteCode
Configuration Manager site code
ConfigJson overrides this parameter

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
AzureAD credentials
If omitted, read from AzureAD credentials file

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Port
TCP port to run CMWT instance.
Default is 8081
ConfigJson overrides this parameter

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 8081
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

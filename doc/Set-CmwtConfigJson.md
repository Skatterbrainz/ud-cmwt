---
external help file: ud-cmwt-help.xml
Module Name: ud-cmwt
online version:
schema: 2.0.0
---

# Set-CmwtConfigJson

## SYNOPSIS
Create or Update CMWT configuration settings file

## SYNTAX

```
Set-CmwtConfigJson [-SmsProvider] <String> [-SqlHost] <String> [-SiteCode] <String> [[-Port] <Int32>]
 [[-FilePath] <String>] [-Force] [<CommonParameters>]
```

## DESCRIPTION
Create or Update CMWT configuration settings file

## EXAMPLES

### EXAMPLE 1
```
Set-CmwtConfigJson -SmsProvider "CM01" -SqlHost "CM01" -SiteCode "P01" -Port 8080
```

## PARAMETERS

### -SmsProvider
Configuration Manager SMS Provider hostname

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SqlHost
Configuration Manager site database SQL Server hostname

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SiteCode
Configuration Manager Site Code

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Port
TCP Port to run local instance.
Default is 8081

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 8081
Accept pipeline input: False
Accept wildcard characters: False
```

### -FilePath
JSON configuration file path and filename

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: $(Join-Path $env:USERPROFILE "documents\cmwt-settings.json")
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
{{ Fill Force Description }}

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### JSON file
## NOTES
JSON file can be edited externally if desired

## RELATED LINKS

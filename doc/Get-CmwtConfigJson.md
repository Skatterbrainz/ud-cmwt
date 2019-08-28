---
external help file: ud-cmwt-help.xml
Module Name: ud-cmwt
online version:
schema: 2.0.0
---

# Get-CmwtConfigJson

## SYNOPSIS
Retrieve CMWT configuration settings from JSON file

## SYNTAX

```
Get-CmwtConfigJson [[-FilePath] <String>] [<CommonParameters>]
```

## DESCRIPTION
Retrieve CMWT configuration settings from JSON file

## EXAMPLES

### EXAMPLE 1
```
Get-CmwtConfigJson
```

Returns content from the default JSON file if found

### EXAMPLE 2
```
Get-CmwtConfigJson -FilePath "c:\test\myconfig.json"
```

Returns content from the specified JSON file if found

## PARAMETERS

### -FilePath
JSON configuration file path and filename

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

### Raw contents
## NOTES
JSON file can be edited externally if desired

## RELATED LINKS

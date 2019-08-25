---
external help file: ud-cmwt-help.xml
Module Name: ud-cmwt
online version:
schema: 2.0.0
---

# Import-CmwtCredential

## SYNOPSIS
Import CMWT AzureAD credentials from JSON file

## SYNTAX

```
Import-CmwtCredential [[-FilePath] <String>] [<CommonParameters>]
```

## DESCRIPTION
Import CMWT AzureAD credentials from JSON file created using Export-CmwtCredential

## EXAMPLES

### EXAMPLE 1
```
$aadCred = Import-CmwtCredential
```

## PARAMETERS

### -FilePath
Path and filename.
Default is "$($env:userprofile)\documents\cmwt-aad-cred.json"

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: $(Join-Path -Path $env:USERPROFILE -ChildPath "Documents\cmwt-aad-cred.json")
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

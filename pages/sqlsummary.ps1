New-UDPage -Name "sqlsummary" -Id "sqlsummary" -Content {
    New-UDCard -Id 'card1' -Title "SQL Server Summary Report" -Content {""}
    New-UDRow -Columns {
        New-UDTable -Title "Host Info" -Header @("Property", "Value") -Endpoint {
            $SiteHost = $Cache:ConnectionInfo.Server
            $sqlmem = Get-DbaMaxMemory -SqlInstance $SiteHost
            $hostos = Get-WmiObject -Class Win32_OperatingSystem -ComputerName $SiteHost
            $Data = @(
                [PSCustomObject]@{ name = "HostName"; value = $SiteHost }
                [PSCustomObject]@{ name = "Total Memory"; value = [math]::Round($(($sqlmem.Total*1024*1024)/1GB),2) }
                [PSCustomObject]@{ name = "Max Memory"; value = [math]::Round($(($sqlmem.MaxValue*1024*1024)/1GB),2) }
                [PSCustomObject]@{ name = "Operating System"; value = $hostos.Caption }
                [PSCustomObject]@{ name = "Build Number"; value = $hostos.BuildNumber }
            )
            $Data | Out-UDTableData -Property @("name", "value")
        }
    }
    New-UDRow -Columns {
        New-UDTable -Title "SQL Server Info" -Header @("Property","Value") -Endpoint {
            $bref = Get-DbaBuildReference -SqlInstance $Cache:ConnectionInfo.Server
            $Data = @(
                [pscustomobject]@{Property = "HostName"; Value = [string]$bref.SqlInstance }
                [pscustomobject]@{Property = "Version"; Value = [string]$bref.Version }
                [pscustomobject]@{Property = "Build"; Value = [string]$bref.Build }
                [pscustomobject]@{Property = "Service Pack"; Value = [string]$bref.ServicePack }
                [pscustomobject]@{Property = "CU Level"; Value = [string]$bref.CULevel }
                [pscustomobject]@{Property = "KB Level"; Value = [string]$bref.KBLevel }
                [pscustomobject]@{Property = "End Of Support"; Value = $bref.SupportedUntil.ToString('MM/dd/yyyy')  }
            )
            $Data | Out-UDTableData -Property @("Property","Value")
        }
    }
    New-UDRow -Columns {
        New-UDTable -Title "Logical Disks" -Header @("DriveID","Label","Type","Size","Free","Used") -Endpoint {
            $SiteHost = $Cache:ConnectionInfo.Server
            $disks  = Get-WmiObject -Class Win32_LogicalDisk -ComputerName $SiteHost
            $disks | Foreach-Object {
                $size = ($_.Size / 1GB)
                $free = ($_.FreeSpace / 1GB)
                $used = $size - $free
                if ($used -gt 0) {
                    $pct = "$([math]::Round(($used / $size) * 100, 0))`%"
                }
                else {
                    $pct = ""
                }
                switch ($_.DriveType) {
                    2 {$dtype = "Floppy"}
                    3 {$dtype = "Fixed"}
                    5 {$dtype = "Removable"}
                    default {$dtype = "Other"}
                }
                [PSCustomObject]@{
                    DriveID = [string]$_.DeviceID
                    Label   = [string]$_.VolumeName
                    Type    = [string]$dtype
                    Size    = New-UDElement -Tag 'div' -Attributes @{ style = @{'textAlign' = 'right'} } -Content { [string]"$([math]::Round($size,2)) GB" }
                    Free    = New-UDElement -Tag 'div' -Attributes @{ style = @{'textAlign' = 'right'} } -Content { [string]"$([math]::Round($free,2)) GB" }
                    Used    = New-UDElement -Tag 'div' -Attributes @{ style = @{'textAlign' = 'right'} } -Content { $pct }
                }
            } | Out-UDTableData -Property @("DriveID","Label","Type","Size","Free","Used")
        }
    }
    New-UDRow -Columns {
        New-UDColumn -Endpoint {
            #$hostcs = Get-WmiObject -Class Win32_ComputerSystem -ComputerName $SiteHost
            #$nics   = Get-WmiObject -Class Win32_NetworkAdapterConfiguration -ComputerName $SiteHost
            ""
        }
    }
}
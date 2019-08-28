New-UDPage -Name "sqlsummary" -Id "sqlsummary" -Content {
    New-UDCard -Id 'card1' -Title "SQL Server Summary Report" -Content {""}
    New-UDRow -Columns {
        New-UDColumn -Endpoint {
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
        } # column
        New-UDColumn -Endpoint {
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
        } # column
    }
    New-UDRow -Columns {
        New-UDColumn -Endpoint {
            $props = @("DriveID","Label","Type","Size","Free")
            New-UDTable -Title "Logical Disks" -Header $props -Endpoint {
                $SiteHost = $Cache:ConnectionInfo.Server
                $disks  = Get-WmiObject -Class Win32_LogicalDisk -ComputerName $SiteHost
                $disks | Foreach-Object {
                    $size = [math]::Round($_.Size / 1GB, 2)
                    $free = [math]::Round($_.FreeSpace / 1GB, 2)
                    switch ($_.DriveType) {
                        2 {$dtype = "Floppy"}
                        3 {$dtype = "Fixed"}
                        5 {$dtype = "Removable"}
                        default {$dypte = "Other"}
                    }
                    [PSCustomObject]@{
                        DriveID = [string]$_.DeviceID
                        Label   = [string]$_.VolumeName
                        Type    = [string]$dtype
                        Size    = [string]"$size GB"
                        Free    = [string]"$free GB"
                    }
                } | Out-UDTableData -Property $props
            }
        } # column
        New-UDColumn -Endpoint {
            #$hostcs = Get-WmiObject -Class Win32_ComputerSystem -ComputerName $SiteHost
            #$nics   = Get-WmiObject -Class Win32_NetworkAdapterConfiguration -ComputerName $SiteHost
            ""
        }
    }
}
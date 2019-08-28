New-UDPage -Name "cmwtinfo" -Title "CMWT System Information" -Content {
    New-UDCard -Id 'card1' -Title "CMWT System Information" -Horizontal -Content {
        New-UDRow -Columns {
            New-UDColumn -Endpoint {
                New-UDTable -Title "Host Info" -Header @("Property", "Value") -Endpoint {
                    $Data = @(
                        [PSCustomObject]@{ name = "HostName"; value = $env:COMPUTERNAME }
                        [PSCustomObject]@{ name = "UserName"; value = $env:USERNAME }
                        [PSCustomObject]@{ name = "User Domain"; value = $env:USERDNSDOMAIN }
                        [PSCustomObject]@{ name = "OperatingSystem"; value = $(Get-WmiObject -Class Win32_OperatingSystem).Caption }
                        [PSCustomObject]@{ name = "Build Number"; value = $(Get-WmiObject -Class Win32_OperatingSystem).BuildNumber }
                        [PSCustomObject]@{ name = "Make/Model"; value = "$((Get-WmiObject -Class Win32_ComputerSystem).Manufacturer) $((Get-WmiObject -Class Win32_ComputerSystem).Model)" }
                    )
                    $Data | Out-UDTableData -Property @("name", "value")
                }
            }
            New-UDColumn -Endpoint {
                New-UDTable -Title "Settings" -Header @("Name", "Value") -Endpoint {
                    $Data = @(
                        [PSCustomObject]@{ name = "SMS Provider"; value = [string]$Cache:ConnectionInfo.SmsProvider }
                        [PSCustomObject]@{ name = "SiteCode"; value = [string]$Cache:ConnectionInfo.SiteCode }
                        [PSCustomObject]@{ name = "Sql Host"; value = [string]$Cache:ConnectionInfo.Server }
                        [PSCustomObject]@{ name = "Database"; value = [string]$Cache:ConnectionInfo.CmDatabase }
                        [PSCustomObject]@{ name = "AzureAD User"; value = [string]$Cache:CMWT.AzUsername }
                        [PSCustomObject]@{ name = "AzureAD Domain"; value = [string]$Cache:CMWT.AzDomain }
                        [PSCustomObject]@{ name = "Module Path"; value = [string]$Cache:ConnectionInfo.BasePath }
                    )
                    $Data | Out-UDTableData -Property @("name", "value")
                }
            }
            New-UDColumn -Endpoint {
                New-UDTable -Title "PowerShell Modules" -Header @("Name", "Version") -Endpoint {
                    $Data = @(
                        [PSCustomObject]@{ name = "UniversalDashboard.Community"; version = [string]$((Get-Module 'UniversalDashboard.Community').Version -join '.') }
                        [PSCustomObject]@{ name = "DbaTools"; version = [string]$((Get-Module 'dbatools' -ListAvailable | Select -First 1).Version -join '.') }
                        [PSCustomObject]@{ name = "AdsiPS"; version = [string]$((Get-Module 'adsips' -ListAvailable | Select -First 1).Version -join '.') }
                        [PSCustomObject]@{ name = "MSOnline"; version = [string]$((Get-Module 'msonline' -ListAvailable | Select -First 1).Version -join '.') }
                    )
                    $Data | Out-UDTableData -Property @("name", "version")
                }
            }
        }
    }
    New-UdChart -Title "Virtual Memory Size" -Type Bar -Endpoint {
        Get-Process | Get-Random -Count 10 |  Out-UDChartData -LabelProperty "Name" -Dataset @(
            $ds1 = New-UdChartDataset -DataProperty "VirtualMemorySize" -Label "Size" -BackgroundColor "#80962F23" -HoverBackgroundColor "#80962F23"
            $ds1.type = 'bar'
            $ds2 = New-UdChartDataset -DataProperty "PeakVirtualMemorySize" -Label "Free Space" -BackgroundColor "#8014558C" -HoverBackgroundColor "#8014558C"
            $ds2.type = 'line'
            $ds1
            $ds2
        )
    }
}
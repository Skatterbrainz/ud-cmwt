New-UDPage -Name "sqldbccmem" -Id 'sqldbccmem' -Content {
    New-UDGrid -Title "SQL Server DBCC Memory Status" -Endpoint {
        $SiteHost = $Cache:ConnectionInfo.Server
        Get-DbaDbccMemoryStatus -SqlInstance $SiteHost | Foreach-Object {
            [pscustomobject]@{
                Name         = [string]$_.Name
                ValueType    = [string]$_.ValueType
                TypeName     = [string]$_.Type
                Value        = [string]$_.Value
                ComputerName = [string]$_.ComputerName
                Instance     = [string]$_.InstanceName
            }
        }| Out-UDGridData
    }
}
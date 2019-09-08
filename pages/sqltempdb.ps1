New-UDPage -Name "sqltempdb" -Title "CMWT" -Endpoint {
    New-UDGrid -Title "SQL TempDb Information" -Endpoint {
        $SiteHost = $Cache:ConnectionInfo.Server
        Get-DbaTempdbUsage -SqlInstance $SiteHost -EnableException | Foreach-Object {
            [pscustomobject]@{
                ComputerName = [string]$_.ComputerName
                Instance     = [string]$_.InstanceName
                SPID         = [string]$_.Spid
                Statement    = [string]$_.StatementCommand
                AllocatedKB  = [int]$_.InternalAllocatedKB
                InternalKB   = [int]$_.TotalInternalAllocatedKB
                Reads        = [int]$_.RequestedReads
                Writes       = [int]$_.RequestedWrites
                LogicalReads = [int]$_.RequestedLogicalReads
                CPUTime      = [int]$_.RequestedCPUTime
                Status       = [string]$_.Status
                Database     = [string]$_.Database
            }
        } | Out-UDGridData
    }
}
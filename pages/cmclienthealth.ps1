New-UDPage -Name "cmclienthealth" -Content {
    New-UDGrid -Title "ConfigMgr Client Health" -Endpoint {
        $qname    = "cmclienthealthsummary.sql"
        $SiteHost = $Cache:ConnectionInfo.Server
        $Database = $Cache:ConnectionInfo.CmDatabase
		$BasePath = $Cache:ConnectionInfo.QfilePath
		$qfile    = Join-Path $BasePath $qname
        Invoke-DbaQuery -SqlInstance $SiteHost -Database $Database -File $qfile |
            Select-Object ComputerName,UserName,LastHW,LastSW,HwInvAge,SwInvAge,ClientRemediationSuccess |
                Out-UDGridData
    }
}
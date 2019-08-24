New-UDPage -Name "CMSupSynch" -Icon app_store -Content {
	New-UDGrid -Title "Configuration Manager SUP Synchronization Status" -Endpoint {
        $SiteHost = $Cache:ConnectionInfo.Server
        $SiteCode = $Cache:ConnectionInfo.SiteCode
        $query = "WSUSServerName,
WSUSSourceServer as ParentServer,
SiteCode,
SyncCatalogVersion as CatalogVersion,
LastSuccessfulSyncTime as LastSuccess,
LastSyncState,
LastSyncStateTime as LastSyncTime,
LastSyncErrorCode as LastSyncError,
ReplicationLinkStatus as RepLinkStatus,
LastReplicationLinkCheckTime as LastLinkChk
FROM dbo.vSMS_SUPSyncStatus"
        Invoke-DbaQuery -SqlInstance $SiteHost -Database "CM_$SiteCode" -Query $query |
            Out-UDGridData
    }
}

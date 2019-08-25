select distinct
    WSUSServerName,
    WSUSSourceServer as ParentServer,
    SiteCode,
    SyncCatalogVersion as CatalogVersion,
    LastSuccessfulSyncTime as LastSuccess,
    LastSyncState,
    LastSyncStateTime as LastSyncTime,
    LastSyncErrorCode as LastSyncError,
    ReplicationLinkStatus as RepLinkStatus,
    LastReplicationLinkCheckTime as LastLinkChk
FROM
    dbo.vSMS_SUPSyncStatus
order by
    WSUSServerName

New-UDPage -Name "CMUCollections" -Icon desktop -Content {
	New-UDGrid -Title "Configuration Manager User Collections" -Endpoint {
        $SiteHost = $Cache:ConnectionInfo.Server
        $SiteCode = $Cache:ConnectionInfo.SiteCode
        $query = "select distinct Name,
CollectionID as ID,Comment,
membercount as Members 
from v_collection where CollectionType = 1
order by Name"
        Invoke-DbaQuery -SqlInstance $SiteHost -Database "CM_$SiteCode" -Query $query | 
            Select Name,ID,Comment,Members | Out-UDGridData
    }
}

New-UDPage -Name "CMCollections" -Icon desktop -Content {
	New-UDGrid -Title "CM Collections" -Endpoint {
        $SiteHost = $Cache:ConnectionInfo.Server
        $SiteCode = $Cache:ConnectionInfo.SiteCode
        $query = "select distinct Name,
CollectionID as ID,Comment,
case 
when (collectiontype = 2) then 'Device'
when (collectiontype = 1) then 'User' 
else 'Other' end as [Type],
membercount as Members 
from v_collection"
        Invoke-DbaQuery -SqlInstance $SiteHost -Database "CM_$SiteCode" -Query $query | 
            Select Name,ID,Type,Comment,Members | Out-UDGridData
    }
}

SELECT DISTINCT
	ResourceID,
	DeviceID0 as Drive,
	VolumeName0 as Label,
	Description0 as Description,
	COALESCE (Size0, 0) as Size,
	COALESCE (FreeSpace0, 0) as FreeSpace,
	(COALESCE (Size0, 0) - COALESCE (FreeSpace0, 0)) as Used,
	FileSystem0 as FileSystem,
	case when (Compressed0 = 1) then 'Yes' else 'No' end as Copmressed,
    VolumeSerialNumber0 as SerialNum
FROM v_GS_LOGICAL_DISK
ORDER BY ResourceID
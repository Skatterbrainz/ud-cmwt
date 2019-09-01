SELECT DISTINCT
    ResourceID,
    Name0 as Name,
    Manufacturer0 as Manufacturer,
    DataWidth0 as Bits,
    MaxClockSpeed0 as MaxClock,
    NumberOfCores0 as Cores,
    NumberOfLogicalProcessors0 as LogicalProcs,
    case when (IsVitualizationCapable0 = 1) then 'Yes' else 'No' end as VMCapable
FROM v_GS_PROCESSOR
ORDER BY ResourceID
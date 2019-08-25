select distinct
    Name,
    PackageID,
    Version,
    Description,
    PkgSourcePath,
    PackageType
FROM
    dbo.v_Package
ORDER BY
    Name
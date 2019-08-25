select distinct
    SoftwareName,
    AssignmentID,
    CollectionName,
    CollectionID,
    DeploymentTime,
    CreationTime,
    ModificationTime,
    case
        when (featuretype = 1) then 'Application'
        when (featuretype = 2) then 'Program'
        when (featuretype = 3) then 'MobileProgram'
        when (featuretype = 4) then 'Script'
        when (featuretype = 5) then 'SoftwareUpdate'
        when (featuretype = 6) then 'Baseline'
        when (featuretype = 7) then 'TaskSequence'
        when (featuretype = 8) then 'ContentDistribution'
        when (featuretype = 9) then 'DistributionPointGroup'
        when (featuretype = 10) then 'DistributionPointHealth'
        when (featuretype = 11) then 'ConfigurationPolicy'
        when (featuretype = 28) then 'AbstractConfigurationItem'
    end as FeatureType,
    SummaryType,
    case
        when (DeploymentIntent = 1) then 'Install'
        when (DeploymentIntent = 2) then 'Uninstall'
        when (DeploymentIntent = 3) then 'Preflight'
        end as DeployIntent,
    EnforcementDeadline,
    NumberTotal as Total,
    NumberSuccess as Success,
    NumberErrors as Failed,
    NumberInProgress as InProgress,
    NumberUnknown as Unknown,
    NumberOther as Other,
    SummarizationTime,
    ProgramName,
    PackageID
from
    dbo.vDeploymentSummary
where
    RTRIM(SoftwareName) <> ''
order by
    SoftwareName
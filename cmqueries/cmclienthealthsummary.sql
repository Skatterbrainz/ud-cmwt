select
    sys.Name0 as 'ComputerName',
    sys.ResourceID,
    sys.User_Name0 as 'UserName',
    sys.Operating_System_Name_and0 AS OSName,
    sys.AD_Site_Name0 AS ADSiteName,
    sys.Client_Version0 AS ClientVersion,
    summ.ClientStateDescription,
    case
        when summ.ClientActiveStatus = 0 then 'Inactive'
        when summ.ClientActiveStatus = 1 then 'Active'
        end as 'ClientActiveStatus',
        summ.LastActiveTime,
    case
        when summ.IsActiveDDR = 0 then 'Inactive'
        when summ.IsActiveDDR = 1 then 'Active'
        end as 'IsActiveDDR',
    case
        when summ.IsActiveHW = 0 then 'Inactive'
        when summ.IsActiveHW = 1 then 'Active'
        end as 'IsActiveHW',
    case
        when summ.IsActiveSW = 0 then 'Inactive'
        when summ.IsActiveSW = 1 then 'Active'
        end as 'IsActiveSW',
    case
        when summ.ISActivePolicyRequest = 0 then 'Inactive'
        when summ.ISActivePolicyRequest = 1 then 'Active'
        end as 'ISActivePolicyRequest',
    case
        when summ.IsActiveStatusMessages = 0 then 'Inactive'
        when summ.IsActiveStatusMessages = 1 then 'Active'
        end as 'IsActiveStatusMessages',
    summ.LastOnline,
    summ.LastDDR,
    summ.LastHW,
    DATEDIFF(dd,summ.LastHW,GETDATE()) as HwInvAge,
    summ.LastSW,
    DATEDIFF(dd,summ.LastSW,GETDATE()) as SwInvAge,
    summ.LastPolicyRequest,
    summ.LastStatusMessage,
    summ.LastHealthEvaluation,
    case
        when LastHealthEvaluationResult = 1 then 'Not Yet Evaluated'
        when LastHealthEvaluationResult = 2 then 'Not Applicable'
        when LastHealthEvaluationResult = 3 then 'Evaluation Failed'
        when LastHealthEvaluationResult = 4 then 'Evaluated Remediated Failed'
        when LastHealthEvaluationResult = 5 then 'Not Evaluated Dependency Failed'
        when LastHealthEvaluationResult = 6 then 'Evaluated Remediated Succeeded'
        when LastHealthEvaluationResult = 7 then 'Evaluation Succeeded'
        end as 'LastResult',
    case
        when LastEvaluationHealthy = 1 then 'Pass'
        when LastEvaluationHealthy = 2 then 'Fail'
        when LastEvaluationHealthy = 3 then 'Unknown'
        end as 'LastEval',
    case
        when summ.ClientRemediationSuccess = 1 then 'Pass'
        when summ.ClientRemediationSuccess = 2 then 'Fail'
        else ''
        end as 'ClientRemediationSuccess',
    summ.ExpectedNextPolicyRequest
from v_CH_ClientSummary summ
    inner join v_R_System sys on summ.ResourceID = sys.ResourceID
order by sys.Name0
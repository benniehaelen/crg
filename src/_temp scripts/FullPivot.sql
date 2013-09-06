SELECT        
	FactRepoKey, 
	RepoDetailsKey, 
	StatusKey, 
	ClientKey, 
	BorrowerKey, 
	VehicleMakeModelKey, 
--	PT.RepoTypeKey, 
	RepoOrderDateKey, 
--	[Closed], 
--    [Closed-Positive Resolution], 
--    [On Hold], 
--    [Open], 
--    [Repossessed], 
    --CASE WHEN RepoTypeBK = 'Vol. Repo' THEN 1 ELSE 0 END AS Voluntary, 
    AdjusterKey, 
    CaseWorkerKey, 
    RecoveryAgentAddressKey
FROM
	(SELECT        
		F.FactRepoKey, 
		F.RepoDetailsKey, 
		F.RepoStatusKey, 
		F.RepoStatusKey AS StatusKey, 
		F.ClientKey, 
		F.BorrowerKey, 
		F.VehicleMakeModelKey, 
        F.RepoTypeKey, 
        F.RepoOrderDateKey, 
        F.AdjusterKey, 
        F.CaseWorkerKey, 
        F.RecoveryAgentAddressKey, 
        RS.StatusBK
     FROM            
		DW.FactRepo F 
			INNER JOIN DW.DimRepoStatus RS ON F.RepoStatusKey = RS.RepoStatusKey 
			INNER JOIN DW.DimRepoType RT ON F.RepoTypeKey = RT.RepoTypeKey) ST 
			
	PIVOT (
		COUNT(RepoStatusKey) FOR ST.StatusBK IN (
										[Closed], 
										[Closed-Positive Resolution], 
										[On Hold], 
										[Open], 
										[Repossessed])) AS PT 
	LEFT JOIN
		DW.DimRepoType RT ON PT.RepoTypeKey = RT.RepoTypeKey
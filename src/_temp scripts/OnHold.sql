USE [Repo.Staging]
GO

SELECT 
	*
FROM
	Staging.RepoTransactions
WHERE 
	 Status = 'On Hold'
	
	AND
	SUBSTRING(HoldDate, 1, 2) = '05' 
	AND
	SUBSTRING(HoldDate, 4, 2) >= '01' 
	AND
	SUBSTRING(HoldDate, 4, 2) <= '31'
	AND
	SUBSTRING(HoldDate, 7, 4) = '2013'
ORDER BY
	CaseNumber
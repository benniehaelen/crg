USE [Repo.Staging]
GO

SELECT 
	*
FROM
	Staging.RepoTransactions
WHERE 
	Status = 'Closed-Positive Resolution' 
	
	AND
	SUBSTRING(CloseDate, 1, 2) = '05' 
	AND
	SUBSTRING(CloseDate, 4, 2) >= '01' 
	AND
	SUBSTRING(CloseDate, 4, 2) <= '31'
	AND
	SUBSTRING(CloseDate, 7, 4) = '2013'
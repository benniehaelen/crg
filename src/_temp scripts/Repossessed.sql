USE [Repo.Staging]
GO

SELECT 
	*
FROM
	Staging.RepoTransactions
WHERE 
	Status = 'Repossessed' 
	
	AND
	SUBSTRING(RepoDate, 1, 2) = '05' 
	AND
	SUBSTRING(RepoDate, 4, 2) >= '01' 
	AND
	SUBSTRING(RepoDate, 4, 2) <= '31'
	AND
	SUBSTRING(RepoDate, 7, 4) = '2013'
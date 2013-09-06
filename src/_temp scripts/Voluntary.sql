USE [Repo.Staging]
GO

SELECT 
	*
FROM
	Staging.RepoTransactions
WHERE 
	RepoType = 'Vol. Repo'
	
	AND
	SUBSTRING(OrderDate, 1, 2) = '05' 
	AND
	SUBSTRING(OrderDate, 4, 2) >= '01' 
	AND
	SUBSTRING(OrderDate, 4, 2) <= '31'
	AND
	SUBSTRING(OrderDate, 7, 4) = '2013'
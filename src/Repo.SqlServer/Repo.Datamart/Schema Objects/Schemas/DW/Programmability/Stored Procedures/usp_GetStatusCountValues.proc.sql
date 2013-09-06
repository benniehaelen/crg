
CREATE PROCEDURE DW.usp_GetStatusCountValues
	@startingYear int,
	@endingYear int,
	@caseWorkerKey int = NULL
AS
	SELECT
		D.MonthKey,
		D.CalendarYear,
		SUBSTRING(D.CalendarMonth, 0, 4) + ' ' + SUBSTRING(D.CalendarMonth, 7, 4) AS CalendarMonth,
		SUM(CASE WHEN R.RepoStatusKey = 1 THEN 1 ELSE 0 END) AS Repossessed,
		SUM(CASE WHEN R.RepoStatusKey = 2 THEN 1 ELSE 0 END) AS OnHold,
		SUM(CASE WHEN R.RepoStatusKey = 3 THEN 1 ELSE 0 END) AS Closed,
		SUM(CASE WHEN R.RepoStatusKey = 4 THEN 1 ELSE 0 END) AS [Open],
		SUM(CASE WHEN R.RepoStatusKey = 5 THEN 1 ELSE 0 END) AS Reassigned,
		SUM(CASE WHEN R.RepoStatusKey = 6 THEN 1 ELSE 0 END) AS NeedInfo,
		SUM(CASE WHEN R.RepoStatusKey = 7 THEN 1 ELSE 0 END) AS ClosedPositiveResolution,
		SUM(CASE WHEN R.RepoStatusKey = 8 THEN 1 ELSE 0 END) AS Completed,
		SUM(CASE WHEN R.RepoStatusKey = 9 THEN 1 ELSE 0 END) AS PendingClose,
		SUM(CASE WHEN R.RepoStatusKey = 10 THEN 1 ELSE 0 END) AS PendingOnHold
	FROM
		DW.DimCalendar D
			INNER JOIN
				DW.FactRepo R ON
					D.CalendarKey = R.OrderDateKey
			INNER JOIN
				DW.DimRepoStatus S ON
					R.RepoStatusKey = S.RepoStatusKey
			INNER JOIN
				DW.DimCaseWorker W ON 
					R.CaseWorkerKey = W.CaseWorkerKey
	WHERE
--		R.RepoStatusKey = @repoStatusKey AND
		D.CalendarYear >= @startingYear AND
		D.CalendarYear <= @endingYear 
		AND
		(R.CaseWorkerKey = @caseWorkerKey OR @caseWorkerKey IS NULL)
	GROUP BY
		D.CalendarYear, D.MonthKey, D.CalendarMonth
	ORDER BY
		D.MonthKey

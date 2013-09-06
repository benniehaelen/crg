
CREATE PROCEDURE DW.GetStatusCountValues
	@repoStatusKey int,
	@startingYear int,
	@endingYear int,
	@caseWorkerKey int = NULL
AS
	SELECT
		D.MonthKey,
		D.CalendarMonth,
		COUNT(R.FactRepoKey)
	FROM
		DW.FactRepo R 
			INNER JOIN
				DW.DimRepoStatus S ON
					R.RepoStatusKey = S.RepoStatusKey
			INNER JOIN
				DW.DimCalendar D ON 
					D.CalendarKey = R.OrderDateKey
								
	WHERE
		R.RepoStatusKey = @repoStatusKey AND
		D.CalendarYear >= @startingYear AND
		D.CalendarYear <= @endingYear 
		AND
		(R.CaseWorkerKey = @caseWorkerKey OR @caseWorkerKey IS NULL)
	GROUP BY
		D.MonthKey, D.CalendarMonth
	ORDER BY
		D.MonthKey

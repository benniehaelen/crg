ALTER TABLE [DW].[FactRepo]
	ADD 
CONSTRAINT [FK_FactRepo_DimCalendar_RepoDateKey] 
	FOREIGN KEY ([RepoDateKey]) 
		REFERENCES [DW].[DimCalendar] ([CalendarKey]);


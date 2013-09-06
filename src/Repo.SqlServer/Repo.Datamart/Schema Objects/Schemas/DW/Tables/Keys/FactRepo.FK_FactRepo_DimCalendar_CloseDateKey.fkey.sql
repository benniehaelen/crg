ALTER TABLE [DW].[FactRepo]
	ADD CONSTRAINT [FK_FactRepo_DimCalendar_CloseDateKey] 
	FOREIGN KEY ([CloseDateKey])
		REFERENCES [DW].[DimCalendar] ([CalendarKey]);


ALTER TABLE [DW].[FactRepo]
	ADD CONSTRAINT [FK_FactRepo_DimCalendar_HoldDateKey] 
	FOREIGN KEY ([HoldDateKey])
		REFERENCES [DW].[DimCalendar] ([CalendarKey]);


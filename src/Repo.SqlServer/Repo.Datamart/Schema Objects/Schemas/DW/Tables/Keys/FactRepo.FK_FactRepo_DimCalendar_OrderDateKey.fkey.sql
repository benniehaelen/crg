ALTER TABLE [DW].[FactRepo]
	ADD CONSTRAINT [FK_FactRepo_DimCalendar_OrderDateKey] 
	FOREIGN KEY ([OrderDateKey])
		REFERENCES [DW].[DimCalendar] ([CalendarKey]);


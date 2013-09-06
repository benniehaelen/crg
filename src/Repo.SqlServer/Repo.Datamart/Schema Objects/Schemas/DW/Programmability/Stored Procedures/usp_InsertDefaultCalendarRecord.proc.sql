CREATE PROCEDURE [DW].[usp_InsertDefaultCalendarRecord]
	@calendarKey int
AS
BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Delete the previous default record
	DELETE FROM [Repo.Datamart].[DW].[DimCalendar]
		  WHERE CalendarKey < 1;

	-- Insert default record
	INSERT INTO [Repo.Datamart].[DW].[DimCalendar]
           ([CalendarKey]
           ,[CalendarDate]
           ,[CalendarWeek]
           ,[WeekKey]
           ,[CalendarMonth]
           ,[MonthKey]
           ,[CalendarQuarter]
           ,[QuarterKey]
           ,[CalendarYear])
     VALUES
           (@calendarKey
           ,'1/1/2000'
           ,'2000 - Week 1'
           ,200001
           ,'Jan 2000'
           ,200001
           ,'Q1 2000'
           ,200001
           ,2000);


END
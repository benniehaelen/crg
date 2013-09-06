CREATE TABLE [DW].[DimCalendar] (
    [CalendarKey]     INT          NOT NULL,
    [CalendarDate]    DATETIME     NOT NULL,
    [CalendarWeek]    VARCHAR (20) NOT NULL,
    [WeekKey]         INT          NOT NULL,
    [CalendarMonth]   VARCHAR (20) NOT NULL,
    [MonthKey]        INT          NOT NULL,
    [CalendarQuarter] VARCHAR (20) NOT NULL,
    [QuarterKey]      INT          NOT NULL,
    [CalendarYear]    INT          NOT NULL
);


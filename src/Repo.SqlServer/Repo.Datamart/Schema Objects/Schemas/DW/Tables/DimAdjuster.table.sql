CREATE TABLE [DW].[DimAdjuster] (
    [AdjusterKey]    INT           IDENTITY (1, 1) NOT NULL,
    [AdjusterName]   VARCHAR (250) NOT NULL,
    [InsertAuditKey] INT           NOT NULL,
    [UpdateAuditKey] INT           NULL
);


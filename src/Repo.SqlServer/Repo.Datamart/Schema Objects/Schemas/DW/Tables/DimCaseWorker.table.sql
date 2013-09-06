CREATE TABLE [DW].[DimCaseWorker] (
    [CaseWorkerKey]  INT           IDENTITY (1, 1) NOT NULL,
    [CaseWorkerName] VARCHAR (100) NOT NULL,
    [InsertAuditKey] INT           NOT NULL,
    [UpdateAuditKey] INT           NULL
);


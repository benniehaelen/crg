CREATE TABLE [DW].[DimDisposition] (
    [DispositionKey] INT          IDENTITY (1, 1) NOT NULL,
    [DispositionBK]  VARCHAR (25) NOT NULL,
    [InsertAuditKey] INT          NOT NULL,
    [UpdateAuditKey] INT          NOT NULL
);


CREATE TABLE [DW].[DimLienHolder] (
    [LienHolderKey]  INT          IDENTITY (1, 1) NOT NULL,
    [LienHolderBK]   VARCHAR (50) NOT NULL,
    [InsertAuditKey] INT          NOT NULL,
    [UpdateAuditKey] INT          NULL
);


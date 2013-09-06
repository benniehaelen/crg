CREATE TABLE [DW].[DimBorrower] (
    [BorrowerKey]           INT           IDENTITY (1, 1) NOT NULL,
    [BorrowerName]          VARCHAR (75)  NOT NULL,
    [BorrowerMiddleInitial] VARCHAR (50)  NULL,
    [HomePhone]             VARCHAR (15)  NULL,
    [HomeAddressKey]        INT           NOT NULL,
    [WorkAddress]           VARCHAR (100) NULL,
    [InsertAuditKey]        INT           NOT NULL,
    [UpdateAuditKey]        INT           NULL
);


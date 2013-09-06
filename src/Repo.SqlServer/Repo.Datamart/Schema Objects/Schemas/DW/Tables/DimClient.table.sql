CREATE TABLE [DW].[DimClient] (
    [ClientKey]      INT          IDENTITY (1, 1) NOT NULL,
    [ClientName]     VARCHAR (50) NOT NULL,
    [AddressKey]     INT          NOT NULL,
    [ClientPhone]    VARCHAR (50) NULL,
    [InsertAuditKey] INT          NOT NULL,
    [UpdateAuditKey] INT          NULL
);


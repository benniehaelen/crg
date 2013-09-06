CREATE TABLE [DW].[DimAddress] (
    [AddressKey]     INT           IDENTITY (1, 1) NOT NULL,
    [StreetAddress]  VARCHAR (250) NOT NULL,
    [City]           VARCHAR (50)  NOT NULL,
    [StateCode]      VARCHAR (50)  NOT NULL,
    [ZipCode]        VARCHAR (10)  NOT NULL,
    [InsertAuditKey] INT           NOT NULL,
    [UpdateAuditKey] INT           NULL
);


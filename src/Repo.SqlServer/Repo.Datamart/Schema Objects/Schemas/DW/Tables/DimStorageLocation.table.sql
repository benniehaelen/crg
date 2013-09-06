CREATE TABLE [DW].[DimStorageLocation] (
    [StorageLocationKey]  INT           IDENTITY (1, 1) NOT NULL,
    [StorageLocationName] VARCHAR (150) NOT NULL,
    [AddressKey]          INT           NOT NULL,
    [InsertAuditKey]      INT           NOT NULL,
    [UpdateAuditKey]      INT           NOT NULL
);


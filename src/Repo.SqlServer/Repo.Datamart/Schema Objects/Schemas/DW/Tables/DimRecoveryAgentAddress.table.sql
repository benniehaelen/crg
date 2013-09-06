CREATE TABLE [DW].[DimRecoveryAgentAddress] (
    [RecoveryAgentAddressKey] INT IDENTITY (1, 1) NOT NULL,
    [RecoveryAgentKey]        INT NOT NULL,
    [AddressKey]              INT NOT NULL,
    [InsertAuditKey]          INT NOT NULL,
    [UpdateAuditKey]          INT NULL
);


CREATE TABLE [DW].[DimRepoSubStatus] (
    [RepoSubStatusKey]     INT           IDENTITY (1, 1) NOT NULL,
    [SubStatusBK]          VARCHAR (200) NOT NULL,
    [SubStatusDescription] VARCHAR (150) NULL,
    [InsertAuditKey]       INT           NOT NULL,
    [UpdateAuditKey]       INT           NOT NULL
);


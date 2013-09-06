CREATE TABLE [DW].[DimRepoType] (
    [RepoTypeKey]         INT           IDENTITY (1, 1) NOT NULL,
    [RepoTypeBK]          VARCHAR (50)  NOT NULL,
    [RepoTypeDescription] VARCHAR (100) NULL,
    [InsertAuditKey]      INT           NOT NULL,
    [UpdateAuditKey]      INT           NULL
);


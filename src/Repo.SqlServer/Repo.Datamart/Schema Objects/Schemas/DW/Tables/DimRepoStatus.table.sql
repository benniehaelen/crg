CREATE TABLE [DW].[DimRepoStatus] (
    [RepoStatusKey]     INT          IDENTITY (1, 1) NOT NULL,
    [StatusBK]          VARCHAR (50) NOT NULL,
    [StatusDescription] VARCHAR (50) NULL,
    [InsertAuditKey]    INT          NOT NULL,
    [UpdateAuditKey]    INT          NULL
);


CREATE TABLE [DW].[DimRepoAge] (
    [RepoAgeKey]     INT          NOT NULL,
    [RepoAge]        VARCHAR (75) NOT NULL,
    [InsertAuditKey] INT          NOT NULL,
    [UpdateAuditKey] INT          NULL
);


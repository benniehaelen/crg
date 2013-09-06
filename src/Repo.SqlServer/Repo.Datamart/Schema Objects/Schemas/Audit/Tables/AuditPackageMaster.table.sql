CREATE TABLE [Audit].[AuditPackageMaster] (
    [MasterKey]                 INT            IDENTITY (1, 1) NOT NULL,
    [PackageStartDate]          DATETIME       NOT NULL,
    [PackageEndDate]            DATETIME       NULL,
    [PackageName]               NVARCHAR (50)  NOT NULL,
    [PackageGUID]               NVARCHAR (50)  NOT NULL,
    [PackageVersionGUID]        NVARCHAR (50)  NOT NULL,
    [ProcessSucessfulIndicator] BIT            NOT NULL,
    [OptFileName]               NVARCHAR (100) NULL
);


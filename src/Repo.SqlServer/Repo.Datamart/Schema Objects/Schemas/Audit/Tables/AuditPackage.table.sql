CREATE TABLE [Audit].[AuditPackage] (
    [AuditKey]                  INT           IDENTITY (1, 1) NOT NULL,
    [MasterKey]                 INT           NULL,
    [PackageName]               NVARCHAR (50) NOT NULL,
    [PackageGUID]               NVARCHAR (50) NOT NULL,
    [PackageBuild]              INT           NOT NULL,
    [PackageVersionMajor]       INT           NOT NULL,
    [PackageVersionMinor]       INT           NOT NULL,
    [PackageStartDate]          DATETIME      NOT NULL,
    [PackageEndDate]            DATETIME      NULL,
    [ProcessSucessfulIndicator] BIT           NOT NULL,
    [AdditionalInfo]            VARCHAR (250) NULL
);


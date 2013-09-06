CREATE TABLE [DW].[DimRepoDetails] (
    [RepoDetailsKey]  INT          IDENTITY (1, 1) NOT NULL,
    [CaseNumber]      VARCHAR (50) NOT NULL,
    [ReferenceNumber] VARCHAR (50) NULL,
    [VIN]             VARCHAR (50) NULL,
    [VehicleLicense]  VARCHAR (50) NULL,
    [VehicleMileage]  VARCHAR (50) NULL,
    [CR]              VARCHAR (50) NULL,
    [Drivable]        VARCHAR (50) NULL,
    [Invoice]         VARCHAR (50) NULL,
    [Keys]            VARCHAR (50) NULL,
    [Personals]       VARCHAR (50) NULL,
    [Photos]          VARCHAR (50) NULL,
    [InsertAuditKey]  INT          NOT NULL,
    [UpdateAuditKey]  INT          NULL
);


/*
Deployment script for Repo.Datamart
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
--setvar Path1 "C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\"
--setvar Path2 "C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\"
--setvar DatabaseName "Repo.Datamart"
--setvar DefaultDataPath ""
--setvar DefaultLogPath ""

GO
:on error exit
GO
USE [master]
GO
IF (DB_ID(N'$(DatabaseName)') IS NOT NULL
    AND DATABASEPROPERTYEX(N'$(DatabaseName)','Status') <> N'ONLINE')
BEGIN
    RAISERROR(N'The state of the target database, %s, is not set to ONLINE. To deploy to this database, its state must be set to ONLINE.', 16, 127,N'$(DatabaseName)') WITH NOWAIT
    RETURN
END

GO
IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Creating $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [Repo.Datamart], FILENAME = '$(Path2)$(DatabaseName).mdf', FILEGROWTH = 1024 KB)
    LOG ON (NAME = [Repo.Datamart_log], FILENAME = '$(Path1)$(DatabaseName)_1.LDF', MAXSIZE = 2097152 MB, FILEGROWTH = 10 %) COLLATE SQL_Latin1_General_CP1_CI_AS
GO
EXECUTE sp_dbcmptlevel [$(DatabaseName)], 100;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'The database settings cannot be modified. You must be a SysAdmin to apply these settings.';
    END


GO
USE [$(DatabaseName)]
GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
/*
 Pre-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be executed before the build script.	
 Use SQLCMD syntax to include a file in the pre-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the pre-deployment script.		
 Example:      --setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

GO
PRINT N'Creating [Audit]...';


GO
CREATE SCHEMA [Audit]
    AUTHORIZATION [dbo];


GO
PRINT N'Creating [DW]...';


GO
CREATE SCHEMA [DW]
    AUTHORIZATION [dbo];


GO
PRINT N'Creating [Audit].[AuditPackage]...';


GO
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


GO
PRINT N'Creating PK_AuditPackage...';


GO
ALTER TABLE [Audit].[AuditPackage]
    ADD CONSTRAINT [PK_AuditPackage] PRIMARY KEY CLUSTERED ([AuditKey] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);


GO
PRINT N'Creating [Audit].[AuditPackageMaster]...';


GO
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


GO
PRINT N'Creating PK_AuditPackageMaster...';


GO
ALTER TABLE [Audit].[AuditPackageMaster]
    ADD CONSTRAINT [PK_AuditPackageMaster] PRIMARY KEY CLUSTERED ([MasterKey] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);


GO
PRINT N'Creating [DW].[DataLoadDate]...';


GO
CREATE TABLE [DW].[DataLoadDate] (
    [DataLoadDate] DATETIME NOT NULL
);


GO
PRINT N'Creating [DW].[DimAddress]...';


GO
CREATE TABLE [DW].[DimAddress] (
    [AddressKey]     INT           IDENTITY (1, 1) NOT NULL,
    [StreetAddress]  VARCHAR (250) NOT NULL,
    [City]           VARCHAR (50)  NOT NULL,
    [StateCode]      VARCHAR (50)  NOT NULL,
    [ZipCode]        VARCHAR (10)  NOT NULL,
    [InsertAuditKey] INT           NOT NULL,
    [UpdateAuditKey] INT           NULL
);


GO
PRINT N'Creating PK_DimAddress...';


GO
ALTER TABLE [DW].[DimAddress]
    ADD CONSTRAINT [PK_DimAddress] PRIMARY KEY CLUSTERED ([AddressKey] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);


GO
PRINT N'Creating [DW].[DimAdjuster]...';


GO
CREATE TABLE [DW].[DimAdjuster] (
    [AdjusterKey]    INT           IDENTITY (1, 1) NOT NULL,
    [AdjusterName]   VARCHAR (250) NOT NULL,
    [InsertAuditKey] INT           NOT NULL,
    [UpdateAuditKey] INT           NULL
);


GO
PRINT N'Creating PK_DimAdjuster...';


GO
ALTER TABLE [DW].[DimAdjuster]
    ADD CONSTRAINT [PK_DimAdjuster] PRIMARY KEY CLUSTERED ([AdjusterKey] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);


GO
PRINT N'Creating [DW].[DimAssignee]...';


GO
CREATE TABLE [DW].[DimAssignee] (
    [AssigneeKey]    INT          IDENTITY (1, 1) NOT NULL,
    [AssigneeBK]     VARCHAR (50) NOT NULL,
    [InsertAuditKey] INT          NOT NULL,
    [UpdateAuditKey] INT          NULL
);


GO
PRINT N'Creating PK_DimAssignee...';


GO
ALTER TABLE [DW].[DimAssignee]
    ADD CONSTRAINT [PK_DimAssignee] PRIMARY KEY CLUSTERED ([AssigneeKey] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);


GO
PRINT N'Creating [DW].[DimBorrower]...';


GO
CREATE TABLE [DW].[DimBorrower] (
    [BorrowerKey]           INT           IDENTITY (1, 1) NOT NULL,
    [BorrowerName]          VARCHAR (75)  NOT NULL,
    [BorrowerMiddleInitial] VARCHAR (50)  NULL,
    [HomePhone]             VARCHAR (15)  NULL,
    [HomeAddressKey]        INT           NOT NULL,
    [WorkAddress]           VARCHAR (100) NULL,
    [InsertAuditKey]        INT           NOT NULL,
    [UpdateAuditKey]        INT           NULL
);


GO
PRINT N'Creating PK_DimBorrower...';


GO
ALTER TABLE [DW].[DimBorrower]
    ADD CONSTRAINT [PK_DimBorrower] PRIMARY KEY CLUSTERED ([BorrowerKey] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);


GO
PRINT N'Creating [DW].[DimCalendar]...';


GO
CREATE TABLE [DW].[DimCalendar] (
    [CalendarKey]     INT          NOT NULL,
    [CalendarDate]    DATETIME     NOT NULL,
    [CalendarWeek]    VARCHAR (20) NOT NULL,
    [WeekKey]         INT          NOT NULL,
    [CalendarMonth]   VARCHAR (20) NOT NULL,
    [MonthKey]        INT          NOT NULL,
    [CalendarQuarter] VARCHAR (20) NOT NULL,
    [QuarterKey]      INT          NOT NULL,
    [CalendarYear]    INT          NOT NULL
);


GO
PRINT N'Creating PK_DimCalendar...';


GO
ALTER TABLE [DW].[DimCalendar]
    ADD CONSTRAINT [PK_DimCalendar] PRIMARY KEY CLUSTERED ([CalendarKey] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);


GO
PRINT N'Creating [DW].[DimCaseWorker]...';


GO
CREATE TABLE [DW].[DimCaseWorker] (
    [CaseWorkerKey]  INT           IDENTITY (1, 1) NOT NULL,
    [CaseWorkerName] VARCHAR (100) NOT NULL,
    [InsertAuditKey] INT           NOT NULL,
    [UpdateAuditKey] INT           NULL
);


GO
PRINT N'Creating PK_DimCaseWorker...';


GO
ALTER TABLE [DW].[DimCaseWorker]
    ADD CONSTRAINT [PK_DimCaseWorker] PRIMARY KEY CLUSTERED ([CaseWorkerKey] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);


GO
PRINT N'Creating [DW].[DimClient]...';


GO
CREATE TABLE [DW].[DimClient] (
    [ClientKey]      INT          IDENTITY (1, 1) NOT NULL,
    [ClientName]     VARCHAR (50) NOT NULL,
    [AddressKey]     INT          NOT NULL,
    [ClientPhone]    VARCHAR (50) NULL,
    [InsertAuditKey] INT          NOT NULL,
    [UpdateAuditKey] INT          NULL
);


GO
PRINT N'Creating PK_DimClient...';


GO
ALTER TABLE [DW].[DimClient]
    ADD CONSTRAINT [PK_DimClient] PRIMARY KEY CLUSTERED ([ClientKey] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);


GO
PRINT N'Creating [DW].[DimDisposition]...';


GO
CREATE TABLE [DW].[DimDisposition] (
    [DispositionKey] INT          IDENTITY (1, 1) NOT NULL,
    [DispositionBK]  VARCHAR (25) NOT NULL,
    [InsertAuditKey] INT          NOT NULL,
    [UpdateAuditKey] INT          NOT NULL
);


GO
PRINT N'Creating PK_DimDisposition...';


GO
ALTER TABLE [DW].[DimDisposition]
    ADD CONSTRAINT [PK_DimDisposition] PRIMARY KEY CLUSTERED ([DispositionKey] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);


GO
PRINT N'Creating [DW].[DimLienHolder]...';


GO
CREATE TABLE [DW].[DimLienHolder] (
    [LienHolderKey]  INT          IDENTITY (1, 1) NOT NULL,
    [LienHolderBK]   VARCHAR (50) NOT NULL,
    [InsertAuditKey] INT          NOT NULL,
    [UpdateAuditKey] INT          NULL
);


GO
PRINT N'Creating PK_DimLienHolder...';


GO
ALTER TABLE [DW].[DimLienHolder]
    ADD CONSTRAINT [PK_DimLienHolder] PRIMARY KEY CLUSTERED ([LienHolderKey] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);


GO
PRINT N'Creating [DW].[DimRecoveryAgent]...';


GO
CREATE TABLE [DW].[DimRecoveryAgent] (
    [RecoveryAgentKey] INT           IDENTITY (1, 1) NOT NULL,
    [AgentName]        VARCHAR (100) NOT NULL,
    [InsertAuditKey]   INT           NOT NULL,
    [UpdateAuditKey]   INT           NULL
);


GO
PRINT N'Creating PK_DimRecoveryAgent...';


GO
ALTER TABLE [DW].[DimRecoveryAgent]
    ADD CONSTRAINT [PK_DimRecoveryAgent] PRIMARY KEY CLUSTERED ([RecoveryAgentKey] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);


GO
PRINT N'Creating [DW].[DimRecoveryAgentAddress]...';


GO
CREATE TABLE [DW].[DimRecoveryAgentAddress] (
    [RecoveryAgentAddressKey] INT IDENTITY (1, 1) NOT NULL,
    [RecoveryAgentKey]        INT NOT NULL,
    [AddressKey]              INT NOT NULL,
    [InsertAuditKey]          INT NOT NULL,
    [UpdateAuditKey]          INT NULL
);


GO
PRINT N'Creating PK_DimRecoveryAgentAddress...';


GO
ALTER TABLE [DW].[DimRecoveryAgentAddress]
    ADD CONSTRAINT [PK_DimRecoveryAgentAddress] PRIMARY KEY CLUSTERED ([RecoveryAgentAddressKey] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);


GO
PRINT N'Creating [DW].[DimRepoAge]...';


GO
CREATE TABLE [DW].[DimRepoAge] (
    [RepoAgeKey]     INT          NOT NULL,
    [RepoAge]        VARCHAR (75) NOT NULL,
    [InsertAuditKey] INT          NOT NULL,
    [UpdateAuditKey] INT          NULL
);


GO
PRINT N'Creating PK_DimRepoAge...';


GO
ALTER TABLE [DW].[DimRepoAge]
    ADD CONSTRAINT [PK_DimRepoAge] PRIMARY KEY CLUSTERED ([RepoAgeKey] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);


GO
PRINT N'Creating [DW].[DimRepoDetails]...';


GO
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


GO
PRINT N'Creating PK_DimRepoDetails...';


GO
ALTER TABLE [DW].[DimRepoDetails]
    ADD CONSTRAINT [PK_DimRepoDetails] PRIMARY KEY CLUSTERED ([RepoDetailsKey] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);


GO
PRINT N'Creating [DW].[DimRepoStatus]...';


GO
CREATE TABLE [DW].[DimRepoStatus] (
    [RepoStatusKey]     INT          IDENTITY (1, 1) NOT NULL,
    [StatusBK]          VARCHAR (50) NOT NULL,
    [StatusDescription] VARCHAR (50) NULL,
    [InsertAuditKey]    INT          NOT NULL,
    [UpdateAuditKey]    INT          NULL
);


GO
PRINT N'Creating PK_DimRepoStatus...';


GO
ALTER TABLE [DW].[DimRepoStatus]
    ADD CONSTRAINT [PK_DimRepoStatus] PRIMARY KEY CLUSTERED ([RepoStatusKey] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);


GO
PRINT N'Creating [DW].[DimRepoSubStatus]...';


GO
CREATE TABLE [DW].[DimRepoSubStatus] (
    [RepoSubStatusKey]     INT           IDENTITY (1, 1) NOT NULL,
    [SubStatusBK]          VARCHAR (200) NOT NULL,
    [SubStatusDescription] VARCHAR (150) NULL,
    [InsertAuditKey]       INT           NOT NULL,
    [UpdateAuditKey]       INT           NOT NULL
);


GO
PRINT N'Creating PK_DimRepoSubStatus...';


GO
ALTER TABLE [DW].[DimRepoSubStatus]
    ADD CONSTRAINT [PK_DimRepoSubStatus] PRIMARY KEY CLUSTERED ([RepoSubStatusKey] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);


GO
PRINT N'Creating [DW].[DimRepoType]...';


GO
CREATE TABLE [DW].[DimRepoType] (
    [RepoTypeKey]         INT           IDENTITY (1, 1) NOT NULL,
    [RepoTypeBK]          VARCHAR (50)  NOT NULL,
    [RepoTypeDescription] VARCHAR (100) NULL,
    [InsertAuditKey]      INT           NOT NULL,
    [UpdateAuditKey]      INT           NULL
);


GO
PRINT N'Creating PK_DimRepoType...';


GO
ALTER TABLE [DW].[DimRepoType]
    ADD CONSTRAINT [PK_DimRepoType] PRIMARY KEY CLUSTERED ([RepoTypeKey] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);


GO
PRINT N'Creating [DW].[DimStorageLocation]...';


GO
CREATE TABLE [DW].[DimStorageLocation] (
    [StorageLocationKey]  INT           IDENTITY (1, 1) NOT NULL,
    [StorageLocationName] VARCHAR (150) NOT NULL,
    [AddressKey]          INT           NOT NULL,
    [InsertAuditKey]      INT           NOT NULL,
    [UpdateAuditKey]      INT           NOT NULL
);


GO
PRINT N'Creating PK_DimStorageLocation...';


GO
ALTER TABLE [DW].[DimStorageLocation]
    ADD CONSTRAINT [PK_DimStorageLocation] PRIMARY KEY CLUSTERED ([StorageLocationKey] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);


GO
PRINT N'Creating [DW].[DimVehicleMakeModel]...';


GO
CREATE TABLE [DW].[DimVehicleMakeModel] (
    [VehicleMakeModelKey] INT           IDENTITY (1, 1) NOT NULL,
    [VehicleMake]         VARCHAR (150) NOT NULL,
    [VehicleModel]        VARCHAR (100) NOT NULL,
    [InsertAuditKey]      INT           NOT NULL,
    [UpdateAuditKey]      INT           NULL
);


GO
PRINT N'Creating PK_DimVehicleMakeModel...';


GO
ALTER TABLE [DW].[DimVehicleMakeModel]
    ADD CONSTRAINT [PK_DimVehicleMakeModel] PRIMARY KEY CLUSTERED ([VehicleMakeModelKey] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);


GO
PRINT N'Creating [DW].[FactRepo]...';


GO
CREATE TABLE [DW].[FactRepo] (
    [FactRepoKey]             INT            IDENTITY (1, 1) NOT NULL,
    [CaseNumber]              VARCHAR (50)   NOT NULL,
    [RepoDetailsKey]          INT            NOT NULL,
    [ClientKey]               INT            NOT NULL,
    [BorrowerKey]             INT            NOT NULL,
    [VehicleMakeModelKey]     INT            NOT NULL,
    [RepoTypeKey]             INT            NOT NULL,
    [RepoStatusKey]           INT            NOT NULL,
    [RepoOrderDateKey]        INT            NOT NULL,
    [CaseWorkerKey]           INT            NOT NULL,
    [AdjusterKey]             INT            NOT NULL,
    [RecoveryAgentAddressKey] INT            NOT NULL,
    [RepoAgeKey]              INT            NOT NULL,
    [AssigneeKey]             INT            NOT NULL,
    [LienHolderKey]           INT            NOT NULL,
    [AccountBalance]          MONEY          NULL,
    [AmountPastDue]           MONEY          NULL,
    [Type1HashValue]          VARBINARY (25) NOT NULL,
    [InsertAuditKey]          INT            NOT NULL,
    [UpdateAuditKey]          INT            NULL
);


GO
PRINT N'Creating PK_FactRepo...';


GO
ALTER TABLE [DW].[FactRepo]
    ADD CONSTRAINT [PK_FactRepo] PRIMARY KEY CLUSTERED ([FactRepoKey] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);


GO
PRINT N'Creating UK_FactRepo_CaseNumber...';


GO
ALTER TABLE [DW].[FactRepo]
    ADD CONSTRAINT [UK_FactRepo_CaseNumber] UNIQUE NONCLUSTERED ([CaseNumber] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF) ON [PRIMARY];


GO
PRINT N'Creating [DW].[FactRepo].[IX_FactRepo_CaseNumber]...';


GO
CREATE NONCLUSTERED INDEX [IX_FactRepo_CaseNumber]
    ON [DW].[FactRepo]([CaseNumber] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF, ONLINE = OFF, MAXDOP = 0)
    ON [PRIMARY];


GO
PRINT N'Creating FK_DimBorrower_DimAddress...';


GO
ALTER TABLE [DW].[DimBorrower] WITH NOCHECK
    ADD CONSTRAINT [FK_DimBorrower_DimAddress] FOREIGN KEY ([HomeAddressKey]) REFERENCES [DW].[DimAddress] ([AddressKey]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating FK_DimClient_DimClientAddress...';


GO
ALTER TABLE [DW].[DimClient] WITH NOCHECK
    ADD CONSTRAINT [FK_DimClient_DimClientAddress] FOREIGN KEY ([AddressKey]) REFERENCES [DW].[DimAddress] ([AddressKey]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating FK_DimRecoveryAgentAddress_DimAddress...';


GO
ALTER TABLE [DW].[DimRecoveryAgentAddress] WITH NOCHECK
    ADD CONSTRAINT [FK_DimRecoveryAgentAddress_DimAddress] FOREIGN KEY ([AddressKey]) REFERENCES [DW].[DimAddress] ([AddressKey]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating FK_DimRecoveryAgentAddress_DimRecoveryAgent...';


GO
ALTER TABLE [DW].[DimRecoveryAgentAddress] WITH NOCHECK
    ADD CONSTRAINT [FK_DimRecoveryAgentAddress_DimRecoveryAgent] FOREIGN KEY ([RecoveryAgentKey]) REFERENCES [DW].[DimRecoveryAgent] ([RecoveryAgentKey]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating FK_DimStorageLocation_DimAddress...';


GO
ALTER TABLE [DW].[DimStorageLocation] WITH NOCHECK
    ADD CONSTRAINT [FK_DimStorageLocation_DimAddress] FOREIGN KEY ([AddressKey]) REFERENCES [DW].[DimAddress] ([AddressKey]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating FK_FactRepo_DimAdjuster...';


GO
ALTER TABLE [DW].[FactRepo] WITH NOCHECK
    ADD CONSTRAINT [FK_FactRepo_DimAdjuster] FOREIGN KEY ([AdjusterKey]) REFERENCES [DW].[DimAdjuster] ([AdjusterKey]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating FK_FactRepo_DimAssignee...';


GO
ALTER TABLE [DW].[FactRepo] WITH NOCHECK
    ADD CONSTRAINT [FK_FactRepo_DimAssignee] FOREIGN KEY ([AssigneeKey]) REFERENCES [DW].[DimAssignee] ([AssigneeKey]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating FK_FactRepo_DimBorrower...';


GO
ALTER TABLE [DW].[FactRepo] WITH NOCHECK
    ADD CONSTRAINT [FK_FactRepo_DimBorrower] FOREIGN KEY ([BorrowerKey]) REFERENCES [DW].[DimBorrower] ([BorrowerKey]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating FK_FactRepo_DimCalendar_RepoOrderDateKey...';


GO
ALTER TABLE [DW].[FactRepo] WITH NOCHECK
    ADD CONSTRAINT [FK_FactRepo_DimCalendar_RepoOrderDateKey] FOREIGN KEY ([RepoOrderDateKey]) REFERENCES [DW].[DimCalendar] ([CalendarKey]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating FK_FactRepo_DimCaseWorker...';


GO
ALTER TABLE [DW].[FactRepo] WITH NOCHECK
    ADD CONSTRAINT [FK_FactRepo_DimCaseWorker] FOREIGN KEY ([CaseWorkerKey]) REFERENCES [DW].[DimCaseWorker] ([CaseWorkerKey]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating FK_FactRepo_DimClient...';


GO
ALTER TABLE [DW].[FactRepo] WITH NOCHECK
    ADD CONSTRAINT [FK_FactRepo_DimClient] FOREIGN KEY ([ClientKey]) REFERENCES [DW].[DimClient] ([ClientKey]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating FK_FactRepo_DimLienHolder...';


GO
ALTER TABLE [DW].[FactRepo] WITH NOCHECK
    ADD CONSTRAINT [FK_FactRepo_DimLienHolder] FOREIGN KEY ([LienHolderKey]) REFERENCES [DW].[DimLienHolder] ([LienHolderKey]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating FK_FactRepo_DimRecoveryAgentAddress...';


GO
ALTER TABLE [DW].[FactRepo] WITH NOCHECK
    ADD CONSTRAINT [FK_FactRepo_DimRecoveryAgentAddress] FOREIGN KEY ([RecoveryAgentAddressKey]) REFERENCES [DW].[DimRecoveryAgentAddress] ([RecoveryAgentAddressKey]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating FK_FactRepo_DimRepoAge...';


GO
ALTER TABLE [DW].[FactRepo] WITH NOCHECK
    ADD CONSTRAINT [FK_FactRepo_DimRepoAge] FOREIGN KEY ([RepoAgeKey]) REFERENCES [DW].[DimRepoAge] ([RepoAgeKey]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating FK_FactRepo_DimRepoDetails...';


GO
ALTER TABLE [DW].[FactRepo] WITH NOCHECK
    ADD CONSTRAINT [FK_FactRepo_DimRepoDetails] FOREIGN KEY ([RepoDetailsKey]) REFERENCES [DW].[DimRepoDetails] ([RepoDetailsKey]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating FK_FactRepo_DimRepoStatus...';


GO
ALTER TABLE [DW].[FactRepo] WITH NOCHECK
    ADD CONSTRAINT [FK_FactRepo_DimRepoStatus] FOREIGN KEY ([RepoStatusKey]) REFERENCES [DW].[DimRepoStatus] ([RepoStatusKey]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating FK_FactRepo_DimRepoType...';


GO
ALTER TABLE [DW].[FactRepo] WITH NOCHECK
    ADD CONSTRAINT [FK_FactRepo_DimRepoType] FOREIGN KEY ([RepoTypeKey]) REFERENCES [DW].[DimRepoType] ([RepoTypeKey]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating FK_FactRepo_DimVehicleMakeModel...';


GO
ALTER TABLE [DW].[FactRepo] WITH NOCHECK
    ADD CONSTRAINT [FK_FactRepo_DimVehicleMakeModel] FOREIGN KEY ([VehicleMakeModelKey]) REFERENCES [DW].[DimVehicleMakeModel] ([VehicleMakeModelKey]) ON DELETE NO ACTION ON UPDATE NO ACTION;


GO
PRINT N'Creating [Audit].[GetAllAuditPackageDetailRecords]...';


GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE Audit.GetAllAuditPackageDetailRecords
	@MasterKey int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT 
		AuditKey,
		MasterKey,
		PackageName,
		PackageGUID,
		PackageBuild,
		PackageVersionMajor,
		PackageVersionMinor,
		PackageStartDate,
		PackageEndDate,
		ProcessSucessfulIndicator,
		AdditionalInfo
  FROM 
		[Repo.Datamart].[Audit].[AuditPackage]
  WHERE 
		MasterKey = @MasterKey;
	
END
GO
PRINT N'Creating [Audit].[GetAllAuditPackageMasterRecords]...';


GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE Audit.GetAllAuditPackageMasterRecords
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
	  MasterKey,
      PackageStartDate,
      PackageEndDate,
      PackageName,
      PackageGUID,
      PackageVersionGUID,
      ProcessSucessfulIndicator,
      OptFileName
	FROM 
		[Repo.Datamart].[Audit].[AuditPackageMaster]
	ORDER BY 
		PackageEndDate DESC;
END
GO
PRINT N'Creating [Audit].[GetAuditPackageMasterRecord]...';


GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE Audit.GetAuditPackageMasterRecord
	@MasterKey int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT 
	  MasterKey,
      PackageStartDate,
      PackageEndDate,
      PackageName,
      PackageGUID,
      PackageVersionGUID,
      ProcessSucessfulIndicator,
      OptFileName
	FROM 
		[Repo.Datamart].[Audit].[AuditPackageMaster]
	WHERE 
		MasterKey = @MasterKey;
END
GO
PRINT N'Creating [Audit].[uspInsertAuditPackage]...';


GO
CREATE PROCEDURE [Audit].[uspInsertAuditPackage]
	(
		@MasterKey Int
		,@PackageName nvarchar(50)
		,@PackageGUID nvarchar(50)
		,@PackageBuild INT
		,@PackageVersionMajor INT
		,@PackageVersionMinor INT
		)

AS

BEGIN

DECLARE @AuditKey INT
		----Insert Values Into Audit Package table
		INSERT Audit.AuditPackage
			(
				 MasterKey
				,PackageName
				,PackageGUID
				,PackageBuild
				,PackageVersionMajor
				,PackageVersionMinor
				,PackageStartDate	
				,ProcessSucessfulIndicator	
			)

	VALUES
			(
				@MasterKey
				,@PackageName
				,@PackageGUID
				,@PackageBuild 
				,@PackageVersionMajor 
				,@PackageVersionMinor 
				,GetDate() 
				,0 ---Set Indicator = False
					
			)
	
	SET @AuditKey = SCOPE_IDENTITY()

	SELECT @AuditKey as AuditKey;	

END
GO
PRINT N'Creating [Audit].[uspInsertAuditPackageMaster]...';


GO
CREATE PROCEDURE [Audit].[uspInsertAuditPackageMaster]
	@PackageName nvarchar(50)
	,@PackageGUID nvarchar(50)
	,@PackageVersionGUID nvarchar(50)
	

AS
BEGIN
DECLARE @AuditMasterKey int

	INSERT Audit.AuditPackageMaster
			(
				PackageStartDate
				,PackageName
				,PackageGUID
				,PackageVersionGUID
				,ProcessSucessfulIndicator		
			)

	VALUES
			(
				GetDate() 
				,@PackageName
				,@PackageGUID
				,@PackageVersionGUID 
				,0 ---Set Indicator = False
					
			)
	
	SELECT @AuditMasterKey = SCOPE_IDENTITY()

	SELECT @AuditMasterKey as 'AuditMasterKey'	
END
GO
PRINT N'Creating [Audit].[uspUpdateAuditPackage]...';


GO
CREATE PROCEDURE [Audit].[uspUpdateAuditPackage]
	@AuditKey INT
	,@ProcessSuccessInd BIT
	,@AdditionalInfo varchar(250) = ''
AS
BEGIN
	UPDATE Audit.AuditPackage
	SET	 PackageEndDate = GetDate()
		 ,ProcessSucessfulIndicator = @ProcessSuccessInd
		 , AdditionalInfo = @AdditionalInfo
	WHERE Audit.AuditPackage.AuditKey = @AuditKey
	
END
GO
PRINT N'Creating [Audit].[uspUpdateAuditPackageMaster]...';


GO
CREATE PROCEDURE [Audit].[uspUpdateAuditPackageMaster]
	@MasterKey INT,
	@ProcessSucessfulIndicator BIT,
	@FileName nvarchar (100)
	
AS
BEGIN
	UPDATE Audit.AuditPackageMaster
	SET	 PackageEndDate = GetDate()
		 ,ProcessSucessfulIndicator = @ProcessSucessfulIndicator
		 ,OptFileName = @FileName
	WHERE Audit.AuditPackageMaster.MasterKey = @MasterKey

END
GO
PRINT N'Creating [DW].[GetStatusCountValues]...';


GO

CREATE PROCEDURE DW.GetStatusCountValues
	@repoStatusKey int,
	@startingYear int,
	@endingYear int,
	@caseWorkerKey int = NULL
AS
	SELECT
		D.MonthKey,
		D.CalendarMonth,
		COUNT(R.FactRepoKey)
	FROM
		DW.FactRepo R 
			INNER JOIN
				DW.DimRepoStatus S ON
					R.RepoStatusKey = S.RepoStatusKey
			INNER JOIN
				DW.DimCalendar D ON 
					D.CalendarKey = R.RepoOrderDateKey
								
	WHERE
		R.RepoStatusKey = @repoStatusKey AND
		D.CalendarYear >= @startingYear AND
		D.CalendarYear <= @endingYear 
		AND
		(R.CaseWorkerKey = @caseWorkerKey OR @caseWorkerKey IS NULL)
	GROUP BY
		D.MonthKey, D.CalendarMonth
	ORDER BY
		D.MonthKey
GO
PRINT N'Creating [DW].[usp_GetStatusCountValues]...';


GO

CREATE PROCEDURE DW.usp_GetStatusCountValues
	@startingYear int,
	@endingYear int,
	@caseWorkerKey int = NULL
AS
	SELECT
		D.MonthKey,
		D.CalendarYear,
		SUBSTRING(D.CalendarMonth, 0, 4) + ' ' + SUBSTRING(D.CalendarMonth, 7, 4) AS CalendarMonth,
		SUM(CASE WHEN R.RepoStatusKey = 1 THEN 1 ELSE 0 END) AS Repossessed,
		SUM(CASE WHEN R.RepoStatusKey = 2 THEN 1 ELSE 0 END) AS OnHold,
		SUM(CASE WHEN R.RepoStatusKey = 3 THEN 1 ELSE 0 END) AS Closed,
		SUM(CASE WHEN R.RepoStatusKey = 4 THEN 1 ELSE 0 END) AS [Open],
		SUM(CASE WHEN R.RepoStatusKey = 5 THEN 1 ELSE 0 END) AS Reassigned,
		SUM(CASE WHEN R.RepoStatusKey = 6 THEN 1 ELSE 0 END) AS NeedInfo,
		SUM(CASE WHEN R.RepoStatusKey = 7 THEN 1 ELSE 0 END) AS ClosedPositiveResolution,
		SUM(CASE WHEN R.RepoStatusKey = 8 THEN 1 ELSE 0 END) AS Completed,
		SUM(CASE WHEN R.RepoStatusKey = 9 THEN 1 ELSE 0 END) AS PendingClose,
		SUM(CASE WHEN R.RepoStatusKey = 10 THEN 1 ELSE 0 END) AS PendingOnHold
	FROM
		DW.DimCalendar D
			INNER JOIN
				DW.FactRepo R ON
					D.CalendarKey = R.RepoOrderDateKey
			INNER JOIN
				DW.DimRepoStatus S ON
					R.RepoStatusKey = S.RepoStatusKey
			INNER JOIN
				DW.DimCaseWorker W ON 
					R.CaseWorkerKey = W.CaseWorkerKey
	WHERE
--		R.RepoStatusKey = @repoStatusKey AND
		D.CalendarYear >= @startingYear AND
		D.CalendarYear <= @endingYear 
		AND
		(R.CaseWorkerKey = @caseWorkerKey OR @caseWorkerKey IS NULL)
	GROUP BY
		D.CalendarYear, D.MonthKey, D.CalendarMonth
	ORDER BY
		D.MonthKey
GO
PRINT N'Creating [DW].[usp_InsertDefaultAddressRecord]...';


GO
CREATE PROCEDURE [DW].[usp_InsertDefaultAddressRecord]
	@AuditID INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DELETE FROM DW.DimAddress WHERE AddressKey < 0		
	
	--Set Identity Insert ON
	SET IDENTITY_INSERT DW.DimAddress ON

	-- Insert Negative 1 values
	INSERT DW.DimAddress
				(
				AddressKey , 
				StreetAddress , 
				City,
				StateCode,
				ZipCode,
				InsertAuditKey,
				UpdateAuditKey						
				)
		VALUES
				(
					-1
					,'Unknown Address'
					,'Unknown City'
					,''
					,''
					,@AuditID
					,@AuditID					
				)

	--Set Identity Insert OFF
	SET IDENTITY_INSERT DW.DimAddress OFF
END
GO
PRINT N'Creating [DW].[usp_InsertDefaultAdjusterRecord]...';


GO
CREATE PROCEDURE [DW].[usp_InsertDefaultAdjusterRecord]
	@AuditID INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DELETE FROM DW.DimAdjuster WHERE AdjusterKey < 0		
	
	--Set Identity Insert ON
	SET IDENTITY_INSERT DW.DimAdjuster ON

	-- Insert Negative 1 values
	INSERT DW.DimAdjuster
				(
				AdjusterKey , 
				AdjusterName , 				
				InsertAuditKey,
				UpdateAuditKey						
				)
		VALUES
				(
					-1
					,'Unknown Adjuster'
					,@AuditID
					,@AuditID					
				)

	--Set Identity Insert OFF
	SET IDENTITY_INSERT DW.DimAdjuster OFF

END
GO
PRINT N'Creating [DW].[usp_InsertDefaultAssigneeRecord]...';


GO
CREATE PROCEDURE [DW].[usp_InsertDefaultAssigneeRecord]
	@AuditID INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DELETE FROM DW.DimAssignee WHERE AssigneeKey < 0		
	
	--Set Identity Insert ON
	SET IDENTITY_INSERT DW.DimAssignee ON

	-- Insert Negative 1 values
	INSERT DW.DimAssignee
				(
				AssigneeKey , 
				AssigneeBK , 
				InsertAuditKey,
				UpdateAuditKey						
				)
		VALUES
				(
					-1
					,'Unknown Assignee'
					,@AuditID
					,@AuditID					
				)

	--Set Identity Insert OFF
	SET IDENTITY_INSERT DW.DimAssignee OFF
END
GO
PRINT N'Creating [DW].[usp_InsertDefaultBorrowerRecord]...';


GO
CREATE PROCEDURE [DW].[usp_InsertDefaultBorrowerRecord]
	@AuditID INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DELETE FROM DW.DimBorrower WHERE BorrowerKey < 0		
	
	--Set Identity Insert ON
	SET IDENTITY_INSERT DW.DimBorrower ON

	-- Insert Negative 1 values
	INSERT DW.DimBorrower
				(
				BorrowerKey , 
				BorrowerName , 
				BorrowerMiddleInitial,
				HomeAddressKey,
				HomePhone,
				WorkAddress,
				InsertAuditKey,
				UpdateAuditKey						
				)
		VALUES
				(
					-1
					,'Unknown Borrower'
					,''	
					,-1
					,''
					,''				
					,@AuditID
					,@AuditID					
				)

	--Set Identity Insert OFF
	SET IDENTITY_INSERT DW.DimBorrower OFF

END
GO
PRINT N'Creating [DW].[usp_InsertDefaultClientRecord]...';


GO
CREATE PROCEDURE [DW].[usp_InsertDefaultClientRecord]
	@AuditID INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DELETE FROM DW.DimClient WHERE ClientKey < 0		
	
	--Set Identity Insert ON
	SET IDENTITY_INSERT DW.DimClient ON

	-- Insert Negative 1 values
	INSERT DW.DimClient
				(
				ClientKey , 
				ClientName , 
				AddressKey,				
				InsertAuditKey,
				UpdateAuditKey						
				)
		VALUES
				(
					-1
					,'Unknown Client'
					,-1									
					,@AuditID
					,@AuditID					
				)

	--Set Identity Insert OFF
	SET IDENTITY_INSERT DW.DimClient OFF

END
GO
PRINT N'Creating [DW].[usp_InsertDefaultLienHolder]...';


GO
CREATE PROCEDURE [DW].[usp_InsertDefaultLienHolder]
	@AuditID INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DELETE FROM DW.DimLienHolder WHERE LienHolderKey < 0		
	
	--Set Identity Insert ON
	SET IDENTITY_INSERT DW.DimLienHolder ON

	-- Insert Negative 1 values
	INSERT DW.DimLienHolder
				(
				LienHolderKey , 
				LienHolderBK , 
				InsertAuditKey,
				UpdateAuditKey						
				)
		VALUES
				(
					-1
					,'Unknown Lien Holder'
					,@AuditID
					,@AuditID					
				)

	--Set Identity Insert OFF
	SET IDENTITY_INSERT DW.DimLienHolder OFF
END
GO
PRINT N'Creating [DW].[usp_InsertDefaultRepoAgeRecords]...';


GO
CREATE PROCEDURE [DW].[usp_InsertDefaultRepoAgeRecords]
	@AuditID INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO DW.DimRepoAge (RepoAgeKey,RepoAge, InsertAuditKey) VALUES (-1, 'N/A (Closed or Closed-Pos)', -99)
	INSERT INTO DW.DimRepoAge (RepoAgeKey,RepoAge, InsertAuditKey) VALUES (1, '0 - 30 Days', -99)
	INSERT INTO DW.DimRepoAge (RepoAgeKey,RepoAge, InsertAuditKey) VALUES (2, '31 - 60 Days', -99)
	INSERT INTO DW.DimRepoAge (RepoAgeKey,RepoAge, InsertAuditKey) VALUES (3, '61 - 90 Days', -99)
	INSERT INTO DW.DimRepoAge (RepoAgeKey,RepoAge, InsertAuditKey) VALUES (4, '91 - 120 Days', -99)
	INSERT INTO DW.DimRepoAge (RepoAgeKey,RepoAge, InsertAuditKey) VALUES (5, '121 - 150 Days', -99)
	INSERT INTO DW.DimRepoAge (RepoAgeKey,RepoAge, InsertAuditKey) VALUES (6, '151 - 180 Days', -99)
	INSERT INTO DW.DimRepoAge (RepoAgeKey,RepoAge, InsertAuditKey) VALUES (7, 'Over 181 Days', -99)

END
GO
PRINT N'Creating [DW].[usp_InsertDefaultVehicleMakeModelRecord]...';


GO
CREATE PROCEDURE [DW].[usp_InsertDefaultVehicleMakeModelRecord]
	@AuditID INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DELETE FROM DW.DimVehicleMakeModel WHERE VehicleMakeModelKey < 0		
	
	--Set Identity Insert ON
	SET IDENTITY_INSERT DW.DimVehicleMakeModel ON

	-- Insert Negative 1 values
	INSERT DW.DimVehicleMakeModel
				(
				VehicleMakeModelKey , 
				VehicleMake , 
				VehicleModel,
				InsertAuditKey,
				UpdateAuditKey						
				)
		VALUES
				(
					-1
					,'Unknown Make'
					,'Unknown Model'					
					,@AuditID
					,@AuditID					
				)

	--Set Identity Insert OFF
	SET IDENTITY_INSERT DW.DimVehicleMakeModel OFF
END
GO
-- Refactoring step to update target server with deployed transaction logs
CREATE TABLE  [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
GO
sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
GO

GO
/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      --setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [DW].[DimBorrower] WITH CHECK CHECK CONSTRAINT [FK_DimBorrower_DimAddress];

ALTER TABLE [DW].[DimClient] WITH CHECK CHECK CONSTRAINT [FK_DimClient_DimClientAddress];

ALTER TABLE [DW].[DimRecoveryAgentAddress] WITH CHECK CHECK CONSTRAINT [FK_DimRecoveryAgentAddress_DimAddress];

ALTER TABLE [DW].[DimRecoveryAgentAddress] WITH CHECK CHECK CONSTRAINT [FK_DimRecoveryAgentAddress_DimRecoveryAgent];

ALTER TABLE [DW].[DimStorageLocation] WITH CHECK CHECK CONSTRAINT [FK_DimStorageLocation_DimAddress];

ALTER TABLE [DW].[FactRepo] WITH CHECK CHECK CONSTRAINT [FK_FactRepo_DimAdjuster];

ALTER TABLE [DW].[FactRepo] WITH CHECK CHECK CONSTRAINT [FK_FactRepo_DimAssignee];

ALTER TABLE [DW].[FactRepo] WITH CHECK CHECK CONSTRAINT [FK_FactRepo_DimBorrower];

ALTER TABLE [DW].[FactRepo] WITH CHECK CHECK CONSTRAINT [FK_FactRepo_DimCalendar_RepoOrderDateKey];

ALTER TABLE [DW].[FactRepo] WITH CHECK CHECK CONSTRAINT [FK_FactRepo_DimCaseWorker];

ALTER TABLE [DW].[FactRepo] WITH CHECK CHECK CONSTRAINT [FK_FactRepo_DimClient];

ALTER TABLE [DW].[FactRepo] WITH CHECK CHECK CONSTRAINT [FK_FactRepo_DimLienHolder];

ALTER TABLE [DW].[FactRepo] WITH CHECK CHECK CONSTRAINT [FK_FactRepo_DimRecoveryAgentAddress];

ALTER TABLE [DW].[FactRepo] WITH CHECK CHECK CONSTRAINT [FK_FactRepo_DimRepoAge];

ALTER TABLE [DW].[FactRepo] WITH CHECK CHECK CONSTRAINT [FK_FactRepo_DimRepoDetails];

ALTER TABLE [DW].[FactRepo] WITH CHECK CHECK CONSTRAINT [FK_FactRepo_DimRepoStatus];

ALTER TABLE [DW].[FactRepo] WITH CHECK CHECK CONSTRAINT [FK_FactRepo_DimRepoType];

ALTER TABLE [DW].[FactRepo] WITH CHECK CHECK CONSTRAINT [FK_FactRepo_DimVehicleMakeModel];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        DECLARE @VarDecimalSupported AS BIT;
        SELECT @VarDecimalSupported = 0;
        IF ((ServerProperty(N'EngineEdition') = 3)
            AND (((@@microsoftversion / power(2, 24) = 9)
                  AND (@@microsoftversion & 0xffff >= 3024))
                 OR ((@@microsoftversion / power(2, 24) = 10)
                     AND (@@microsoftversion & 0xffff >= 1600))))
            SELECT @VarDecimalSupported = 1;
        IF (@VarDecimalSupported > 0)
            BEGIN
                EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
            END
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET MULTI_USER 
    WITH ROLLBACK IMMEDIATE;


GO

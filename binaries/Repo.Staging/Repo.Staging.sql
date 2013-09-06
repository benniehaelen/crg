/*
Deployment script for Repo.Staging
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
--setvar ArchiveDirectory ""
--setvar BIShellURL ""
--setvar DatabaseServer ""
--setvar DataPath "C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\"
--setvar EmailGroupsJobStatus ""
--setvar FromEmailAddress ""
--setvar LogPath "C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\"
--setvar OLAPCubeDB ""
--setvar OLAPServer ""
--setvar PackagePath ""
--setvar SourceFileDirectory ""
--setvar StagingBasePath ""
--setvar TempDownloadFolder ""
--setvar ThirtyTwoDtexecDirectory ""
--setvar DatabaseName "Repo.Staging"
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
    PRIMARY(NAME = [Repo.Staging], FILENAME = '$(DataPath)$(DatabaseName).mdf', FILEGROWTH = 1024 KB)
    LOG ON (NAME = [Repo.Staging_log], FILENAME = '$(LogPath)$(DatabaseName)_log.LDF', MAXSIZE = 2097152 MB, FILEGROWTH = 10 %) COLLATE SQL_Latin1_General_CP1_CI_AS
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
PRINT N'Creating [DWConfig]...';


GO
CREATE SCHEMA [DWConfig]
    AUTHORIZATION [dbo];


GO
PRINT N'Creating [Staging]...';


GO
CREATE SCHEMA [Staging]
    AUTHORIZATION [dbo];


GO
PRINT N'Creating [DWConfig].[SSISETLConfig]...';


GO
CREATE TABLE [DWConfig].[SSISETLConfig] (
    [ConfigurationFilter] NVARCHAR (255) NOT NULL,
    [ConfiguredValue]     NVARCHAR (255) NOT NULL,
    [PackagePath]         NVARCHAR (255) NOT NULL,
    [ConfiguredValueType] NVARCHAR (255) NOT NULL
);


GO
PRINT N'Creating [Staging].[RepoTransactions]...';


GO
CREATE TABLE [Staging].[RepoTransactions] (
    [StagingID]                         INT           IDENTITY (1, 1) NOT NULL,
    [CaseNumber]                        VARCHAR (50)  NULL,
    [ClientName]                        VARCHAR (50)  NULL,
    [AccountNumberWithSign]             VARCHAR (50)  NULL,
    [FirstName]                         VARCHAR (50)  NULL,
    [LastName]                          VARCHAR (50)  NULL,
    [VehicleYear]                       VARCHAR (50)  NULL,
    [Make]                              VARCHAR (150) NULL,
    [Model]                             VARCHAR (100) NULL,
    [VIN]                               VARCHAR (50)  NULL,
    [Status]                            VARCHAR (50)  NULL,
    [RepoDate]                          VARCHAR (50)  NULL,
    [CloseDate]                         VARCHAR (50)  NULL,
    [OrderDate]                         VARCHAR (50)  NULL,
    [SubStatus]                         VARCHAR (200) NULL,
    [Disposition]                       VARCHAR (50)  NULL,
    [ClientAddress]                     VARCHAR (100) NULL,
    [ClientCity]                        VARCHAR (50)  NULL,
    [ClientState]                       VARCHAR (50)  NULL,
    [ClientZip]                         VARCHAR (10)  NULL,
    [ClientPhone]                       VARCHAR (50)  NULL,
    [ClientBranchPhone]                 VARCHAR (50)  NULL,
    [ClientFax]                         VARCHAR (50)  NULL,
    [ClientBranch]                      VARCHAR (50)  NULL,
    [AccountNumber]                     VARCHAR (50)  NULL,
    [Assignee]                          VARCHAR (50)  NULL,
    [AssigneePhone]                     VARCHAR (50)  NULL,
    [LienholderName]                    VARCHAR (50)  NULL,
    [FullName]                          VARCHAR (50)  NULL,
    [DebtorMiddleInitial]               VARCHAR (50)  NULL,
    [Address]                           VARCHAR (250) NULL,
    [City]                              VARCHAR (50)  NULL,
    [State]                             VARCHAR (50)  NULL,
    [HomeZip]                           VARCHAR (10)  NULL,
    [County]                            VARCHAR (50)  NULL,
    [HomePhone]                         VARCHAR (50)  NULL,
    [BorrowersHomeAddresses]            VARCHAR (100) NULL,
    [BorrowersWorkAddresses]            VARCHAR (100) NULL,
    [CSLastName]                        VARCHAR (100) NULL,
    [CoSignerMiddleInitial]             VARCHAR (50)  NULL,
    [CSFirstName]                       VARCHAR (50)  NULL,
    [CSFullName]                        VARCHAR (100) NULL,
    [CosignerHomeAddresses]             VARCHAR (100) NULL,
    [CosignerWorkAddresses]             VARCHAR (100) NULL,
    [CR]                                VARCHAR (50)  NULL,
    [Drivable]                          VARCHAR (50)  NULL,
    [Invoice]                           VARCHAR (50)  NULL,
    [Keys]                              VARCHAR (50)  NULL,
    [Personals]                         VARCHAR (50)  NULL,
    [Photos]                            VARCHAR (50)  NULL,
    [RecoveryAgent]                     VARCHAR (100) NULL,
    [RecoveryAddress]                   VARCHAR (100) NULL,
    [RecoveryCity]                      VARCHAR (50)  NULL,
    [RecoveryState]                     VARCHAR (50)  NULL,
    [RecoveryZip]                       VARCHAR (10)  NULL,
    [RecoveryTime]                      VARCHAR (50)  NULL,
    [YearMakeModel]                     VARCHAR (200) NULL,
    [ExpirationDate]                    VARCHAR (50)  NULL,
    [TagExpirationDate]                 VARCHAR (50)  NULL,
    [VehicleLicenseState]               VARCHAR (50)  NULL,
    [VehicleLicense]                    VARCHAR (50)  NULL,
    [VehicleMileage]                    VARCHAR (50)  NULL,
    [Last6ofVIN]                        VARCHAR (50)  NULL,
    [StorageLocationName]               VARCHAR (150) NULL,
    [StorageAddress]                    VARCHAR (100) NULL,
    [StorageCity]                       VARCHAR (50)  NULL,
    [StorageState]                      VARCHAR (50)  NULL,
    [StorageZip]                        VARCHAR (10)  NULL,
    [LotSpaceNumberOfCollateral]        VARCHAR (50)  NULL,
    [Adjusters]                         VARCHAR (250) NULL,
    [AuctionName]                       VARCHAR (50)  NULL,
    [ReleaseDate]                       VARCHAR (50)  NULL,
    [AlertText]                         VARCHAR (250) NULL,
    [Branch]                            VARCHAR (50)  NULL,
    [CaseInvestigator]                  VARCHAR (50)  NULL,
    [ReferenceNumber]                   VARCHAR (50)  NULL,
    [CaseWorker]                        VARCHAR (50)  NULL,
    [ClaimNumber]                       VARCHAR (50)  NULL,
    [HoldDate]                          VARCHAR (50)  NULL,
    [NumberOfdaysWithCurrentCaseWorker] VARCHAR (50)  NULL,
    [Office]                            VARCHAR (50)  NULL,
    [RepoType]                          VARCHAR (50)  NULL,
    [AccountBalance]                    VARCHAR (50)  NULL,
    [AmountPastDue]                     VARCHAR (50)  NULL,
    [ChargeoffDate]                     VARCHAR (50)  NULL,
    [DelinquentSince]                   VARCHAR (50)  NULL,
    [MonthlyPayments]                   VARCHAR (50)  NULL,
    [LastAgentUpdateDays]               VARCHAR (50)  NULL,
    [LastUpdateDays]                    VARCHAR (50)  NULL,
    [NumberOfUpdates]                   VARCHAR (50)  NULL,
    [TransferFromAdjusterDays]          VARCHAR (50)  NULL,
    [ICRATicketNumber]                  VARCHAR (50)  NULL,
    [ICRAFirst NotificationBy]          VARCHAR (50)  NULL,
    [ICRAFirstNotificationDate]         VARCHAR (50)  NULL,
    [ICRASecondNotificationBy]          VARCHAR (50)  NULL,
    [ICRASecondNotificationDate]        VARCHAR (50)  NULL
);


GO
PRINT N'Creating PK_RepoTransactions...';


GO
ALTER TABLE [Staging].[RepoTransactions]
    ADD CONSTRAINT [PK_RepoTransactions] PRIMARY KEY CLUSTERED ([StagingID] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);


GO
PRINT N'Creating [Staging].[uspTruncateStgTables]...';


GO
CREATE PROCEDURE [Staging].[uspTruncateStgTables]
	@StgTableName varchar(50)
AS

BEGIN
      ---Declare Variable used to execute SQL statement

      DECLARE @StrSQL as VARCHAR(75)

      --Create Truncate Table String Expression

      SET @StrSQL = 'TRUNCATE TABLE ' + @StgTableName 

      ---Truncate table

      EXEC (@StrSQL)

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

INSERT INTO DWConfig.SSISETLConfig (ConfigurationFilter, ConfiguredValue, PackagePath, ConfiguredValueType)
VALUES ('StagingDB', 'Repo.Staging', '\Package.Variables[User::StagingDB].Properties[Value]', 'String')

INSERT INTO DWConfig.SSISETLConfig (ConfigurationFilter, ConfiguredValue, PackagePath, ConfiguredValueType)
VALUES ('TargetDB', 'Repo.DataMart', '\Package.Variables[User::TargetDB].Properties[Value]', 'String')

INSERT INTO DWConfig.SSISETLConfig (ConfigurationFilter, ConfiguredValue, PackagePath, ConfiguredValueType)
VALUES ('StagingSvr', '$(DatabaseServer)', '\Package.Variables[User::StagingSvr].Properties[Value]', 'String')

INSERT INTO DWConfig.SSISETLConfig (ConfigurationFilter, ConfiguredValue, PackagePath, ConfiguredValueType)
VALUES ('StagingProv', 'SQLNCLI10.1', '\Package.Variables[User::StagingProv].Properties[Value]', 'String')

INSERT INTO DWConfig.SSISETLConfig (ConfigurationFilter, ConfiguredValue, PackagePath, ConfiguredValueType)
VALUES ('TargetSvr', '$(DatabaseServer)', '\Package.Variables[User::TargetSvr].Properties[Value]', 'String')

INSERT INTO DWConfig.SSISETLConfig (ConfigurationFilter, ConfiguredValue, PackagePath, ConfiguredValueType)
VALUES ('TargetProv', 'SQLNCLI10.1', '\Package.Variables[User::TargetProv].Properties[Value]', 'String')

INSERT INTO DWConfig.SSISETLConfig (ConfigurationFilter, ConfiguredValue, PackagePath, ConfiguredValueType)
VALUES ('BasePath', '$(StagingBasePath)', '\Package.Variables[User::BasePath].Properties[Value]', 'String')

INSERT INTO DWConfig.SSISETLConfig (ConfigurationFilter, ConfiguredValue, PackagePath, ConfiguredValueType)
VALUES ('PackagePath', '$(PackagePath)', '\Package.Variables[User::PackagePath].Properties[Value]', 'String')

INSERT INTO DWConfig.SSISETLConfig (ConfigurationFilter, ConfiguredValue, PackagePath, ConfiguredValueType)
VALUES ('TextFilePath', 'Data\TextFiles\', '\Package.Variables[User::TextFilePath].Properties[Value]', 'String')

INSERT INTO DWConfig.SSISETLConfig (ConfigurationFilter, ConfiguredValue, PackagePath, ConfiguredValueType)
VALUES ('TextFileArcPath', 'Data\TextFileArc\', '\Package.Variables[User::TextFileArcPath].Properties[Value]', 'String')

INSERT INTO DWConfig.SSISETLConfig (ConfigurationFilter, ConfiguredValue, PackagePath, ConfiguredValueType)
VALUES ('ExcelFilePath', 'Data\ExcelFiles\', '\Package.Variables[User::ExcelFilePath].Properties[Value]', 'String')

INSERT INTO DWConfig.SSISETLConfig (ConfigurationFilter, ConfiguredValue, PackagePath, ConfiguredValueType)
VALUES ('ExcelFileArcPath', 'Data\ExcelFileArc\', '\Package.Variables[User::ExcelArcPath].Properties[Value]', 'String')

INSERT INTO DWConfig.SSISETLConfig (ConfigurationFilter, ConfiguredValue, PackagePath, ConfiguredValueType)
VALUES ('OLAPCubeDB', '$(OLAPCubeDB)', '\Package.Variables[User::OLAPCubeDB].Properties[Value]', 'String')

INSERT INTO DWConfig.SSISETLConfig (ConfigurationFilter, ConfiguredValue, PackagePath, ConfiguredValueType)
VALUES ('OLAPServer', '$(OLAPServer)', '\Package.Variables[User::OLAPServer].Properties[Value]', 'String')

INSERT INTO DWConfig.SSISETLConfig (ConfigurationFilter, ConfiguredValue, PackagePath, ConfiguredValueType)
VALUES ('SourceFileDirectory', '$(SourceFileDirectory)', '\Package.Variables[User::SourceFileDirectory].Properties[Value]', 'String')

INSERT INTO DWConfig.SSISETLConfig (ConfigurationFilter, ConfiguredValue, PackagePath, ConfiguredValueType)
VALUES ('ArchiveDirectory', '$(ArchiveDirectory)', '\Package.Variables[User::ArchiveDirectory].Properties[Value]', 'String')

INSERT INTO DWConfig.SSISETLConfig (ConfigurationFilter, ConfiguredValue, PackagePath, ConfiguredValueType)
VALUES ('EmailGroupJobStatus', '$(EmailGroupsJobStatus)', '\Package.Variables[User::EmailGroupJobStatus].Properties[Value]', 'String')

INSERT INTO DWConfig.SSISETLConfig (ConfigurationFilter, ConfiguredValue, PackagePath, ConfiguredValueType)
VALUES ('FromEmailAddress', '$(FromEmailAddress)', '\Package.Variables[User::FromEmailAddress].Properties[Value]', 'String')

/*
INSERT INTO DWConfig.SSISETLConfig (ConfigurationFilter, ConfiguredValue, PackagePath, ConfiguredValueType)
VALUES ('SourceFileDirectoryHistoryCatchupFiles', '$(SourceFileDirectoryHistoryCatchupFiles)', 
'\Package.Variables[User::SourceFileDirectoryHistoryCatchupFiles].Properties[Value]', 'String') 

INSERT INTO DWConfig.SSISETLConfig (ConfigurationFilter, ConfiguredValue, PackagePath, ConfiguredValueType)
VALUES ('SourceFileDirectoryDailyCatchupFiles', '$(SourceFileDirectoryDailyCatchupFiles)', 
'\Package.Variables[User::SourceFileDirectoryDailyCatchupFiles].Properties[Value]', 'String') 
*/

INSERT INTO DWConfig.SSISETLConfig (ConfigurationFilter, ConfiguredValue, PackagePath, ConfiguredValueType)
VALUES ('ThirtyTwoDtexecDirectory', '$(ThirtyTwoDtexecDirectory)', 
'\Package.Variables[User::ThirtyTwoDtexecDirectory].Properties[Value]', 'String') 

INSERT INTO DWConfig.SSISETLConfig (ConfigurationFilter,	ConfiguredValue,	PackagePath, ConfiguredValueType)
values('BIShellURL','$(BIShellURL)',
'\Package.Variables[User::BIShellURL].Properties[Value]','String')

INSERT INTO DWConfig.SSISETLConfig (ConfigurationFilter,	ConfiguredValue,	PackagePath, ConfiguredValueType)
values('TempDownloadFolder','$(TempDownloadFolder)',
'\Package.Variables[User::TempDownloadFolder].Properties[Value]','String')

GO

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

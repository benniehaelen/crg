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
EXEC [DW].[usp_InsertDefaultAddressRecord] -99
EXEC [DW].[usp_InsertDefaultVehicleMakeModelRecord] -99
EXEC [DW].[usp_InsertDefaultBorrowerRecord] -99
EXEC [DW].[usp_InsertDefaultAdjusterRecord] -99
EXEC [DW].[usp_InsertDefaultClientRecord] -99
EXEC [DW].[usp_InsertDefaultRepoAgeRecords] -99
EXEC [DW].[usp_InsertDefaultAssigneeRecord] -99
EXEC [DW].[usp_InsertDefaultLienHolder] -99
EXEC [DW].[usp_InsertDefaultCalendarRecord] -99

INSERT INTO DW.DataLoadDate (DataLoadDate) VALUES (GETDATE())

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

ALTER TABLE [DW].[FactRepo] WITH CHECK CHECK CONSTRAINT [FK_FactRepo_DimCalendar_OrderDateKey];
ALTER TABLE [DW].[FactRepo] WITH CHECK CHECK CONSTRAINT [FK_FactRepo_DimCalendar_RepoDateKey];
ALTER TABLE [DW].[FactRepo] WITH CHECK CHECK CONSTRAINT [FK_FactRepo_DimCalendar_CloseDateKey];
ALTER TABLE [DW].[FactRepo] WITH CHECK CHECK CONSTRAINT [FK_FactRepo_DimCalendar_HoldDateKey];

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

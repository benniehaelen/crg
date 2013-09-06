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

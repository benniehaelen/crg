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

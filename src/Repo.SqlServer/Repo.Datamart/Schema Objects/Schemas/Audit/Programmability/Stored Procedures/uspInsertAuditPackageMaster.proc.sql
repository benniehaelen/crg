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

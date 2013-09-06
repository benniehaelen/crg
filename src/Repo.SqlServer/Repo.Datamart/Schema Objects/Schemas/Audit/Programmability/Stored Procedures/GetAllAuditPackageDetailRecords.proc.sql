
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

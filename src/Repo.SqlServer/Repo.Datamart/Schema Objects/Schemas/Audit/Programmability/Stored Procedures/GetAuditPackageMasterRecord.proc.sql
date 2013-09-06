

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

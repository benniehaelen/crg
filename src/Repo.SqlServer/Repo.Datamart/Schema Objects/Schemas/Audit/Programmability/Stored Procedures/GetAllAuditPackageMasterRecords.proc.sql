
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

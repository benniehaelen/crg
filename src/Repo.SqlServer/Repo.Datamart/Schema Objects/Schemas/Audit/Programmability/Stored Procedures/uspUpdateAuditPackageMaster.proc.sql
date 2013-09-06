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

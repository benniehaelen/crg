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

CREATE PROCEDURE [DW].[usp_InsertDefaultClientRecord]
	@AuditID INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DELETE FROM DW.DimClient WHERE ClientKey < 0		
	
	--Set Identity Insert ON
	SET IDENTITY_INSERT DW.DimClient ON

	-- Insert Negative 1 values
	INSERT DW.DimClient
				(
				ClientKey , 
				ClientName , 
				AddressKey,				
				InsertAuditKey,
				UpdateAuditKey						
				)
		VALUES
				(
					-1
					,'Unknown Client'
					,-1									
					,@AuditID
					,@AuditID					
				)

	--Set Identity Insert OFF
	SET IDENTITY_INSERT DW.DimClient OFF

END

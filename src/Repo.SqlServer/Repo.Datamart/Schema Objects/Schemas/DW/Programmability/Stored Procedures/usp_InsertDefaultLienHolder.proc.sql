CREATE PROCEDURE [DW].[usp_InsertDefaultLienHolder]
	@AuditID INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DELETE FROM DW.DimLienHolder WHERE LienHolderKey < 0		
	
	--Set Identity Insert ON
	SET IDENTITY_INSERT DW.DimLienHolder ON

	-- Insert Negative 1 values
	INSERT DW.DimLienHolder
				(
				LienHolderKey , 
				LienHolderBK , 
				InsertAuditKey,
				UpdateAuditKey						
				)
		VALUES
				(
					-1
					,'Unknown Lien Holder'
					,@AuditID
					,@AuditID					
				)

	--Set Identity Insert OFF
	SET IDENTITY_INSERT DW.DimLienHolder OFF
END

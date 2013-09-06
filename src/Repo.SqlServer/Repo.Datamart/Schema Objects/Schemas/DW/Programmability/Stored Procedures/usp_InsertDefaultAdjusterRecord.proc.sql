CREATE PROCEDURE [DW].[usp_InsertDefaultAdjusterRecord]
	@AuditID INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DELETE FROM DW.DimAdjuster WHERE AdjusterKey < 0		
	
	--Set Identity Insert ON
	SET IDENTITY_INSERT DW.DimAdjuster ON

	-- Insert Negative 1 values
	INSERT DW.DimAdjuster
				(
				AdjusterKey , 
				AdjusterName , 				
				InsertAuditKey,
				UpdateAuditKey						
				)
		VALUES
				(
					-1
					,'Unknown Adjuster'
					,@AuditID
					,@AuditID					
				)

	--Set Identity Insert OFF
	SET IDENTITY_INSERT DW.DimAdjuster OFF

END

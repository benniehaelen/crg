CREATE PROCEDURE [DW].[usp_InsertDefaultBorrowerRecord]
	@AuditID INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DELETE FROM DW.DimBorrower WHERE BorrowerKey < 0		
	
	--Set Identity Insert ON
	SET IDENTITY_INSERT DW.DimBorrower ON

	-- Insert Negative 1 values
	INSERT DW.DimBorrower
				(
				BorrowerKey , 
				BorrowerName , 
				BorrowerMiddleInitial,
				HomeAddressKey,
				HomePhone,
				WorkAddress,
				InsertAuditKey,
				UpdateAuditKey						
				)
		VALUES
				(
					-1
					,'Unknown Borrower'
					,''	
					,-1
					,''
					,''				
					,@AuditID
					,@AuditID					
				)

	--Set Identity Insert OFF
	SET IDENTITY_INSERT DW.DimBorrower OFF

END

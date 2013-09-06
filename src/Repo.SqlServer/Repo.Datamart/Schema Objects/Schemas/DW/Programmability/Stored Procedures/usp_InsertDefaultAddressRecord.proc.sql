CREATE PROCEDURE [DW].[usp_InsertDefaultAddressRecord]
	@AuditID INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DELETE FROM DW.DimAddress WHERE AddressKey < 0		
	
	--Set Identity Insert ON
	SET IDENTITY_INSERT DW.DimAddress ON

	-- Insert Negative 1 values
	INSERT DW.DimAddress
				(
				AddressKey , 
				StreetAddress , 
				City,
				StateCode,
				ZipCode,
				InsertAuditKey,
				UpdateAuditKey						
				)
		VALUES
				(
					-1
					,'Unknown Address'
					,'Unknown City'
					,''
					,''
					,@AuditID
					,@AuditID					
				)

	--Set Identity Insert OFF
	SET IDENTITY_INSERT DW.DimAddress OFF
END

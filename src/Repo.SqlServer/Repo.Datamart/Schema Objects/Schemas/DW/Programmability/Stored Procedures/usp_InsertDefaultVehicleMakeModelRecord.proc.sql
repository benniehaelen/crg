CREATE PROCEDURE [DW].[usp_InsertDefaultVehicleMakeModelRecord]
	@AuditID INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DELETE FROM DW.DimVehicleMakeModel WHERE VehicleMakeModelKey < 0		
	
	--Set Identity Insert ON
	SET IDENTITY_INSERT DW.DimVehicleMakeModel ON

	-- Insert Negative 1 values
	INSERT DW.DimVehicleMakeModel
				(
				VehicleMakeModelKey , 
				VehicleMake , 
				VehicleModel,
				InsertAuditKey,
				UpdateAuditKey						
				)
		VALUES
				(
					-1
					,'Unknown Make'
					,'Unknown Model'					
					,@AuditID
					,@AuditID					
				)

	--Set Identity Insert OFF
	SET IDENTITY_INSERT DW.DimVehicleMakeModel OFF
END

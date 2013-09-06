CREATE PROCEDURE [DW].[usp_InsertDefaultAssigneeRecord]
	@AuditID INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DELETE FROM DW.DimAssignee WHERE AssigneeKey < 0		
	
	--Set Identity Insert ON
	SET IDENTITY_INSERT DW.DimAssignee ON

	-- Insert Negative 1 values
	INSERT DW.DimAssignee
				(
				AssigneeKey , 
				AssigneeBK , 
				InsertAuditKey,
				UpdateAuditKey						
				)
		VALUES
				(
					-1
					,'Unknown Assignee'
					,@AuditID
					,@AuditID					
				)

	--Set Identity Insert OFF
	SET IDENTITY_INSERT DW.DimAssignee OFF
END

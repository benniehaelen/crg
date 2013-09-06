CREATE PROCEDURE [DW].[usp_InsertDefaultRepoAgeRecords]
	@AuditID INT 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO DW.DimRepoAge (RepoAgeKey,RepoAge, InsertAuditKey) VALUES (-1, 'N/A (Closed or Closed-Pos)', -99)
	INSERT INTO DW.DimRepoAge (RepoAgeKey,RepoAge, InsertAuditKey) VALUES (1, '0 - 30 Days', -99)
	INSERT INTO DW.DimRepoAge (RepoAgeKey,RepoAge, InsertAuditKey) VALUES (2, '31 - 60 Days', -99)
	INSERT INTO DW.DimRepoAge (RepoAgeKey,RepoAge, InsertAuditKey) VALUES (3, '61 - 90 Days', -99)
	INSERT INTO DW.DimRepoAge (RepoAgeKey,RepoAge, InsertAuditKey) VALUES (4, '91 - 120 Days', -99)
	INSERT INTO DW.DimRepoAge (RepoAgeKey,RepoAge, InsertAuditKey) VALUES (5, '121 - 150 Days', -99)
	INSERT INTO DW.DimRepoAge (RepoAgeKey,RepoAge, InsertAuditKey) VALUES (6, '151 - 180 Days', -99)
	INSERT INTO DW.DimRepoAge (RepoAgeKey,RepoAge, InsertAuditKey) VALUES (7, 'Over 181 Days', -99)

END

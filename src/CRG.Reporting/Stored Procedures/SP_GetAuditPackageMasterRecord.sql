USE [Repo.Datamart]
GO

-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'Audit'
     AND SPECIFIC_NAME = N'GetAuditPackageMasterRecord' 
)
   DROP PROCEDURE Audit.GetAuditPackageMasterRecord
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE Audit.GetAuditPackageMasterRecord
	@MasterKey int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT 
	  MasterKey,
      PackageStartDate,
      PackageEndDate,
      PackageName,
      PackageGUID,
      PackageVersionGUID,
      ProcessSucessfulIndicator,
      OptFileName
	FROM 
		[Repo.Datamart].[Audit].[AuditPackageMaster]
	WHERE 
		MasterKey = @MasterKey;
END
GO

CREATE PROCEDURE [Staging].[uspTruncateStgTables]
	@StgTableName varchar(50)
AS

BEGIN
      ---Declare Variable used to execute SQL statement

      DECLARE @StrSQL as VARCHAR(75)

      --Create Truncate Table String Expression

      SET @StrSQL = 'TRUNCATE TABLE ' + @StgTableName 

      ---Truncate table

      EXEC (@StrSQL)

END

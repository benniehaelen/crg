ALTER TABLE [DW].[FactRepo]
    ADD CONSTRAINT [FK_FactRepo_DimBorrower] FOREIGN KEY ([BorrowerKey]) REFERENCES [DW].[DimBorrower] ([BorrowerKey]) ON DELETE NO ACTION ON UPDATE NO ACTION;


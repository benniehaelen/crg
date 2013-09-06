ALTER TABLE [DW].[FactRepo]
    ADD CONSTRAINT [FK_FactRepo_DimLienHolder] FOREIGN KEY ([LienHolderKey]) REFERENCES [DW].[DimLienHolder] ([LienHolderKey]) ON DELETE NO ACTION ON UPDATE NO ACTION;


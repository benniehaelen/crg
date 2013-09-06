ALTER TABLE [DW].[FactRepo]
    ADD CONSTRAINT [FK_FactRepo_DimAdjuster] FOREIGN KEY ([AdjusterKey]) REFERENCES [DW].[DimAdjuster] ([AdjusterKey]) ON DELETE NO ACTION ON UPDATE NO ACTION;


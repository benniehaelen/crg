ALTER TABLE [DW].[FactRepo]
    ADD CONSTRAINT [FK_FactRepo_DimRepoStatus] FOREIGN KEY ([RepoStatusKey]) REFERENCES [DW].[DimRepoStatus] ([RepoStatusKey]) ON DELETE NO ACTION ON UPDATE NO ACTION;


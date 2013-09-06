ALTER TABLE [DW].[FactRepo]
    ADD CONSTRAINT [FK_FactRepo_DimRepoDetails] FOREIGN KEY ([RepoDetailsKey]) REFERENCES [DW].[DimRepoDetails] ([RepoDetailsKey]) ON DELETE NO ACTION ON UPDATE NO ACTION;


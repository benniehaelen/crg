﻿ALTER TABLE [DW].[FactRepo]
    ADD CONSTRAINT [FK_FactRepo_DimRepoAge] FOREIGN KEY ([RepoAgeKey]) REFERENCES [DW].[DimRepoAge] ([RepoAgeKey]) ON DELETE NO ACTION ON UPDATE NO ACTION;


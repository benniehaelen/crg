ALTER TABLE [DW].[FactRepo]
    ADD CONSTRAINT [FK_FactRepo_DimCaseWorker] FOREIGN KEY ([CaseWorkerKey]) REFERENCES [DW].[DimCaseWorker] ([CaseWorkerKey]) ON DELETE NO ACTION ON UPDATE NO ACTION;


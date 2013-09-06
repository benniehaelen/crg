ALTER TABLE [DW].[FactRepo]
    ADD CONSTRAINT [FK_FactRepo_DimAssignee] FOREIGN KEY ([AssigneeKey]) REFERENCES [DW].[DimAssignee] ([AssigneeKey]) ON DELETE NO ACTION ON UPDATE NO ACTION;


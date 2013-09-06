ALTER TABLE [DW].[FactRepo]
    ADD CONSTRAINT [FK_FactRepo_DimRecoveryAgentAddress] FOREIGN KEY ([RecoveryAgentAddressKey]) REFERENCES [DW].[DimRecoveryAgentAddress] ([RecoveryAgentAddressKey]) ON DELETE NO ACTION ON UPDATE NO ACTION;


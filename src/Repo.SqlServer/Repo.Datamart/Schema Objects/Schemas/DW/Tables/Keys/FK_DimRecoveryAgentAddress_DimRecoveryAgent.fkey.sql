ALTER TABLE [DW].[DimRecoveryAgentAddress]
    ADD CONSTRAINT [FK_DimRecoveryAgentAddress_DimRecoveryAgent] FOREIGN KEY ([RecoveryAgentKey]) REFERENCES [DW].[DimRecoveryAgent] ([RecoveryAgentKey]) ON DELETE NO ACTION ON UPDATE NO ACTION;


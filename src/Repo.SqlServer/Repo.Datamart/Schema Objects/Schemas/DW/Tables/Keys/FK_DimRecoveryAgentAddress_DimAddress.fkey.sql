ALTER TABLE [DW].[DimRecoveryAgentAddress]
    ADD CONSTRAINT [FK_DimRecoveryAgentAddress_DimAddress] FOREIGN KEY ([AddressKey]) REFERENCES [DW].[DimAddress] ([AddressKey]) ON DELETE NO ACTION ON UPDATE NO ACTION;


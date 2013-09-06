ALTER TABLE [DW].[DimClient]
    ADD CONSTRAINT [FK_DimClient_DimClientAddress] FOREIGN KEY ([AddressKey]) REFERENCES [DW].[DimAddress] ([AddressKey]) ON DELETE NO ACTION ON UPDATE NO ACTION;


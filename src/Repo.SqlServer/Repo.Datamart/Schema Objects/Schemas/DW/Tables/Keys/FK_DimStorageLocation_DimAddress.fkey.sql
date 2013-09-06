ALTER TABLE [DW].[DimStorageLocation]
    ADD CONSTRAINT [FK_DimStorageLocation_DimAddress] FOREIGN KEY ([AddressKey]) REFERENCES [DW].[DimAddress] ([AddressKey]) ON DELETE NO ACTION ON UPDATE NO ACTION;


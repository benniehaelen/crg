ALTER TABLE [DW].[DimBorrower]
    ADD CONSTRAINT [FK_DimBorrower_DimAddress] FOREIGN KEY ([HomeAddressKey]) REFERENCES [DW].[DimAddress] ([AddressKey]) ON DELETE NO ACTION ON UPDATE NO ACTION;


ALTER TABLE [DW].[FactRepo]
    ADD CONSTRAINT [FK_FactRepo_DimVehicleMakeModel] FOREIGN KEY ([VehicleMakeModelKey]) REFERENCES [DW].[DimVehicleMakeModel] ([VehicleMakeModelKey]) ON DELETE NO ACTION ON UPDATE NO ACTION;


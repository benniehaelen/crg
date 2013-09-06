CREATE TABLE [DW].[DimVehicleMakeModel] (
    [VehicleMakeModelKey] INT           IDENTITY (1, 1) NOT NULL,
    [VehicleMake]         VARCHAR (150) NOT NULL,
    [VehicleModel]        VARCHAR (100) NOT NULL,
    [InsertAuditKey]      INT           NOT NULL,
    [UpdateAuditKey]      INT           NULL
);


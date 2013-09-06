CREATE TABLE [DW].[DimAssignee] (
    [AssigneeKey]    INT          IDENTITY (1, 1) NOT NULL,
    [AssigneeBK]     VARCHAR (50) NOT NULL,
    [InsertAuditKey] INT          NOT NULL,
    [UpdateAuditKey] INT          NULL
);


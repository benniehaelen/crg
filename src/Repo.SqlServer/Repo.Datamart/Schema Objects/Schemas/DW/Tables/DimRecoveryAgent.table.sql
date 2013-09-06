CREATE TABLE [DW].[DimRecoveryAgent] (
    [RecoveryAgentKey] INT           IDENTITY (1, 1) NOT NULL,
    [AgentName]        VARCHAR (100) NOT NULL,
    [InsertAuditKey]   INT           NOT NULL,
    [UpdateAuditKey]   INT           NULL
);


﻿ALTER TABLE [DW].[DimRecoveryAgentAddress]
    ADD CONSTRAINT [PK_DimRecoveryAgentAddress] PRIMARY KEY CLUSTERED ([RecoveryAgentAddressKey] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);


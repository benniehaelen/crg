﻿ALTER TABLE [DW].[DimAssignee]
    ADD CONSTRAINT [PK_DimAssignee] PRIMARY KEY CLUSTERED ([AssigneeKey] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);


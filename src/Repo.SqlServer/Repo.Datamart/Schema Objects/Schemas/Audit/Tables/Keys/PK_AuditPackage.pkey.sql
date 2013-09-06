﻿ALTER TABLE [Audit].[AuditPackage]
    ADD CONSTRAINT [PK_AuditPackage] PRIMARY KEY CLUSTERED ([AuditKey] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);

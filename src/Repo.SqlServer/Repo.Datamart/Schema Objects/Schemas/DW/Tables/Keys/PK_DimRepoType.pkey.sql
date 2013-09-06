﻿ALTER TABLE [DW].[DimRepoType]
    ADD CONSTRAINT [PK_DimRepoType] PRIMARY KEY CLUSTERED ([RepoTypeKey] ASC) WITH (ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, PAD_INDEX = OFF, IGNORE_DUP_KEY = OFF, STATISTICS_NORECOMPUTE = OFF);

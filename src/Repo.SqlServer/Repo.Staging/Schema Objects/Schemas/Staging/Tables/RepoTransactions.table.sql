﻿CREATE TABLE [Staging].[RepoTransactions] (
    [StagingID]                         INT           IDENTITY (1, 1) NOT NULL,
    [CaseNumber]                        VARCHAR (50)  NULL,
    [ClientName]                        VARCHAR (50)  NULL,
    [AccountNumberWithSign]             VARCHAR (50)  NULL,
    [FirstName]                         VARCHAR (50)  NULL,
    [LastName]                          VARCHAR (50)  NULL,
    [VehicleYear]                       VARCHAR (50)  NULL,
    [Make]                              VARCHAR (150) NULL,
    [Model]                             VARCHAR (100) NULL,
    [VIN]                               VARCHAR (50)  NULL,
    [Status]                            VARCHAR (50)  NULL,
    [RepoDate]                          VARCHAR (50)  NULL,
    [CloseDate]                         VARCHAR (50)  NULL,
    [OrderDate]                         VARCHAR (50)  NULL,
    [SubStatus]                         VARCHAR (200) NULL,
    [Disposition]                       VARCHAR (50)  NULL,
    [ClientAddress]                     VARCHAR (100) NULL,
    [ClientCity]                        VARCHAR (50)  NULL,
    [ClientState]                       VARCHAR (50)  NULL,
    [ClientZip]                         VARCHAR (10)  NULL,
    [ClientPhone]                       VARCHAR (50)  NULL,
    [ClientBranchPhone]                 VARCHAR (50)  NULL,
    [ClientFax]                         VARCHAR (50)  NULL,
    [ClientBranch]                      VARCHAR (50)  NULL,
    [AccountNumber]                     VARCHAR (50)  NULL,
    [Assignee]                          VARCHAR (50)  NULL,
    [AssigneePhone]                     VARCHAR (50)  NULL,
    [LienholderName]                    VARCHAR (50)  NULL,
    [FullName]                          VARCHAR (50)  NULL,
    [DebtorMiddleInitial]               VARCHAR (50)  NULL,
    [Address]                           VARCHAR (250) NULL,
    [City]                              VARCHAR (50)  NULL,
    [State]                             VARCHAR (50)  NULL,
    [HomeZip]                           VARCHAR (10)  NULL,
    [County]                            VARCHAR (50)  NULL,
    [HomePhone]                         VARCHAR (50)  NULL,
    [BorrowersHomeAddresses]            VARCHAR (100) NULL,
    [BorrowersWorkAddresses]            VARCHAR (100) NULL,
    [CSLastName]                        VARCHAR (100) NULL,
    [CoSignerMiddleInitial]             VARCHAR (50)  NULL,
    [CSFirstName]                       VARCHAR (50)  NULL,
    [CSFullName]                        VARCHAR (100) NULL,
    [CosignerHomeAddresses]             VARCHAR (100) NULL,
    [CosignerWorkAddresses]             VARCHAR (100) NULL,
    [CR]                                VARCHAR (50)  NULL,
    [Drivable]                          VARCHAR (50)  NULL,
    [Invoice]                           VARCHAR (50)  NULL,
    [Keys]                              VARCHAR (50)  NULL,
    [Personals]                         VARCHAR (50)  NULL,
    [Photos]                            VARCHAR (50)  NULL,
    [RecoveryAgent]                     VARCHAR (100) NULL,
    [RecoveryAddress]                   VARCHAR (100) NULL,
    [RecoveryCity]                      VARCHAR (50)  NULL,
    [RecoveryState]                     VARCHAR (50)  NULL,
    [RecoveryZip]                       VARCHAR (10)  NULL,
    [RecoveryTime]                      VARCHAR (50)  NULL,
    [YearMakeModel]                     VARCHAR (200) NULL,
    [ExpirationDate]                    VARCHAR (50)  NULL,
    [TagExpirationDate]                 VARCHAR (50)  NULL,
    [VehicleLicenseState]               VARCHAR (50)  NULL,
    [VehicleLicense]                    VARCHAR (50)  NULL,
    [VehicleMileage]                    VARCHAR (50)  NULL,
    [Last6ofVIN]                        VARCHAR (50)  NULL,
    [StorageLocationName]               VARCHAR (150) NULL,
    [StorageAddress]                    VARCHAR (100) NULL,
    [StorageCity]                       VARCHAR (50)  NULL,
    [StorageState]                      VARCHAR (50)  NULL,
    [StorageZip]                        VARCHAR (10)  NULL,
    [LotSpaceNumberOfCollateral]        VARCHAR (50)  NULL,
    [Adjusters]                         VARCHAR (250) NULL,
    [AuctionName]                       VARCHAR (50)  NULL,
    [ReleaseDate]                       VARCHAR (50)  NULL,
    [AlertText]                         VARCHAR (250) NULL,
    [Branch]                            VARCHAR (50)  NULL,
    [CaseInvestigator]                  VARCHAR (50)  NULL,
    [ReferenceNumber]                   VARCHAR (50)  NULL,
    [CaseWorker]                        VARCHAR (50)  NULL,
    [ClaimNumber]                       VARCHAR (50)  NULL,
    [HoldDate]                          VARCHAR (50)  NULL,
    [NumberOfdaysWithCurrentCaseWorker] VARCHAR (50)  NULL,
    [Office]                            VARCHAR (50)  NULL,
    [RepoType]                          VARCHAR (50)  NULL,
    [AccountBalance]                    VARCHAR (50)  NULL,
    [AmountPastDue]                     VARCHAR (50)  NULL,
    [ChargeoffDate]                     VARCHAR (50)  NULL,
    [DelinquentSince]                   VARCHAR (50)  NULL,
    [MonthlyPayments]                   VARCHAR (50)  NULL,
    [LastAgentUpdateDays]               VARCHAR (50)  NULL,
    [LastUpdateDays]                    VARCHAR (50)  NULL,
    [NumberOfUpdates]                   VARCHAR (50)  NULL,
    [TransferFromAdjusterDays]          VARCHAR (50)  NULL,
    [ICRATicketNumber]                  VARCHAR (50)  NULL,
    [ICRAFirst NotificationBy]          VARCHAR (50)  NULL,
    [ICRAFirstNotificationDate]         VARCHAR (50)  NULL,
    [ICRASecondNotificationBy]          VARCHAR (50)  NULL,
    [ICRASecondNotificationDate]        VARCHAR (50)  NULL
);


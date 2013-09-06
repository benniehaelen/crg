ALTER DATABASE [$(DatabaseName)]
    ADD FILE (NAME = [Repo.Datamart], FILENAME = '$(Path2)$(DatabaseName).mdf', FILEGROWTH = 1024 KB) TO FILEGROUP [PRIMARY];


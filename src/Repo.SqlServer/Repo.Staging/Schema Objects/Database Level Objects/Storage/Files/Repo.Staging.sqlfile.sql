ALTER DATABASE [$(DatabaseName)]
    ADD FILE (NAME = [Repo.Staging], FILENAME = '$(DataPath)$(DatabaseName).mdf', FILEGROWTH = 1024 KB) TO FILEGROUP [PRIMARY];


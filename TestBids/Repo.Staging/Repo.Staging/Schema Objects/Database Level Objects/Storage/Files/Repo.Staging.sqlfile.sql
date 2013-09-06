ALTER DATABASE [$(DatabaseName)]
    ADD FILE (NAME = [Repo.Staging], FILENAME = '$(DefaultDataPath)$(DatabaseName).mdf', FILEGROWTH = 1024 KB) TO FILEGROUP [PRIMARY];


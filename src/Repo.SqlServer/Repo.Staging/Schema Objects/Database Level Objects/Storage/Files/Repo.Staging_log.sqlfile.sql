ALTER DATABASE [$(DatabaseName)]
    ADD LOG FILE (NAME = [Repo.Staging_log], FILENAME = '$(LogPath)$(DatabaseName)_log.LDF', MAXSIZE = 2097152 MB, FILEGROWTH = 10 %);


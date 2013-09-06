ALTER DATABASE [$(DatabaseName)]
    ADD LOG FILE (NAME = [Repo.Datamart_log], FILENAME = '$(Path1)$(DatabaseName)_1.LDF', MAXSIZE = 2097152 MB, FILEGROWTH = 10 %);


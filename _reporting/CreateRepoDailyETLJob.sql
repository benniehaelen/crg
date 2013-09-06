:setvar ETLJobName "Repo Data Load"

USE [msdb]
GO

IF EXISTS(SELECT [name] FROM dbo.sysjobs WHERE [name] = '$(ETLJobName)')
BEGIN
	EXEC msdb.dbo.sp_delete_job @job_name=N'$(ETLJobName)'
END
GO

DECLARE @jobId BINARY(16)
EXEC  msdb.dbo.sp_add_job @job_name=N'$(ETLJobName)', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_netsend=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
select @jobId
GO
EXEC msdb.dbo.sp_add_jobserver @job_name=N'$(ETLJobName)', @server_name = N'(local)'
GO

EXEC msdb.dbo.sp_add_jobstep @job_name=N'$(ETLJobName)', @step_name=N'Download Source File', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_fail_action=4, 
		@on_fail_step_id=5,
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'CmdExec', 
		@command=N'"$(PackageBasePath)\GetAndArchiveSourceFiles.cmd"', 
		@database_name=N'master', 
		@flags=0
GO

EXEC msdb.dbo.sp_add_jobstep @job_name=N'$(ETLJobName)', @step_name=N'Run Master Package', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_fail_action=2, 
		@on_fail_step_id=5,
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'CmdExec', 
		@command=N'"$(PackageBasePath)\RunMasterPackage.cmd"', 
		@database_name=N'master', 
		@flags=0
GO

EXEC msdb.dbo.sp_add_jobstep @job_name=N'$(ETLJobName)', @step_name=N'Process Cube', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_fail_action=2, 
		@on_fail_step_id=5,
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'CmdExec', 
		@command=N'"$(PackageBasePath)\RunProcessCubePackage.cmd"', 
		@database_name=N'master', 
		@flags=0
GO
/*
EXEC msdb.dbo.sp_add_jobstep @job_name=N'$(ETLJobName)', @step_name=N'Send Success Email', 
		@step_id=4, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_fail_action=2, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'CmdExec', 
		@command=N'"$(PackageBasePath)\SendSuccessEmail.cmd"', 
		@database_name=N'master', 
		@flags=0
GO
EXEC msdb.dbo.sp_add_jobstep @job_name=N'$(ETLJobName)', @step_name=N'Send Error Email', 
		@step_id=5, 
		@cmdexec_success_code=0, 
		@on_success_action=2, 
		@on_fail_action=2, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'CmdExec', 
		@command=N'"$(PackageBasePath)\SendErrorEmail.cmd"', 
		@database_name=N'master', 
		@flags=0
GO
*/

EXEC msdb.dbo.sp_update_job @job_name=N'$(ETLJobName)', 
		@enabled=0, 
		@start_step_id=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=2, 
		@notify_level_netsend=2, 
		@notify_level_page=2, 
		@delete_level=0, 
		@description=N'This is the Data Load job for Repo Reporting', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', 
		@notify_email_operator_name=N'', 
		@notify_netsend_operator_name=N'', 
		@notify_page_operator_name=N''
GO

EXEC msdb.dbo.sp_add_jobschedule @job_name=N'$(ETLJobName)', @name=N'Daily', 
		@enabled=0, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20121128, 
		@active_end_date=99991231, 
		@active_start_time=143000, 
		@active_end_time=235959
GO

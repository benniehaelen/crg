$ErrorActionPreference = ”Stop”
properties{
	$script:environment = "image"
	$script:namespace = "Repo"
	$script:buildDirectory = Resolve-Path ".\"
	$script:datamartName = "$namespace.Datamart"
	$script:olapDatabasename = "Repo Analysis"
}

task DeployReports -depends Configure,SetUpReportServer,CleanReporting,CreateSSASDataSource,CreateReports,CreatePromptReports
#,SetReportSecurity
task Default -depends Configure, DeployDatamart,DeployStaging #,DeployETL,DeployOLAP,DeploySQLAgentJobs
#, , DeployUI,DeployReports

#,DeployReports

task Configure {
	if($environment -eq "image") {
		$script:oltpServer = "$env:ComputerName"
		$script:olapServer = "$env:ComputerName"
		$script:etlServer = "$env:ComputerName"
		$script:rootDeploymentDirectory = "C:\BI_Data_Dev\ADI"
		$script:dataPath = "C:\SQL Server Data"
		$script:logPath = "C:\SQl Server Log"
		$script:sourceFileDirectory = "C:\ADI_SourceFiles"
		$script:historyCatchupMonthlyFileDirectory = "C:\ADI_SourceFiles_HistoryCatchup"
		$script:historyCatchupDailyFileDirectory = "C:\AD_SourceFiles_DailyCatchup"		
		$script:emailGroups = "eric.nelson2@honeywell.com"
		$script:FromEmailAddress = "hpsrevenuereport_image@honeywell.com"
		$script:thirtyTwoBitDtexecDirectory = "C:\Program Files\Microsoft SQL Server\90\DTS\Binn"
		$script:thirtyTwoBitDtexecDirectoryLocal = "C:\Program Files (x86)\Microsoft SQL Server\90\DTS\Binn"
		$script:olapDeploymentToolDirectory = "C:\Program Files\Microsoft SQL Server\100\Tools\Binn\VSShell\Common7\IDE"
		$script:olapUserGroup = "$env:ComputerName\Honeywell"
		$script:reportUserGroup = "$env:ComputerName\Honeywell", "$env:ComputerName\HA_User"
		$script:webServers = "$env:computerName"
		$script:webSiteDrive = "C"
		$script:webSitePath = "Inetpub\wwwroot\bishell.honeywell.com"
		$script:reportServerName = "$env:computername`:8080"
		$script:reportServerUrlFolder = "reportserver_reporting"
		$script:reportsPath = "/Reports"
		$script:promptReportsPath = "/Prompt Reports"
		$script:dataSourcesPath = "/Data Sources"
		$script:EmailGroupsDailyReport = "saji.saseendran@honeywell.com"	
		$script:EmailRecipientsFactoryReport = "saji.saseendran@honeywell.com"		
		$script:BIShellURL = "http://localhost/#hpsrevenuereporting"
		$script:sqlJobDeploymentDirectoryLocal = "C:"
	}
	
	if($environment -eq "sajiimage") {
		$script:oltpServer = "$env:ComputerName\SQLSERVER_R2"
		$script:olapServer = "$env:ComputerName\SQLSERVER_R2"
		$script:etlServer = "$env:ComputerName\SQLSERVER_R2"
		$script:rootDeploymentDirectory = "C:\BI_Data_Image\RepoReporting"
		$script:sqlJobDeploymentDirectoryLocal = "C:\BI_Data_Image\RepoReporting"
		$script:dataPath = "C:\SQL Server Data"
		$script:logPath = "C:\SQl Server Log"
		$script:sourceFileDirectory = "C:\BIAppSourceFiles\RepoData"
		$script:historyCatchupMonthlyFileDirectory = "C:\BIAppSourceFiles\RepoData\HistoryCatchup"
		$script:historyCatchupDailyFileDirectory = "C:\BIAppSourceFiles\RepoData\Archive"
		$script:emailGroupsJobStatus = "saji.saseendran@honeywell.com"
		$script:FromEmailAddress = "report_sajiimage@honeywell.com"
		$script:thirtyTwoBitDtexecDirectory = "C:\Program Files (x86)\Microsoft SQL Server\90\DTS\Binn"
		$script:thirtyTwoBitDtexecDirectoryLocal = "C:\Program Files (x86)\Microsoft SQL Server\90\DTS\Binn"
		$script:olapDeploymentToolDirectory = "C:\Program Files (x86)\Microsoft SQL Server\100\Tools\Binn\VSShell\Common7\IDE"
		$script:reportUserGroup = @("honeywell\E314667")
		$script:BIShellUserGroup = @("honeywell\E314667")
		$script:webServers = "$env:computerName"
		$script:webSiteDrive = "C"
		$script:webSitePath = "Inetpub\wwwroot\bishell.honeywell.com"
		$script:reportServerName = "$env:computername"
		$script:reportServerUrlFolder = "ReportServer_SQLSERVER_R2"
		$script:reportsPath = "/Reports"
		$script:promptReportsPath = "/Prompt Reports"
		$script:dataSourcesPath = "/Data Sources"
		
		$script:UserGroupSuperAdmin = @("honeywell\E314667")
		$script:EmailGroupsDailyReport = "saji.saseendran@honeywell.com"
		$script:EmailRecipientsFactoryReport = "saji.saseendran@honeywell.com"
		
		$script:BIShellURL = "http://localhost/#reporeports"			
	}
	
	if($environment -eq "bennyvm") {
		$script:oltpServer = "$env:ComputerName"
		$script:olapServer = "$env:ComputerName"
		$script:etlServer = "$env:ComputerName"
		$script:rootDeploymentDirectory = "C:\BI_Data_Image\RepoReporting"
		$script:sqlJobDeploymentDirectoryLocal = "C:\BI_Data_Image\RepoReporting"
		$script:dataPath = "C:\SQL Server Data"
		$script:logPath = "C:\SQl Server Log"
		$script:sourceFileDirectory = "C:\BIAppSourceFiles\RepoReporting"
		$script:historyCatchupMonthlyFileDirectory = "C:\BIAppSourceFiles\RepoReporting\HistoryCatchup"
		$script:historyCatchupDailyFileDirectory = "C:\BIAppSourceFiles\RepoReporting\Archive"
		$script:emailGroups = "bennie.haelen@honeywell.com"
		$script:FromEmailAddress = "report_bennyvm@honeywell.com"
		$script:thirtyTwoBitDtexecDirectory = "C:\Program Files (x86)\Microsoft SQL Server\90\DTS\Binn"
		$script:thirtyTwoBitDtexecDirectoryLocal = "C:\Program Files (x86)\Microsoft SQL Server\90\DTS\Binn"
		$script:olapDeploymentToolDirectory = "C:\Program Files (x86)\Microsoft SQL Server\100\Tools\Binn\VSShell\Common7\IDE"
		#$script:olapUserGroup = @("D3c30045-087ae9\Administrator")
		$script:reportUserGroup = @("honeywell\E455187")
		$script:BIShellUserGroup = @("honeywell\E455187")
		$script:webServers = "$env:computerName"
		$script:webSiteDrive = "C"
		$script:webSitePath = "Inetpub\wwwroot\bishell.honeywell.com"
		$script:reportServerName = "$env:computername"
		$script:reportServerUrlFolder = "ReportServer_SQLSERVER_R2"
		$script:reportsPath = "/Reports"
		$script:promptReportsPath = "/Prompt Reports"
		$script:dataSourcesPath = "/Data Sources"
		
		$script:UserGroupSuperAdmin = @("honeywell\E455187")
		$script:EmailGroupsDailyReport = "bennie.haelen@honeywell.com"
		$script:EmailRecipientsFactoryReport = "bennie.haelen@honeywell.com"
		
		$script:BIShellURL = "http://localhost/#reporeports"
			
	}
	
	if($environment -eq "AZUREQA") {
		$script:oltpServer = "CRGREPORTS"
		$script:olapServer = "CRGREPORTS"
		$script:etlServer = "CRGREPORTS"
		$script:rootDeploymentDirectory = "C:\BI_Data_Image\RepoReporting"
		$script:sqlJobDeploymentDirectoryLocal = "C:\BI_Data_Image\RepoReporting"
		$script:dataPath = "E:\SQL Server Data"
		$script:logPath = "F:\SQl Server Log"
		$script:sourceFileDirectory = "C:\BIAppSourceFiles\RepoData"
		$script:historyCatchupMonthlyFileDirectory = "C:\BIAppSourceFiles\RepoData\HistoryCatchup"
		$script:historyCatchupDailyFileDirectory = "C:\BIAppSourceFiles\RepoData\Archive"
		$script:emailGroupsJobStatus = "sajirs@hotmail.com;bhaelen@gmail.com"
		$script:FromEmailAddress = "sajirs@hotmail.com"
		$script:thirtyTwoBitDtexecDirectory = "C:\Program Files (x86)\Microsoft SQL Server\100\DTS\Binn"
		$script:thirtyTwoBitDtexecDirectoryLocal = "C:\Program Files (x86)\Microsoft SQL Server\100\DTS\Binn"
		$script:olapDeploymentToolDirectory = "C:\Program Files (x86)\Microsoft SQL Server\100\Tools\Binn\VSShell\Common7\IDE"
		$script:reportUserGroup = @("CRGREPORTS\bhaelen","CRGREPORTS\saji")
		$script:BIShellUserGroup = @("CRGREPORTS\bhaelen","CRGREPORTS\saji")
		$script:webServers = "$env:computerName"
		$script:webSiteDrive = "C"
		$script:webSitePath = "Inetpub\wwwroot\bishell.honeywell.com"
		$script:reportServerName = "$env:computername"
		$script:reportServerUrlFolder = "ReportServer_SQLSERVER_R2"
		$script:reportsPath = "/Reports"
		$script:promptReportsPath = "/Prompt Reports"
		$script:dataSourcesPath = "/Data Sources"
		
		$script:UserGroupSuperAdmin = @("CRGREPORTS\bhaelen","CRGREPORTS\saji")
		$script:EmailGroupsDailyReport = "sajirs@hotmail.com"
		$script:EmailRecipientsFactoryReport = "sajirs@hotmail.com"
		
		$script:BIShellURL = "http://localhost/#reporeports"			
	}
	
	if($environment -eq "DEV") {
		$script:oltpServer = "de08nt2224\mssql2"
		$script:olapServer = "de08nt2224\mssql2"
		$script:etlServer = "de08nt2224\mssql2"
		$script:rootDeploymentDirectory = "\\de08nt2224\E$\BI_Data_Dev\HPSRevenueReporting"
		$script:sqlJobDeploymentDirectoryLocal = "E:\BI_Data_Dev\HPSRevenueReporting"
		$script:dataPath = "F:\SQL_MSSQL2\DB02"
		$script:logPath = "F:\SQL_MSSQL2\LOG01"
		$script:sourceFileDirectory = "\\de08nt2265\e$\copSSH\home\SV-bi-HPSRevenue\"
		$script:historyCatchupMonthlyFileDirectory = "\\de08nt2265\e$\copSSH\home\SV-bi-HPSRevenue\HistoricalFiles\"
		$script:historyCatchupDailyFileDirectory = "\\de08nt2129\e$\BI_Data\HPSRevenueReporting\Archive\"
		$script:emailGroups = "Saji.Saseendran@Honeywell.com"
		$script:FromEmailAddress = "hpsrevenuereport_DEV@honeywell.com"
		$script:thirtyTwoBitDtexecDirectory = "C:\Program Files\Microsoft SQL Server\90\DTS\Binn"
		$script:thirtyTwoBitDtexecDirectoryLocal = "C:\Program Files (x86)\Microsoft SQL Server\90\DTS\Binn"
		$script:olapDeploymentToolDirectory = "C:\Program Files\Microsoft SQL Server\90\Tools\binn\VSShell\Common7\IDE"
		#$script:olapUserGroup = @("honeywell\e314667")		
		$script:webServers = "de08nt2128"
		$script:webSiteDrive = "E"
		$script:webSitePath = "Inetpub\wwwroot\bishell.honeywell.com"
		$script:reportServerName = "de08nt2128"
		$script:reportServerUrlFolder = "reportserver_reporting"
		$script:reportsPath = "/Reports"
		$script:promptReportsPath = "/Prompt Reports"
		$script:dataSourcesPath = "/Data Sources"
		
		$script:reportUserGroup = @("global\tfs_acs.bi.project.contributors")
		$script:BIShellUserGroup = @("global\tfs_acs.bi.project.contributors")
		
		$script:UserGroupSuperAdmin = @("global\tfs_acs.bi.project.contributors","HONEYWELL\E164329","HONEYWELL\E709130","HONEYWELL\E714873","HONEYWELL\E717611","HONEYWELL\E726766")
		$script:EmailGroupsDailyReport = "saji.saseendran@honeywell.com,Anders.Warnbrink@honeywell.com"
		$script:EmailRecipientsFactoryReport = "saji.saseendran@honeywell.com,Anders.Warnbrink@honeywell.com"
		
		$script:BIShellURL = "http://de08nt2128.honeywell.com/#hpsrevenuereporting"
		
	}

	if($environment -eq "QA") {
		$script:oltpServer = "de08nt2224"
		$script:olapServer = "de08nt2224"
		$script:etlServer = "de08nt2129"
		$script:rootDeploymentDirectory = "E:\BI_Data\HPSRevenueReporting"
		$script:sqlJobDeploymentDirectoryLocal = "E:\BI_Data\HPSRevenueReporting"
		$script:dataPath = "F:\SQL_DEFAULT\DB01"
		$script:logPath = "F:\SQL_DEFAULT\LOG01"
		$script:sourceFileDirectory = "\\de08nt2265\e$\copSSH\home\SV-bi-HPSRevenue\"
		$script:historyCatchupMonthlyFileDirectory = "\\de08nt2265\e$\copSSH\home\SV-bi-HPSRevenue\HistoricalFiles\"
		$script:historyCatchupDailyFileDirectory = "\\de08nt2129\e$\BI_Data\HPSRevenueReporting\Archive\"
		$script:emailGroups = "Saji.Saseendran@Honeywell.com"
		$script:FromEmailAddress = "hpsrevenuereport_QA@honeywell.com"
		$script:thirtyTwoBitDtexecDirectory = "E:\Program Files\Microsoft SQL Server\90\DTS\Binn"
		$script:thirtyTwoBitDtexecDirectoryLocal = "E:\Program Files\Microsoft SQL Server\90\DTS\Binn"
		$script:olapDeploymentToolDirectory = "E:\Program Files\Microsoft SQL Server\90\Tools\binn\VSShell\Common7\IDE"
		#$script:olapUserGroup = @("acsbi.hsgadi.pwa_users","global\tfs_acs.bi.project.contributors")
		$script:webServers = "de08nt2128"
		$script:webSiteDrive = "E"
		$script:webSitePath = "Inetpub\wwwroot\bishell-qa.honeywell.com"
		$script:reportServerName = "de08nt2128"
		$script:reportServerUrlFolder = "reportserver_reporting"
		$script:reportsPath = "/QA Reports"
		$script:promptReportsPath = "/QA Prompt Reports"
		$script:dataSourcesPath = "/QA Data Sources"
		
		$script:reportUserGroup = @("global\tfs_acs.bi.project.contributors")
		$script:BIShellUserGroup = @("global\tfs_acs.bi.project.contributors")
		
		$script:UserGroupSuperAdmin = @("global\tfs_acs.bi.project.contributors","HONEYWELL\E164329","HONEYWELL\E709130","HONEYWELL\E714873","HONEYWELL\E717611","HONEYWELL\E726766","HONEYWELL\e398837")
		$script:EmailGroupsDailyReport = "saji.saseendran@honeywell.com,Anders.Warnbrink@honeywell.com,Katie.Worthen@Honeywell.com"
		$script:EmailRecipientsFactoryReport = "saji.saseendran@honeywell.com,Anders.Warnbrink@honeywell.com"
		
		$script:BIShellURL = "http://de08nt2128.honeywell.com:8181/#hpsrevenuereporting"
	}
	
	if($environment -eq "PROD") {
		$script:oltpServer = "DE08W2310\mssql3,1433"
		$script:olapServer = "DE08W2311\msolap2"
		$script:etlServer = "DE08NT2265"
		$script:rootDeploymentDirectory = "E:\BI_Data\HPSRevenueReporting"
		$script:sqlJobDeploymentDirectoryLocal = "E:\BI_Data\HPSRevenueReporting"
		$script:dataPath = "U:\DB01"
		$script:logPath = "U:\DBLOG01"
		$script:sourceFileDirectory = "\\de08nt2265\e$\copSSH\home\SV-bi-HPSRevenue\"
		$script:historyCatchupMonthlyFileDirectory = "\\de08nt2265\e$\copSSH\home\sv-de08-hps\HistoricalFiles\"
		$script:historyCatchupDailyFileDirectory = "\\de08nt2129\e$\BI_Data\HPSRevenueReporting\Archive\"
		$script:emailGroups = "Saji.Saseendran@Honeywell.com;abhilash.joseph@honeywell.com"
		$script:FromEmailAddress = "hpsrevenuereport_PROD@honeywell.com"
		$script:thirtyTwoBitDtexecDirectory = "C:\Program Files (x86)\Microsoft SQL Server\90\DTS\Binn"
		$script:thirtyTwoBitDtexecDirectoryLocal = "C:\Program Files (x86)\Microsoft SQL Server\90\DTS\Binn"
		$script:olapDeploymentToolDirectory = "C:\Program Files (x86)\Microsoft SQL Server\90\Tools\Binn\VSShell\Common7\IDE"
		#$script:olapUserGroup = @("acsbi.hsgadi.pwa_users","global\tfs_acs.bi.project.contributors")
		$script:webServers = "de08nt1992", "de08nt1993"
		$script:webSiteDrive = "E"
		$script:webSitePath = "Inetpub\wwwroot\bishell.honeywell.com"
		$script:reportServerName = "de08nt1992"
		$script:reportServerUrlFolder = "bireportserver"
		$script:reportsPath = "/Reports"
		$script:promptReportsPath = "/Prompt Reports"
		$script:dataSourcesPath = "/Data Sources"
		
		$script:reportUserGroup = @("global\tfs_acs.bi.project.contributors","HONEYWELL\E314667","HONEYWELL\E164329","HONEYWELL\E709130","HONEYWELL\E714873","HONEYWELL\E717611","HONEYWELL\E726766")
		$script:BIShellUserGroup = @("global\tfs_acs.bi.project.contributors","HONEYWELL\E314667","HONEYWELL\E164329","HONEYWELL\E709130","HONEYWELL\E714873","HONEYWELL\E717611","HONEYWELL\E726766")
		
		$script:UserGroupSuperAdmin = @("global\tfs_acs.bi.project.contributors","HONEYWELL\E314667","HONEYWELL\E164329","HONEYWELL\E709130","HONEYWELL\E714873","HONEYWELL\E717611","HONEYWELL\E726766")
		$script:EmailGroupsDailyReport = "saji.saseendran@honeywell.com,Anders.Warnbrink@honeywell.com,stacy.turano@honeywell.com,Katie.Worthen@Honeywell.com,Peter.Rossiter@Honeywell.com,Jill.Barney@Honeywell.com,john.heid@honeywell.com,Mark.Majocha@Honeywell.com,Alexander.Coy@Honeywell.com"
		$script:EmailRecipientsFactoryReport = "saji.saseendran@honeywell.com,Anders.Warnbrink@honeywell.com,stacy.turano@honeywell.com,Katie.Worthen@Honeywell.com,Peter.Rossiter@Honeywell.com,Jill.Barney@Honeywell.com,john.heid@honeywell.com,Mark.Majocha@Honeywell.com,Alexander.Coy@Honeywell.com"
		
		$script:BIShellURL = "http://bishell.honeywell.com/#hpsrevenuereporting"
	}
	
	$script:etlDeploymentDirectory = "$script:rootDeploymentDirectory\ETL"
	$script:archiveDirectory = "$script:rootDeploymentDirectory\Archive"
	$script:stagingBasePath = "$script:rootDeploymentDirectory\staging"
	$script:etlLogDirectory = "$script:etlDeploymentDirectory\log"
	$script:datamartDatabaseName = "$script:namespace.Datamart"
	$script:stagingDatabaseName = "$script:namespace.Staging"
	$script:tempDownloadFolder = "$script:rootDeploymentDirectory\TempDownloadFolder"
	$script:FileDownLoadDirectory = "$script:etlDeploymentDirectory\DataFileDownload"
	
	$script:repoReportsName = "Repo Reports"
	$script:repoReportspath = "$script:reportsPath/$script:repoReportsName"
	$script:ssasDataSourceName = "Repo Reporting Cube"
	
	#declared here as there is only one team room. In case of multiple team rooms for DEV/QA and PROD, move this declartion
	#under each environment and assign corresponding team room URL
	$script:teamRoomURL = "http://teams.honeywell.com/sites/HPS_Mgmt_Rpt/Revenue Source Files/"
	$script:teamRoomURLFactoryRevenue = "http://teams.honeywell.com/sites/HPS_Mgmt_Rpt/Factory Revenue Source Files/"
	
	#Report Server Execution web service URL.
	$script:ReportServerExecutionURI = "http://$script:reportServerName/$script:reportServerUrlFolder/ReportExecution2005.asmx?WSDL"
	
	$script:DailyReportFormat = "HTML4.0"
	
#	[System.Reflection.Assembly]::LoadFile("$script:buildDirectory\ReportService2005.dll")
}

task DeployETL {
	$name = "$namespace.Integration"
	DeleteDirectoryIfItExists $script:etlDeploymentDirectory
	CreateDirectoryIfItDoesNotExist $script:rootDeploymentDirectory
	write-host "$script:buildDirectory\$name"
	write-host "$script:etlDeploymentDirectory"
	CopyFiles "$script:buildDirectory\$name" $script:etlDeploymentDirectory *
	"$script:stagingBasePath\data\textfiles", "$script:stagingBasePath\data\excelfiles", "$script:etlDeploymentDirectory\log" | ForEach-Object { CreateDirectory $_ }
	CreateDirectoryIfItDoesNotExist $script:archiveDirectory
	CreateDirectory $script:etlLogDirectory
	CreateDirectory $script:tempDownloadFolder
	CreateDirectory $script:FileDownLoadDirectory
	
	Set-ItemProperty "$script:etlDeploymentDirectory\ETLConfiguration.dtsConfig" -name IsReadOnly -value $false
	SetConfig "$script:etlDeploymentDirectory\ETLConfiguration.dtsConfig" "/DTSConfiguration/Configuration[@Path='\Package.Variables[User::StagingSvr].Properties[Value]']/ConfiguredValue" "$script:oltpServer"
}

task DeployDatamart {
	$variables = @{
		"Path2"="$script:dataPath\";
		"Path1"="$script:logPath\";
		"DatabaseName"="$script:datamartName"}
	
	RunSQLCMD $script:oltpServer $variables "$script:buildDirectory\$script:datamartName\$script:datamartName.sql"
}

task DeployStaging -Depends Configure {
	
	$name = "$namespace.Staging"
	$variables = @{
		"DataPath"="$script:dataPath\";
		"LogPath"="$script:logPath\";
		"DatabaseName"="$name";
		"DATAMART"="$script:datamartName"
		"DatabaseServer"="$script:oltpServer";
		"OLAPServer"="$script:olapServer";
		"OLAPCubeDB"="$script:olapDatabasename";
		"PackagePath"="$script:sqlJobDeploymentDirectoryLocal\ETL\";
		"StagingBasePath"="$script:sqlJobDeploymentDirectoryLocal\staging\";
		"SourceFileDirectory"="$script:sourceFileDirectory\";
		"SourceFileDirectoryHistoryCatchupFiles"="$script:historyCatchupMonthlyFileDirectory\";
		"SourceFileDirectoryDailyCatchupFiles"="$script:historyCatchupDailyFileDirectory\";
		"EmailGroupsJobStatus"="$script:emailGroupsJobStatus";
		"FromEmailAddress"="$script:FromEmailAddress";
		"ArchiveDirectory"="$script:archiveDirectory\";
		"ThirtyTwoDtexecDirectory"="$script:thirtyTwoBitDtexecDirectoryLocal";		
		"BIShellURL"="$script:BIShellURL";
		"TempDownloadFolder"="$script:tempDownloadFolder";}
	Write-Host "Oltp: $script:oltpServer" 		
	RunSQLCMD $script:oltpServer $variables "$script:buildDirectory\$name\$name.sql"
}

task DeployOLAP {
	write-host $script:olapDeploymentToolDirectory
	$env:Path = $env:Path + ";$script:olapDeploymentToolDirectory"
	
	$name = "$namespace.Analysis"
	
	$olapBuildDirectory = "$script:buildDirectory\$name"
	
	SetConfig "$olapBuildDirectory\$name.configsettings" "/ConfigurationSettings/Database/DataSources/DataSource/ConnectionString" "Provider=SQLNCLI10.1;Data Source=$script:oltpServer;Integrated Security=SSPI;Initial Catalog=$script:datamartName"
	SetConfig "$olapBuildDirectory\$name.deploymentoptions" "/DeploymentOptions/RoleDeployment" "DeployRolesAndMembers"
	SetConfig "$olapBuildDirectory\$name.deploymentoptions" "/DeploymentOptions/ProcessingOption" "DoNotProcess"
	SetConfig "$olapBuildDirectory\$name.deploymenttargets" "/DeploymentTarget/ConnectionString" "DataSource=$script:olapServer;Timeout=0"
	SetConfig "$olapBuildDirectory\$name.deploymenttargets" "/DeploymentTarget/Database" $script:olapDatabasename
	SetConfig "$olapBuildDirectory\$name.deploymenttargets" "/DeploymentTarget/Server" "$script:olapServer"
	
	RunCMD "$script:olapDeploymentToolDirectory\Microsoft.AnalysisServices.Deployment" "`"$olapBuildDirectory\$name.asdatabase`" /s"
	
		
	#CreateSSASRoleSuperAdmin
	
	
}

function CreateSSASRoleSuperAdmin {	
	[Reflection.Assembly]::LoadWithPartialName("Microsoft.AnalysisServices")
	
	$server = New-Object Microsoft.AnalysisServices.Server
	$server.connect("data source=$script:olapServer")

	$database = $server.Databases["$script:olapDatabasename"]

	$roleName = "HPS Revenue Super Users"
	$role = $database.Roles.Add($roleName)

	#loop through the array of members and add it
	$arrCount = $script:UserGroupSuperAdmin.Count-1
	
	for ($i=0; $i -le $arrCount; $i++)
	{
		$olapADGroup = $script:UserGroupSuperAdmin[$i]
		$roleMember = New-Object Microsoft.AnalysisServices.RoleMember("$olapADGroup")
		$role.Members.Add($roleMember)
		$role.Update()
	}

	

	$databasePermission = $database.DatabasePermissions.Add("$roleName_DatabasePermission")
	$databasePermission.RoleId = $roleName
	$databasePermission.ReadDefinition = "Allowed"
	$databasePermission.Read = "Allowed"
	$databasePermission.Update()

	$cube = $database.Cubes.GetByName("HPS Revenue Reporting")

	$cubePermission = $cube.CubePermissions.Add("$roleName_CubePermission")
	$cubePermission.RoleId = $roleName
	$cubePermission.Read = "Allowed"
	$cubePermission.Update()
}

function CreateSSASRole($roleName, [string[]] $users, [string] $allowedSetProdFamily, [string] $allowedSetPLUnit) {
	[Reflection.Assembly]::LoadWithPartialName("Microsoft.AnalysisServices")
	$server = New-Object Microsoft.AnalysisServices.Server
	$server.connect("data source=$script:olapServer")

	$database = $server.Databases["$script:olapDatabasename"]

	$role = $database.Roles.Add($roleName)

	foreach($user in $users) {		
		#$user
		$roleMember = New-Object Microsoft.AnalysisServices.RoleMember("$user")
		$role.Members.Add($roleMember)
		$role.Update()
		
	}

	$databasePermission = $database.DatabasePermissions.Add("$roleName_DatabasePermission")
	$databasePermission.RoleId = $roleName
	$databasePermission.ReadDefinition = "Allowed"
	$databasePermission.Read = "Allowed"
	$databasePermission.Update()

	$cube = $database.Cubes.GetByName("ADI PWA Cube")

	$cubePermission = $cube.CubePermissions.Add("$roleName_CubePermission")
	$cubePermission.RoleId = $roleName
	$cubePermission.Read = "Allowed"
	$cubePermission.Update()

	$dimension = $database.Dimensions.GetByName("Product")

	$dimensionPermissions = $dimension.DimensionPermissions.Add("$roleName_DimensionPermissions")
	$dimensionPermissions.RoleId = $roleName

	$dimensionAttribute = $dimension.Attributes.GetByName("Product Family")
	$dimensionAttributePermissions = $dimensionPermissions.AttributePermissions.Add($dimensionAttribute.Id)
	$dimensionAttributePermissions.VisualTotals = "1"
	$dimensionAttributePermissions.AllowedSet = "$allowedSetProdFamily"
	$dimensionPermissions.Update()
	
	#PLUnit permissions
	$dimensionPLUnit = $database.Dimensions.GetByName("PLUnit")

	$dimensionPermissionsPLUnit = $dimensionPLUnit.DimensionPermissions.Add("$roleName_PLUnitDimensionPermissions")
	$dimensionPermissionsPLUnit.RoleId = $roleName
	
	$dimensionAttributePLUnit = $dimensionPLUnit.Attributes.GetByName("PL Unit")
	$dimensionAttributePermissionsPLUnit = $dimensionPermissionsPLUnit.AttributePermissions.Add($dimensionAttributePLUnit.Id)
	$dimensionAttributePermissionsPLUnit.VisualTotals = "1"
	$dimensionAttributePermissionsPLUnit.AllowedSet = "$allowedSetPLUnit"
	$dimensionPermissionsPLUnit.Update()
}

task DeploySQLAgentJobs {
	$variables = @{
		"PackageBasePath"="$script:sqlJobDeploymentDirectoryLocal\ETL";
		"ThirtyTwoDtexecDirectory"="$script:thirtyTwoBitDtexecDirectoryLocal"
	}

	RunSQLCMD $script:etlServer $variables "$script:buildDirectory\CreateRepoDailyETLJob.sql"
	#RunSQLCMD $script:etlServer $variables "$script:buildDirectory\CreateHistoricalDataLoadETLJob.sql"
	#RunSQLCMD $script:etlServer $variables "$script:buildDirectory\CreateDailyCatchupETLJob.sql"
}

task DeployUI -depends Configure  {
	$script:webServers | ForEach-Object {
		
		$webSiteUnc = "//$_/$script:webSiteDrive`$/$script:webSitePath"
		$code = "hpsrevenuereporting"
		$name = "$script:namespace.UI"
		$odcFileDeployLocation = "$webSiteUnc\HON.ACS.Common.BIShell.Assets\DataConnections"

		CopyFile "$script:buildDirectory\$name\Application.xap" "$webSiteUnc\Applications\$code"
		CopyFile "$script:buildDirectory\$name\$code.odc" $odcFileDeployLocation
	
		$odcFile = "$odcFileDeployLocation\$code.odc"

		(Get-Content $odcFile)  | ForEach-Object {
			if($_.Contains("<odc:ConnectionString>")) {
				"<odc:ConnectionString>Provider=MSOLAP.4;Integrated Security=SSPI;Persist Security Info=True;Initial Catalog=$script:olapDatabaseName;Data Source=$script:olapServer;MDX Compatibility=1;Safety Options=2;MDX Missing Member Mode=Error</odc:ConnectionString>"
			} 
			else {
				$_
			}
		} | Set-Content $odcFile

		$script:BIShellUserGroup | ForEach-Object {
			$acl = Get-Acl $webSiteUnc
			$rule = New-Object System.Security.AccessControl.FileSystemAccessRule($_,"Read", "ContainerInherit, ObjectInherit", "None", "Allow")
			$acl.AddAccessRule($rule)
			Set-Acl $webSiteUnc $acl
		}
	}
}

function SetConfig($path, $xpath, $value) {
    $doc = new-object System.Xml.XmlDocument
    $doc.Load($path)
	$node = $doc.SelectSingleNode($xpath)
	$node."#Text" = $value
	$doc.Save($path)
}

function CreateDirectory($path) {
	New-Item $path -type directory -force
}

function CreateDirectoryIfItDoesNotExist($path) {
	if (!(Test-Path -path $path))
	{
		CreateDirectory($path)
	}
}

function CopyFiles($sourceDirectory, $destinationDirectory, $fileTypes) 
{
  Foreach ($file in Get-Childitem $sourceDirectory\* -include $fileTypes -recurse) {
    $newPath = $file.DirectoryName.Replace($sourceDirectory, $destinationDirectory)
	
    CopyFile $file $newPath
  }
}

function CopyFile($file, $directory){
    if(!(test-path $directory)) {
        New-Item $directory -type directory
    }
    
    Copy-item $file $directory
}

function DeleteDirectoryIfItExists($path) {
	if((test-path $path)) {
        Remove-Item $path -recurse -force
    }
}


function ExecuteSQL($server, $statement) {
	$arguments = "-S $server"
	$arguments = "$arguments -Q `"$statement`""
	
	RunCMD "sqlcmd" $arguments
}

function RunSQLCMD($server, $variables, $file) {
	$arguments = "-S $server"
	$variables.GetEnumerator() | ForEach-Object {
		$arguments = "$arguments -v $($_.Key)=`"$($_.Value)`""
	}
	$arguments = "$arguments -i `"$file`""
	
	RunCMD "sqlcmd" $arguments
}

function RunCMD($commandName, $arguments) {
    $startInfo = New-Object Diagnostics.ProcessStartInfo($commandName)
    $startInfo.UseShellExecute = $false
    $startInfo.Arguments = $arguments
    $process = [Diagnostics.Process]::Start($startInfo)
    $process.WaitForExit()
    $exitCode = $process.ExitCode
    if($exitCode -ne 0) { throw $errorMessage}
}

task RunHistoryCatchupJob {
	Write-Host "Running SQL Agent Job: ADI PWA History Catchup Load. This will take anywhere between 7 to 10 hours. Please be patient.."
	ExecuteSQLAgentJob 'ADI PWA History Catchup Load' 'Copy Daily Excel Files from FTP'
}

task RunHistoryDailyCatchupJob {
	
	$strMonthEndDates = @("4/1/2011","4/29/2011","5/27/2011","7/1/2011", "7/29/2011")
	$strZipFileDates = @("4/2/2011","4/30/2011","5/28/2011","7/2/2011", "7/30/2011")
	
	$arrCount = $strMonthEndDates.Count-1
	
	for ($i=0; $i -le $arrCount; $i++)
	{
		$dtMonthEnd = $strMonthEndDates[$i]
		$dtZipFile = $strZipFileDates[$i]
		$strUpdateDW = "UPDATE [$script:datamartDatabaseName].DW.DataLoadDateTemp SET DataLoadDate =`'$dtMonthEnd`' , DataLoadInterval =`'D`'"
		$strUpdateStg = "UPDATE [$script:stagingDatabaseName].Staging.DataLoadCatchupDailyTemp SET StartDate =`'$dtZipFile`' , EndDate =`'$dtZipFile`'"
		
		ExecuteSQL $script:oltpServer "$strUpdateDW"
		ExecuteSQL $script:oltpServer "$strUpdateStg"		
		
		Write-Host "Running SQL Agent Job: ADI PWA Daily Catchup Load for $dtZipFile"
		
		ExecuteSQLAgentJob 'ADI PWA Daily Catchup Load' 'Load Daily Excel Files'
	}

	
	#Once the monthly files until July are loaded, we can load daily files starting August 2nd.
	#update the data load date and start and end dates
	$strUpdateDW1 = "UPDATE [$script:datamartDatabaseName].DW.DataLoadDateTemp SET DataLoadDate =`'8/1/2011`' , DataLoadInterval =`'D`'"
	ExecuteSQL $script:oltpServer "$strUpdateDW1"
	$strUpdateStg1 = "UPDATE [$script:stagingDatabaseName].Staging.DataLoadCatchupDailyTemp SET StartDate =`'8/2/2011`' , EndDate =`'8/12/2011`'"
	ExecuteSQL $script:oltpServer "$strUpdateStg1"
	
	Write-Host "Running SQL Agent Job: ADI PWA Daily Catchup Load from 8/2/2011 to 8/12/2011"
	ExecuteSQLAgentJob 'ADI PWA Daily Catchup Load' 'Load Daily Excel Files'
}



function ExecuteSQLAgentJob($jobName, $stepName) {
	[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.Smo")
	$server = New-Object Microsoft.SqlServer.Management.Smo.Server($etlServer)
	$job = $server.JobServer.Jobs[$jobName]

	$oldLastRunDate = $job.LastRunDate

	

	$job.Start("$stepName")

	while($oldLastRunDate -eq $job.LastRunDate)
	{
		$job.Refresh()
		$newLastRunDate = $job.LastRunDate
	}

	if($job.LastRunOutcome -eq "Succeeded")
	{
		"SQL Agent Job Succeeded"
	}
	else
	{
		"SQL Agent Job Failed"
		Throw [system.Exception]
	}
}

task SetUpReportServer {
	$script:reportServer = New-Object ReportService.ReportingService2005
	$reportServer.Url = "http://$script:reportServerName/$script:reportServerUrlFolder/ReportService2005.asmx"
	$reportServer.Credentials = [System.Net.CredentialCache]::DefaultCredentials
}

task CleanReporting {
	write-host "script:reportsPath - $script:reportsPath"
	write-host "script:hpsRevReportsName - $script:hpsRevReportsName"
	$existingFolder = $reportServer.ListChildren("$script:reportsPath", $True) | Where { $_.Name -eq $script:hpsRevReportsName }
	
	if($existingFolder -ne $NULL) {
					$reportServer.DeleteItem($script:hpsReportsPath)
	}
	
	$reportServer.CreateFolder($script:hpsRevReportsName, "$script:reportsPath", $null)		
}

task CreateSSASDataSource {
	$existingDataSource = $reportServer.ListChildren($script:dataSourcesPath, "false") | where {$_.Name -eq $script:ssasDataSourceName}

	if($existingDataSource -eq $null) {
		$definition = New-Object ReportService.DataSourceDefinition
		$definition.CredentialRetrieval = [ReportService.CredentialRetrievalEnum]::Integrated
		$definition.ConnectString = "Data Source=$script:olapServer;Initial Catalog=$script:olapDatabaseName"
		$definition.Extension = "OLEDB-MD"
		$reportServer.CreateDataSource($script:ssasDataSourceName, "$script:dataSourcesPath", "false", $definition, $NULL)
	}
}

task CreateReports {
	$sourceFolder = "$script:buildDirectory\HON.ACS.HPS.RevenueReporting.Reporting"
	$hpsReportNames = @("DailySummaryReport")

	#These are sub reports which are set to hidden so that it doesnt show up in BI Shell
	$hpsHiddenReports = @("DailySummaryReportForLOB") 
	
	$hiddenProperty = New-Object ReportService.Property
	$hiddenProperty.Name = "Hidden"
	$hiddenProperty.Value = "True"

	createReports $hpsReportNames $sourceFolder $script:hpsReportspath $NULL
	createReports $hpsHiddenReports $sourceFolder $script:hpsReportspath $hiddenProperty
	
}

task CreatePromptReports {
	$sourceFolder = "$script:buildDirectory\HON.ACS.HPS.RevenueReporting.Reporting.PromptReports"
	$reportNames = @("HPSRevenue_FiscalCalendar","HPSRevenue_RevenueType", "HPSRevenue_FiscalCalendar_Date")
					
	createReports $reportNames $sourceFolder $script:promptReportsPath $NULL
}

task SetReportSecurity {
	$administerRole = New-Object ReportService.Role
	$administerRole.Name = "Content Manager"
	
	$browserRole = New-Object ReportService.Role
	$browserRole.Name = "Browser"
	
	$administerPolicy = New-Object ReportService.Policy
	$administerPolicy.GroupUserName = "BUILTIN\Administrators"
	$administerPolicy.Roles = @($administerRole)
	
	$adiPolicies = @($administerPolicy)
	
	foreach($groupName in $script:reportUserGroup)
	{
		$adiPolicy = New-Object ReportService.Policy
		$adiPolicy.GroupUserName = $groupName
		$adiPolicy.Roles = @($browserRole)
		
		[array]$adiPolicies += $adiPolicy
	}
	
	#$reportsPolicies = $reportServer.GetPolicies($script:reportsPath, [ref]$true)
	#foreach($group in $script:reportUserGroup) {
	#	$reportsPolicies = $reportsPolicies | where {$group -notcontains $_.GroupUserName }
	#}
	#[array]$reportsPolicies += $adiPolicy
	
	#$promptReportPolicies = $reportServer.GetPolicies($script:promptReportsPath, [ref]$true)
	#foreach($group in $script:reportUserGroup) {
	#	$promptReportPolicies = $promptReportPolicies | where {$group -notcontains $_.GroupUserName }
	#}
	#[array]$promptReportPolicies += $adiPolicy
	
	#$reportServer.SetPolicies($script:reportsPath, $reportsPolicies)
	#$reportServer.SetPolicies($script:promptReportsPath, $promptReportPolicies)
	
	$reportServer.SetPolicies($script:adiReportspath, $adiPolicies)
	
}


function createReports($reportNames, $reportSourceFolder, $reportServerFolder, $properties) {
	foreach ($reportName in $reportNames) {
		$definition = [System.IO.File]::ReadAllBytes("$reportSourceFolder\$reportName.rdl")
		$reportServer.CreateReport("$reportName", $reportServerFolder, "true", $definition, $properties)
		setDataSourceReference "$reportName" $reportServerFolder 
	}
}

function setDataSourceReference($reportName, $reportServerFolder) {
	$reportPath = "$reportServerFolder/$reportName"

	$dataSourceReferences = $reportServer.GetItemDataSources($reportPath)
	
	$dataSourceReference = New-Object ReportService.DataSourceReference
	$dataSourceReference.Reference = "$script:dataSourcesPath/$script:ssasDataSourceName"
	$dataSource = New-Object ReportService.DataSource
	$dataSource.Name = $dataSourceReferences[0].Name
	$dataSource.Item = $dataSourceReference
	
	$reportServer.SetItemDataSources($reportPath, @($dataSource))
}


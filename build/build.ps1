$framework = '4.0x86'

properties {
  $trunkDirectory = Resolve-Path ".."
  $rootSourceDirectory = "$trunkDirectory\src"
  $rootBuildDirectory = "$trunkDirectory\binaries"
  $buildNumber = "1.0.0.0"
  $visualStudio2008Directory = "C:\Program Files (x86)\Microsoft Visual Studio 9.0\Common7\IDE\devenv.exe"
  $namespace = "Repo"
}

task default -depends Clean,AddInstallItems,BuildDatabases,BuildETL, BuildFileDownloadApp, BuildOLAP
#, , BuildShellApplication, BuildReporting,CompressBinaries


task Clean { 
  if(Test-Path $rootBuildDirectory) {
    Remove-Item $rootBuildDirectory -recurse -force
  }
}

task AddInstallItems {
	$rootBuildDirectory 
	write-host "copying install items..."
	CopyFiles "$trunkDirectory\Build" "$rootBuildDirectory" *.ps1,*.psm1,*.dll,*.proj
	CopyFiles "$rootSourceDirectory\$namespace.SQLAgent" "$rootBuildDirectory" *.sql
}

task BuildDatabases -depends Clean,AddInstallItems {
	$databases = "$namespace.Datamart", "$namespace.Staging"
	
	foreach($database in $databases) {
		BuildDatabaseProject "$rootSourceDirectory\$namespace.SQLServer\$database" "$database"
	}
}

task BuildOLAP {
	$projectName = "$namespace.Analysis"
	$sourceDirectory = "$rootSourceDirectory\$namespace.Analysis"
	write-host $sourceDirectory
	Exec { & $visualStudio2008Directory "`"$sourceDirectory\$projectName.dwproj`"" /rebuild Development /project $projectName /nosplash | Out-Null }
	CopyFiles "$sourceDirectory\bin" "$rootBuildDirectory\$projectName" "*"
}

task BuildETL {
	$name = "$namespace.Integration"
	$compressionName = "Common.Compression"
	$dataFileDownload = "DataFileDownload"
	#$generateReports = "ReportGeneration"
	
	write-host "$rootSourceDirectory\$name\$compressionName" 
	write-host "$rootBuildDirectory\$name\$compressionName"
	
	CopyFiles "$rootSourceDirectory\$name" "$rootBuildDirectory\$name" *.dtsx,*.dtsconfig,*.cmd
	CopyFiles "$rootSourceDirectory\$name\$compressionName" "$rootBuildDirectory\$name\$compressionName" *
	CopyFiles "$rootSourceDirectory\$name\$dataFileDownload" "$rootBuildDirectory\$name\$dataFileDownload" *
	#CopyFiles "$rootSourceDirectory\$name\$generateReports" "$rootBuildDirectory\$name\$generateReports" *
	#Set-ItemProperty "$rootBuildDirectory\$name\$sharePointAccess\HON.ACS.HPS.SharePointListManagement.dll" -name IsReadOnly -value $false 
}

task BuildShellApplication {
	$name = "$namespace.UI"
	$sourceDirectory = "$rootSourceDirectory\$name"

	BuildProject "$sourceDirectory" $name "csproj" "rebuild"
	CopyFile $sourceDirectory\hpsrevenuereporting.odc $rootBuildDirectory\$name
    CopyFile $sourceDirectory\bin\release\Application.xap $rootBuildDirectory\$name
	
	Set-ItemProperty "$rootBuildDirectory\$name\hpsrevenuereporting.odc" -name IsReadOnly -value $false
}

task BuildFileDownloadApp {

	$name = "$namespace.DownloadRepoData"
	$sourceDirectory = "$rootSourceDirectory\$name\DownloadRepoData"
	BuildProject "$sourceDirectory" $name "csproj" "rebuild"
	#write-host "$sourceDirectory\bin\release\DownloadRepoData.exe"
	#write-host "$vs2005Directory\$name\ReportGeneration"
	CopyFile $sourceDirectory\bin\release\DownloadRepoData.exe $vs2005Directory\$namespace.Integration\DataFileDownload
	
	$script:FileDownLoadDirectory
}

task BuildReporting {
	$name = "$namespace.Reporting"
	$promptReportsName = "$namespace.Reporting.PromptReports"
	
	CopyFiles "$rootSourceDirectory\$name" "$rootBuildDirectory\$name" *.rdl
	CopyFiles "$rootSourceDirectory\$promptReportsName" "$rootBuildDirectory\$promptReportsName" *.rdl
}

task SetFilesNotReadOnly{
	write-host "rootBuild - $rootBuildDirectory"
	$readonly = [System.IO.FileAttributes]::ReadOnly
	get-childitem "$rootBuildDirectory\*" -recurse | foreach { 
		if ($_.Attributes -band $readonly -eq $readonly) { 
			$_.Attributes = $_.Attributes -bxor $readonly
		} 
	} 
}

task CompressBinaries {
	[System.Reflection.Assembly]::LoadFrom( "Ionic.Zip.dll" )
	
	$zipFile = New-Object Ionic.Zip.ZipFile
	$zipFile.AddDirectory("$rootBuildDirectory") | Out-Null
	$zipFile.Save("$rootBuildDirectory\HPS_RevenueReporting_$buildNumber.zip") | Out-Null
}

function BuildDatabaseProject($sourceDirectory, $name){
	BuildProject "$sourceDirectory" "$name" "dbproj" "rebuild;deploy"
    $sqlFile = "$sourceDirectory\sql\release\$name.sql"
    (Get-Content $sqlFile) -replace ":setvar","--setvar" | Set-Content $sqlFile
    CopyFile $sqlFile $rootBuildDirectory\$name
}

function BuildProject($sourceDirectory, $name, $extension, $target){
    Exec { msbuild "$sourceDirectory\$name.$extension" /t:$target /p:Configuration=Release }
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

function RunCMD($commandName, $arguments) {
	write-host "command - $commandName"
    $startInfo = New-Object Diagnostics.ProcessStartInfo($commandName)
    $startInfo.UseShellExecute = $false
    $startInfo.Arguments = $arguments
    $process = [Diagnostics.Process]::Start($startInfo)
    $process.WaitForExit()
    $exitCode = $process.ExitCode
    if($exitCode -ne 0) { throw $errorMessage}
}
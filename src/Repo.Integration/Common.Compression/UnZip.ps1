# PowerShell script to unzip the files #

$zipDllPath
$SourceZipFile
$extractFolder

$dllName = "Ionic.Zip.dll" 
$zipDllPath = $args[0]
$SourceZipFile = $args[1]
$extractFolder = $args[2]

$ErrorActionPreference = "Stop"

[System.Reflection.Assembly]::LoadFrom("$zipDllPath$dllName")

$zipFile = [Ionic.Zip.ZipFile]::Read($SourceZipFile)


foreach($file in $zipFile )
{
  $file.extract($extractFolder, [Ionic.Zip.ExtractExistingFileAction]::OverwriteSilently)  
}

$zipFile.Dispose()

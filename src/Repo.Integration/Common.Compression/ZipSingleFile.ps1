$ErrorActionPreference = "Stop"

	$dllName = "Ionic.Zip.dll"
	$zipDllPath  
	$ArchiveLocation  
	$FileToZip  
	$ZipFileName  
	$FilePath

	$zipDllPath  = $args[0]
	$ArchiveLocation  = $args[1]
	$FileToZip  = $args[2]
	$ZipFileName  = $args[3]
	$FilePath  = $args[4]

	
	[System.Reflection.Assembly]::LoadFrom("$zipDllPath$dllName")
	
	$zipfile =  new-object Ionic.Zip.ZipFile
	$zipfile.AddFile($FileToZip,$FilePath)
	$zipfile.Save("$ArchiveLocation$ZipFileName")
	$zipfile.Dispose()

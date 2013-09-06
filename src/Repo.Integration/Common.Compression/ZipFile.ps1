$ErrorActionPreference = "Stop"
$uName
properties {
	$dllName = "Ionic.Zip.dll"
	$zipDllPath = ""
	$ArchiveLocation = ""
	$FileToZip = ""
	$ZipFileName = ""
}

task ZipOneFile {
	
	ArchiveSingleFile $zipDllPath $ArchiveLocation $FileToZip $ZipFileName 
	
}

function ArchiveSingleFile($zipDllPath, $ArchiveLocation, $FileToZip, $ZipFileName) {
	
	[System.Reflection.Assembly]::LoadFrom("$zipDllPath$dllName")
	
	$zipfile =  new-object Ionic.Zip.ZipFile
	$zipfile.AddFile($FileToZip,"C:\BI_Data_Dev\IndirectSpend\staging\data\TextFiles")
	$zipfile.Save("$ArchiveLocation$ZipFileName")
	$zipfile.Dispose()
}
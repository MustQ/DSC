Configuration rWinSQL2014
{
	
	$PackagePath = "\\dyul1dsc001\DSCShare\"
	$winsources = "\\dyul1dsc001\DSCShare\WinSources\sources\sxs\"
	import-dscresource -module cWindowsOS
	import-dscresource -module xPSDesiredStateConfiguration
	
	Log ParamLog
	{
		Message = "Running SQLInstall. PackagePath = $PackagePath"
	}
	
	WindowsFeature NetFramework35Core
	{
		Name = "NET-Framework-Core"
		Ensure = "Present"
		Source = $WinSources
	}
	
	WindowsFeature NetFramework45Core
	{
		Name = "NET-Framework-45-Core"
		Ensure = "Present"
		Source = $WinSources
	}
	
	# copy the sqlserver iso & rename to sqlserver.iso
	File SQLServerIso
	{
		SourcePath = "$PackagePath\sql\SW_DVD9_SQL_Svr_Standard_Edtn_2014_64Bit_English_MLF_X19-34513.iso"
		DestinationPath = "c:\_install\SQLServer.iso"
		Type = "File"
		Ensure = "Present"
	}
	
	Log AfterSQLISOCopy
	{
		# The message below gets written to the Microsoft-Windows-Desired State Configuration/Analytic log
		Message = "Finished running the file resource with ID SQLServerIso"
		DependsOn = "[File]SQLServerIso" # This means run "SQLServerIso" first.
	}
	
	# copy the ini file to the temp folder
	File SQLServerIniFile
	{
		SourcePath = "$PackagePath\sql\ConfigurationFile.ini"
		DestinationPath = "c:\_install"
		Type = "File"
		Ensure = "Present"
		Force = $true
		DependsOn = "[File]SQLServerIso"
		MatchSource = $true
	}
	
	Log AfterSQLInICopy
	{
		# The message below gets written to the Microsoft-Windows-Desired State Configuration/Analytic log
		Message = "Finished running the file resource with ID SQLServerIniFile"
		DependsOn = "[File]SQLServerIniFile" # This means run "SQLServerIniFile" first.
	}
	
	cDiskimage SQL2014ISO
	{
		ImagePath = 'C:\_install\SQLServer.iso'
		DriveLetter = 'S'
		DependsOn = "[File]SQLServerIniFile"
	}
	
	Log AfterDiskImageMount
	{
		# The message below gets written to the Microsoft-Windows-Desired State Configuration/Analytic log
		Message = "Finished Mounting the ISO for SQL 2014"
		DependsOn = "[cDiskimage]SQL2014ISO" # This means run "SQL2014ISO" first.
	}
	
	File MakeSQLDir
	{
		DestinationPath = "C:\Database\SQL\x86\DReplayClient\WorkingDir"
		Type = "Directory"
		Ensure = "Present"
		DependsOn = "[Log]AfterDiskImageMount" # This means run "AfterDiskImageMount" first.
	}
	
	File MakeCLTResultDir
	{
		DestinationPath = "C:\Database\Sql\x86\DReplayClient\ResultDir"
		Type = "Directory"
		Ensure = "Present"
		DependsOn = "[File]MakeSQLDir" # This means run "MakeSQLDir" first.
		}
	
	File MakeSQLLog
	{
		DestinationPath = "C:\_install\SqlInstall.log"
		Type = "File"
		Contents = ""
		Ensure = "Present"
		DependsOn = "[File]MakeCLTResultDir" # This means run "MakeCLTResultDir" first.
		}
	
	xPackage SQLStd2014
	{
		Name = "Microsoft Sql 2014 Standard"
		Path = "S:\Setup.exe"
		ProductID = "0EEBDCCA-EF5D-4896-9FEA-D7D410A57E8A"
		DependsOn = '[cDiskImage]SQL2014ISO','[WindowsFeature]NetFramework35Core','[WindowsFeature]NetFramework45Core'
		Ensure = "Present"
		LogPath = "C:\_install\sqlinstall.log"
		Arguments = "/ConfigurationFile=c:\_install\ConfigurationFile.ini"
		InstalledCheckRegKey = "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft SQL Server SQLServer2014"
		InstalledCheckRegValueName = "UninstallString"
		InstalledCheckRegValueData = '"C:\Program Files\Microsoft SQL Server\120\Setup Bootstrap\SQLServer2014\x64\SetupARP.exe"'
	}
}
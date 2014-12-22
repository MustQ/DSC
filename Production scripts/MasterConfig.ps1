#Creates a function that gathers all servers from a specific OU you choose
function GetAllServers
{
	import-module ActiveDirectory
	Get-ADComputer -SearchBase "OU=DSCdev,DC=cie,DC=caesarsint,DC=com" -Filter *

}

#creates a hashtable containing the data from the previous function you created
$AllServers = GetAllServers

#Create some functions to get variables about servers to add to hashtable
function Get-NodeEnvironment
{
	[OutputType([string])]
	param (
		[Parameter(Mandatory)]
		[string] $DistinguishedName
	)
	
	switch -Wildcard ($DistinguishedName)
	{
		'*OU=Stage*' { return 'Stage' }
		'*OU=QA*'    { return 'QA' }
		'*OU=DEV*'   { return 'DEV' }
		default { return 'Production' }
	}
}

function Get-NodeRole
{
	[OutputType([string])]
	param (
		[Parameter(Mandatory)]
		[string] $DistinguishedName
	)
	
	$cn = ($DistinguishedName -split ',')[0]
	
	switch -Wildcard ($cn)
	{
		'*IIS*' { return 'WebServer' }
		'*DC*'  { return 'ADDS' }
		'*SQL*' { return 'SQL' }
		default { return 'Vanila' }
	}
}

# Gather AllNodes and add an environment variable to it based on OU name.
$AllServerConfigData = @{
	AllNodes = @(
	foreach ($node in $AllServers)
	{
		@{
			NodeName = $node.Name
			NodeGUID = $node.objectGUID
			NodeEnvironment = Get-NodeEnvironment -DistinguishedName $node.DistinguishedName
			NodeRole = Get-NodeRole -DistinguishedName $node.DistinguishedName
		}
	}
	)
}

#This is a CUTE addition of a configuration in the main config file.
#It can exist here, but shouldn't and should be moved to a composite resource
Configuration WindowsBackup
{
	WindowsFeature WindowsSbackup
	{
		Name = "Windows-Server-Backup"
		Ensure = "Present"
		IncludeAllSubFeature = "$True"
	}
}

#Create the definition for the configuration
#Configuration Everything
#{
#	Import-DscResource -name *
#
#	Node $allnodes.where({ $_.NodeRole -eq "WebServer" }).NodeGuid {
#		MyIISPull AllWinFeatures { }
#	}
#	
#	Node $allnodes.where({ $_.NodeRole -eq "ADDS" }).NodeGuid {
#		RdsServer TerminalServices { }
#	}
#	
#	Node $allnodes.where({ $_.NodeRole -eq "SQL" }).NodeGuid {
#		rFileServer WinSharesYay { }
#		RdsServer TerminalServicesSQL{ }
#	}
#	
#	Node $allnodes.where({ $_.NodeEnvironment -eq "Production" }).NodeGuid {
#		WindowsBackup BackupProductionAlways { }
#	}
#}
#
#Configuration SQLinstall
#{
#	Import-DscResource -name *
#	Node Localhost {
#	#Node $allnodes.where({ $_.NodeRole -eq "SQL" }).NodeGuid {
#		rDSCLogging Analytic {
#			Logname = "Analytic",
#			SetStatus = "Enabled"
#		}
#	}
#}

configuration EnableAnalyticLog
{
	Import-DscResource -module xWinEventLog
		xWinEventLog WMILog
		{
			LogName            = "Microsoft-Windows-DSC/Analytic"
			IsEnabled          = $true			
			LogMode            = "circular"			
			MaximumSizeInBytes = 2mb			
		}			
}

Configuration Sql2014
{
	import-dscresource -name *
	Node $allnodes.where({ $_.NodeRole -eq "SQL" }).NodeGuid {
		rWinSql2014 InstallSQL { }
	}
}

Sql2014 -configurationdata $AllServerConfigData -outpath "C:\CieDSCCustom\WorkDir"

#$PackagePath = "\\dyul1dsc001\DSCShare\"
#$winsources = "\\DSCShare\WinSources\sources\sxs\"
#
##Execute the configuration to create MOF files
#Everything -ConfigurationData $AllServerConfigData -outpath "C:\CieDSCCustom\WorkDir"
#
#SQLInstall -ConfigurationData $AllServerConfigData -outpath "C:\CieDSCCustom\WorkDir"


#Create checksums and move files to where they need to be.
write-host "##################Creating checksums....######################"
New-DSCCheckSum -ConfigurationPath "C:\CieDSCCustom\WorkDir" -Verbose -Force

Write-host "##################Copying configs to the pull service configuration store###############################"
$sourcefiles = "C:\CieDSCCustom\WorkDir\*\*.mof*"
$sourcechecks = "C:\CieDSCCustom\WorkDir\*\*.checksum*"
$targetfiles = "$env:SystemDrive\Program Files\WindowsPowershell\DscService\Configuration"
copy-item -Recurse $sourcefiles $targetfiles -Force -Verbose
copy-item -Recurse $sourcechecks $targetfiles -force -Verbose

#Run the below to add a checksum to new modules you zip and place for download
#New-DSCCheckSum -ConfigurationPath "C:\Program Files\WindowsPowerShell\DscService\Modules" -Verbose -Force

Get-DscResource -Name | Read-Host "Please enter the DSC Package Name" | select -Expand Properties
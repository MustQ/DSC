Configuration rDSCLogging
{
	Param (
		[Parameter(Mandatory = $true)]
		[validateset('Analytic', 'Operational', 'Debug')]
		[string]$Logname,
		
		[Parameter(Mandatory = $true)]
		[string]$setstatus
	)
	
	switch ($setstatus)
	{
		'Enable' { $true }
		'Enabled' { $true }
		'Disable' { $false }
		'Disabled' { $false }
		default { $false }
	}
	Import-DscResource -module xWinEventLog
	
	$loghalf = "Microsoft-Windows-WMI-Activity/"
	#	node Localhost
	Node $allnodes.where({ $_.NodeRole -eq "SQL" }).Nodename {
		{
			xWinEventLog WMILog
			{
				Logname = $loghalf + $LogName
				IsEnabled = $setstatus
				Logmode = "Circular"
				MaximumSizeInBytes = 5mb
			}
		}
	}
}

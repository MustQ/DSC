<#	
	.NOTES
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2014 v4.1.75
	 Created on:   	12/10/2014 11:56 AM
	 Created by:   	ryoung
	 Organization: 	Caesars Interactive Entertainment
	 Filename:     	
	===========================================================================
	.DESCRIPTION
		A description of the file.
#>

Configuration Sql2014
{
	import-dscresource -name *
	Node $allnodes.where({ $_.NodeRole -eq "SQL" }).NodeGuid {
		rWinSql2014 InstallSQL { }
	}
}



$GetTargetResource = @'
#TODO - Add the logic for Get-TagetResource
#TODO - Always return a hashtable from this function
#TODO - Remove $Ensure if it is not required
function Get-TargetResource
{
    [OutputType([Hashtable])]
    param (
        [Parameter()]
        [ValidateSet('Present','Absent')]
        [string]
        $Ensure = 'Present'
    )

}
'@

$SetTargetResource = @'
#TODO - Add the logic for Set-TargetResource
#TODO - Do not return any value from this function
#TODO - Remove $Ensure if it is not required
function Set-TargetResource
{
    param (
        [Parameter()]
        [ValidateSet('Present','Absent')]
        [string]
        $Ensure = 'Present'
    )    
}
'@

$TestTargetResource = @'
#TODO - Add the logic for Test-TargetResource
#TODO - Return only boolean value from this function
#TODO - Remove $Ensure if it is not required
function Test-TargetResource
{
    [OutputType([boolean])]
    param (
        [parameter()]
        [ValidateSet('Present','Absent')]
        [string]
        $Ensure = 'Present'
    )
}
'@

$DSCCompleteResource = @'
#TODO - Add the logic for Get-TagetResource
#TODO - Always return a hashtable from this function
#TODO - Remove $Ensure if it is not required
function Get-TargetResource
{
    [OutputType([Hashtable])]
    param (
        [Parameter()]
        [ValidateSet('Present','Absent')]
        [string]
        $Ensure = 'Present'
    )

}

#TODO - Add the logic for Set-TargetResource
#TODO - Do not return any value from this function
#TODO - Remove $Ensure if it is not required
function Set-TargetResource
{
    param (
        [Parameter()]
        [ValidateSet('Present','Absent')]
        [string]
        $Ensure = 'Present'
    )    
}

#TODO - Add the logic for Test-TargetResource
#TODO - Return only boolean value from this function
#TODO - Remove $Ensure if it is not required
function Test-TargetResource
{
    [OutputType([boolean])]
    param (
        [parameter()]
        [ValidateSet('Present','Absent')]
        [string]
        $Ensure = 'Present'
    )
}
'@

$DSCClassResource = @'
#TODO - Update ClassName with your resource name
#TODO - Remove Ensure enum if not required
#ToDO - Add the logic required for Get, Set, and Test functions

enum Ensure
{
   Absent
   Present
}
 
[DscResource()]
class <ClassName>
{
    [Ensure] $Ensure
 
    [void] Set()
    {
    
    }
 
    [bool] Test()
    {

    }
 
    [Hashtable] Get()
    {

    }
}
'@
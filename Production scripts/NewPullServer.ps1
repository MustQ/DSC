###### The below script will deploy a new Pull server. It requires that the xPSDesiredStateConfiguration module exist in 
###### C:\program files\windowspowershell\modules\
###### It also requires that you install the MS Windows role for DSCconfiguration Service in server manager on the target server.
###### It creates a folder @ c:\program files\windowspowershell\DSCservice\ This folder is where all MOFs/Checksums are kept (under subdirectory Configuration)
###### MOF files in a pull server MUST be named with the GUID. 
###### Servers (henceforth known as nodes) need to be configured to connect to this pull server via a different script.
###### If necessary, modify the last line of this script to the name of the new DSC server
###### After running the below script, you need to "make it so". It will generate a MOF file. You must push this (start-DSCconfiguration) to the new pull server.
###### Version 1.0. Credited to various internet sources & RyanY@CIEmtl.

configuration PullServer
{
param
(
[string[]]$ComputerName = ‘localhost’
)

    Import-DSCResource -ModuleName xPSDesiredStateConfiguration

    Node $ComputerName
{
WindowsFeature DSCServiceFeature
{
Ensure = “Present”
Name   = “DSC-Service”
}

        xDscWebService PSDSCPullServer
{
Ensure                  = “Present”
EndpointName            = “PSDSCPullServer”
Port                    = 8080
PhysicalPath            = “$env:SystemDrive\inetpub\wwwroot\PSDSCPullServer”
CertificateThumbPrint   = “AllowUnencryptedTraffic”
ModulePath              = “$env:PROGRAMFILES\WindowsPowerShell\DscService\Modules”
ConfigurationPath       = “$env:PROGRAMFILES\WindowsPowerShell\DscService\Configuration”
State                   = “Started”
DependsOn               = “[WindowsFeature]DSCServiceFeature”
}

        xDscWebService PSDSCComplianceServer
{
Ensure                  = “Present”
EndpointName            = “PSDSCComplianceServer”
Port                    = 9080
PhysicalPath            = “$env:SystemDrive\inetpub\wwwroot\PSDSCComplianceServer”
CertificateThumbPrint   = “AllowUnencryptedTraffic”
State                   = “Started”
IsComplianceServer      = $true
DependsOn               = (“[WindowsFeature]DSCServiceFeature”,”[xDSCWebService]PSDSCPullServer”)
}
}
}

#This line actually calls the function above to create the MOF file.

PullServer –ComputerName dyul1dsc001.cie.caesarsint.com
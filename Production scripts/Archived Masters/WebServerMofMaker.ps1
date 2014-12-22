#Node can reference an AD OU, or a list of computers
#In the below example, we're using a hastable of GUIDs (unique object guids AND the GUID of an AD OU) as the target
#This will configure all the nodes (servers) to have a matching configuration

#Pull computer objects for AD
function GetComputers {
    import-module ActiveDirectory
    Get-ADComputer -SearchBase "OU=WebServers,OU=DSCdev,DC=cie,DC=caesarsint,DC=com" -Filter *
}
$computers = GetComputers

#Pull list of computers and GUIDs into hash table
$ConfigData = @{
    AllNodes = @(
        foreach ($node in $computers) {
            @{NodeName = $node.Name; NodeGUID = $node.objectGUID;}
        }
    )
}

#Set your configuration choices. In this case, install IIS, and replace the default website.
Configuration PullDemo {
    Node $Allnodes.NodeGUID {
                WindowsFeature IIS {
                    Ensure = 'Present'
                    Name = 'Web Server'
                }
                WindowsFeature ASP45 {
                    Ensure = 'Present'
                    Name = 'Web-Asp-Net45'
                }
                File NewWebContent {
                    Ensure = "Present"
                    Type = "Directory"
                    SourcePath = "\\dyul1dsc001\dscshare\WebSites\Sites"
                    DestinationPath = "C:\inetpub\wwwroot"
                    Recurse = $true
                    Force = $true
                }
    }
}

PullDemo -ConfigurationData $ConfigData -OutputPath "$Env:Temp\PullDemo"

write-host "Creating checksums..."
New-DSCCheckSum -ConfigurationPath "$Env:Temp\PullDemo" -OutPath "$Env:Temp\PullDemo" -Verbose -Force

write-host "Copying configurations to pull service configuration store..."
$SourceFiles = "$Env:Temp\PullDemo\*.mof*"
$TargetFiles = "$env:SystemDrive\Program Files\WindowsPowershell\DscService\Configuration"
Copy-Item $SourceFiles "C:\DSCmof\" -Force
Move-Item $SourceFiles $TargetFiles -Force
Remove-Item "$Env:Temp\PullDemo\"
#Below is a script that will look for a folder called "All resources" in C:\CieDSCCustom\Production Resources\
#It will then zip all subfolders with a name that represents the module version
#It will then create a checksum for the module, and copy/paste the modules with their checksums to the directory for DSC pull.
function Get-ModuleVersion
{
    param (
        [parameter(mandatory)]
        [validatenotnullorempty()]
        [string]
        $path, 
        [switch]
        $asVersion
    )
    $ModuleName = split-path $path -Leaf
    $ModulePSD1 = join-path $path "$ModuleName.psd1"
    
    Write-Verbose ''
    Write-Verbose "Checking for $ModulePSD1"
    if (Test-Path $ModulePSD1)
    {
        $psd1 = get-content $ModulePSD1 -Raw        
        $Version = (Invoke-Expression -Command $psd1)['ModuleVersion']
        Write-Verbose "Found version $Version for $ModuleName."
        Write-Verbose ''
        if ($asVersion) {
            [Version]::parse($Version)
        }
        else {            
            return $Version
        }   
    }
    else
    {
        Write-Warning "Could not find a PSD1 for $modulename at $ModulePSD1."        
    }
}
    

function Get-ModuleAuthor
{
    param (
        [parameter(mandatory)]
        [validatenotnullorempty()]        
        [string]
        $path
    )
    $ModuleName = split-path $path -Leaf
    $ModulePSD1 = join-path $path "$ModuleName.psd1"
    
    if (Test-Path $ModulePSD1)
    {
        $psd1 = get-content $ModulePSD1 -Raw        
        $Author = (Invoke-Expression -Command $psd1)['Author']
        Write-Verbose "Found author $Author for $ModuleName."
        return $Author
    }
    else
    {
        Write-Warning "Could not find a PSD1 for $modulename at $ModulePSD1."
    }    
}

New-Alias -Name Get-DscResourceVersion -Value Get-ModuleVersion -Force


function Test-ModuleVersion {
    param (
        [parameter(ValueFromPipeline, Mandatory)]
        [object]
        $InputObject, 
        [parameter(Mandatory, position = 0)]
        [string]
        $Destination
    )
    process {
        $DestinationModule = join-path $Destination $InputObject.name

        if (test-path $DestinationModule) {
            $CurrentModuleVersion = Get-ModuleVersion -Path $DestinationModule -asVersion
            $NewModuleVersion = Get-ModuleVersion -Path $InputObject.fullname -asVersion
            if (($CurrentModuleVersion -eq $null) -or ($NewModuleVersion -gt $CurrentModuleVersion)) {
                Write-Verbose "New module version is higher the the currently deployed module.  Replacing it."
                $InputObject
            }
            else {
                Write-Verbose "The current module is the same version or newer than the one in source control.  Not replacing it."
            }
        }
        else {
            Write-Verbose "No existing module at $DestinationModule."
            $InputObject
        }
    }

}

function New-DscZipFile
{
    param(
        ## The name of the zip archive to create
        [parameter(ValueFromPipelineByPropertyName)]
        [alias('Name')]
        [string]
        $ZipFile,

        ## The name of the folder to archive
        [parameter(ValueFromPipelineByPropertyName)]
        [alias('FullName')]
        [string]
        $Path,

        ## Switch to delete the zip archive if it already exists.
        [Switch] $Force
    )

    
    begin
    {
        [Byte[]] $zipHeader = 0x50,0x4B,0x05,0x06,0x00,0x00,0x00,0x00,
                                0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
                                0x00,0x00,0x00,0x00,0x00,0x00
    }
    process
    {
        ## Create the Zip File
        $Version = Get-DscResourceVersion $path
        $folderName = $ZipFile + "_"+ $Version
                
        $ZipName = $executionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath("$folderName.zip")
        Write-Verbose "Packing $path to to $ZipName."

        ## Check if the file exists already. If it does, check
        ## for -Force - generate an error if not specified.
        if(Test-Path $zipName)
        {
            if($Force)
            {
                Write-Verbose "Removing previous $zipname"
                Remove-Item $zipName -Force
            }
            else
            {
                throw "Item with specified name $zipName already exists."
            }
        }

        try
        {
            $shellObject = New-Object -comobject "Shell.Application"

            Write-Verbose "Creating new zip file $ZipName."
            $Writer = New-Object System.IO.FileStream $ZipName, "Create"
            $Writer.Write($zipheader, 0, 22)
            $Writer.Close();

            Start-Sleep -Seconds 1
            $ZipFileObject = $shellObject.namespace($ZipName)

            Write-Verbose "Loading the zip file contents."
            $ZipFileObject.CopyHere($Path)
            Start-Sleep -Seconds 5
        }
        finally
        {            
            ## Release the shell object
            $shellObject = $null
            $ZipFileObject = $null
        }
        get-item $ZipName
    }
}

cd C:\CieDSCCustom\WorkDir
rm -r C:\CieDSCCustom\WorkDir\*
Get-ChildItem -Path 'C:\CieDSCCustom\Production Resources\All Resources' -Directory | New-DscZipFile
write-host "############################### Moving the zipped files to program files!#######################"
Move-Item -Path 'C:\CieDSCCustom\WorkDir\*.zip' "C:\Program Files\WindowsPowerShell\DscService\Modules" -Force -Verbose
Write-Host "############################### Creating the checksums for the new files in program files!##################"
New-DSCCheckSum -ConfigurationPath "C:\Program Files\WindowsPowerShell\DscService\Modules" -Verbose -Force

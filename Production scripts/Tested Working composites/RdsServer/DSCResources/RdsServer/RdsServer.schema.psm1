configuration RdsServer 
{
    WindowsFeature RemoteDesktopServices
    {
        Name = " Remote-Desktop-Services"
        Ensure = "Present"
        IncludeAllSubFeature = "$True"
    }

        WindowsFeature TFTPClient
    {
        Name = "TFTP-Client"
        Ensure = "Present"
    }

    File  Notepadpp
    {
        DestinationPath = "C:\install\"
        Checksum = "ModifiedDate"
         Ensure = "Present" 
         Force =  "$true" 
         Recurse = "true" 
         SourcePath = "\\fileshare\pkg$\ISO\npp.6.6.9.Installer.exe"
         Type = "File" 
         MatchSource = "$true" 
    }

    Package Notepadpp
    {
        Name = "NotepadPlusPlus"
        Ensure = "Present"
        Path  = "$Env:SystemDrive\install\npp.6.6.9.Installer.exe"
        DependsOn = "[File]Notepadpp"
         ProductID = ""
    }
}
configuration myiispull 
{
    WindowsFeature File-And-Storage-Services
    {
        Name = "FileAndStorage-Services"
        Ensure = "Present"
    }
        WindowsFeature File-and-iSCSI-Services
    {
        Name = "File-Services"
        Ensure = "Present"
    }
         WindowsFeature File-Server
    {
        Name = "FS-FileServer"
        Ensure = "Present"
    }
     WindowsFeature DFS-Replication
    {
        Name = "FS-DFS-Replication"
        Ensure = "Present"
    }
     WindowsFeature Storage-Services
    {
        Name = "Storage-Services"
        Ensure = "Present"
    }
     WindowsFeature Web-Server-IIS
    {
        Name = "Web-Server"
        Ensure = "Present"
    }
     WindowsFeature Web-Server
    {
        Name = "Web-WebServer"
        Ensure = "Present"
    }
     WindowsFeature Common-HTTP-Features
    {
        Name = "Web-Common-Http"
        Ensure = "Present"
    }
     WindowsFeature Default-Document
    {
        Name = "Web-Default-Doc"
        Ensure = "Present"
    }
     WindowsFeature Directory-Browsing
    {
        Name = "Web-Dir-Browsing"
        Ensure = "Present"
    }
     WindowsFeature HTTP-Errors
    {
        Name = "Web-Http-Errors"
        Ensure = "Present"
    }
     WindowsFeature Static-Content
    {
        Name = "Web-Static-Content"
        Ensure = "Present"
    }
     WindowsFeature HTTP-Redirection
    {
        Name = "Web-Http-Redirect"
        Ensure = "Present"
    }
     WindowsFeature Health-and-Diagnostics
    {
        Name = "Web-Health"
        Ensure = "Present"
    }
     WindowsFeature HTTP-Logging
    {
        Name = "Web-Http-Logging"
        Ensure = "Present"
    }
     WindowsFeature Logging-Tools
    {
        Name = "Web-Log-Libraries"
        Ensure = "Present"
    }
     WindowsFeature Tracing
    {
        Name = "Web-Http-Tracing"
        Ensure = "Present"
    }
     WindowsFeature Performance
    {
        Name = "Web-Performance"
        Ensure = "Present"
    }
     WindowsFeature Static-Content-Compression
    {
        Name = "Web-Stat-Compression"
        Ensure = "Present"
    }
     WindowsFeature Dynamic-Content-Compression
    {
        Name = "Web-Dyn-Compression"
        Ensure = "Present"
    }
     WindowsFeature Security
    {
        Name = "Web-Security"
        Ensure = "Present"
    }
     WindowsFeature Request-Filtering
    {
        Name = "Web-Filtering"
        Ensure = "Present"
    }
     WindowsFeature Basic-Authentication
    {
        Name = "Web-Basic-Auth"
        Ensure = "Present"
    }
     WindowsFeature URL-Authorization
    {
        Name = "Web-Url-Auth"
        Ensure = "Present"
    }
     WindowsFeature Windows-Authentication
    {
        Name = "Web-Windows-Auth"
        Ensure = "Present"
    }
     WindowsFeature Application-Development
    {
        Name = "Web-App-Dev"
        Ensure = "Present"
    }
     WindowsFeature .NET-Extensibility-3.5
    {
        Name = "Web-Net-Ext"
        Ensure = "Present"
    }
     WindowsFeature .NET-Extensibility-4.5
    {
        Name = "Web-Net-Ext45"
        Ensure = "Present"
    }
     WindowsFeature Application-Initialization
    {
        Name = "Web-AppInit"
        Ensure = "Present"
    }
     WindowsFeature ASP
    {
        Name = "Web-ASP"
        Ensure = "Present"
    }
     WindowsFeature ASP.NET-3.5
    {
        Name = "Web-Asp-Net"
        Ensure = "Present"
    }
     WindowsFeature ASP.NET-4.5
    {
        Name = "Web-Asp-Net45"
        Ensure = "Present"
    }
     WindowsFeature CGI
    {
        Name = "Web-CGI"
        Ensure = "Present"
    }
     WindowsFeature ISAPI-Extensions
    {
        Name = "Web-ISAPI-Ext"
        Ensure = "Present"
    }
     WindowsFeature ISAPI-Filters
    {
        Name = "Web-ISAPI-Filter"
        Ensure = "Present"
    }
     WindowsFeature Server-Side-Includes
    {
        Name = "Web-Includes"
        Ensure = "Present"
    }
     WindowsFeature Management-Tools
    {
        Name = "Web-Mgmt-Tools"
        Ensure = "Present"
    }
     WindowsFeature IIS-Management-Console
    {
        Name = "Web-Mgmt-Console"
        Ensure = "Present"
    }
     WindowsFeature Management-Service
    {
        Name = "Web-Mgmt-Service"
        Ensure = "Present"
    }
     WindowsFeature .NET-Framework-3.5-Features
    {
        Name = "NET-Framework-Features"
        Ensure = "Present"
    }
     WindowsFeature .NET-Framework-3.5
    {
        Name = "NET-Framework-Core"
        Ensure = "Present"
    }
     WindowsFeature .NET-Framework-4.5-Features
    {
        Name = "NET-Framework-45-Features"
        Ensure = "Present"
    }
     WindowsFeature .NET-Framework-4.5
    {
        Name = "NET-Framework-45-Core"
        Ensure = "Present"
    }
     WindowsFeature ASP.NET-4.5Framework
    {
        Name = "NET-Framework-45-ASPNET"
        Ensure = "Present"
    }
     WindowsFeature WCF-Services
    {
        Name = "NET-WCF-Services45"
        Ensure = "Present"
    }
     WindowsFeature TCP-Port-Sharing
    {
        Name = "NET-WCF-TCP-PortSharing45"
        Ensure = "Present"
    }
     WindowsFeature Remote-Server-Administration-Tools
    {
        Name = "RSAT"
        Ensure = "Present"
    }
     WindowsFeature Role-Administration-Tools
    {
        Name = "RSAT-Role-Tools"
        Ensure = "Present"
    }
     WindowsFeature File-Services-Tools
    {
        Name = "RSAT-File-Services"
        Ensure = "Present"
    }
     WindowsFeature DFS-Management-Tools
    {
        Name = "RSAT-DFS-Mgmt-Con"
        Ensure = "Present"
    }
     WindowsFeature User-Interfaces-and-Infrastructure
    {
        Name = "User-Interfaces-Infra"
        Ensure = "Present"
    }
     WindowsFeature Graphical-Management-Tools-and-Infrastructure
    {
        Name = "Server-Gui-Mgmt-Infra"
        Ensure = "Present"
    }
     WindowsFeature Server-Graphical-Shell
    {
        Name = "Server-Gui-Shell"
        Ensure = "Present"
    }
     WindowsFeature Windows-PowerShell
    {
        Name = "PowerShellRoot"
        Ensure = "Present"
    }
     WindowsFeature Windows-PowerShell-3.0
    {
        Name = "PowerShell"
        Ensure = "Present"
    }
     WindowsFeature Windows-PowerShell-2.0-Engine
    {
        Name = "PowerShell-V2"
        Ensure = "Present"
    }
     WindowsFeature Windows-PowerShell-ISE
    {
        Name = "PowerShell-ISE"
        Ensure = "Present"
    }
     WindowsFeature WoW64-Support
    {
        Name = "WoW64-Support"
        Ensure = "Present"
    }
}
Configuration rFileServer
{
Import-DscResource -ModuleName xsmbshare

WindowsFeature Gui {
Ensure = "Present"
Name   = "Server-Gui-Shell"
}
WindowsFeature GuiMgmt {
Ensure = "Present"
Name   = "Server-Gui-Mgmt-Infra"
}
WindowsFeature FsFsFs {
Ensure = "Present"
Name   = "File-Services"
}
WindowsFeature Dedup {
Ensure = "Present"
Name   = "FS-Data-Deduplication"
}
WindowsFeature DFSname {
Ensure = "Present"
Name   = "FS-DFS-Namespace"
}
WindowsFeature DFSrep {
Ensure = "Present"
Name   = "FS-DFS-Replication"
}
WindowsFeature Resourceman {
Ensure = "Present"
Name   = "FS-Resource-Manager"
}
WindowsFeature Printserv {
Ensure = "Present"
Name   = "Print-Server"
}
xSmbShare Apps {
Name        = "Apps"
Path        = "c:\shares\Apps"
Description = "Branch Application Share"
Ensure      = "Present"
DependsOn   = "[File]AppFolder"
FullAccess  = "Everyone"
}
xSmbShare User {
Name        = "User$"
Path        = "c:\shares\User"
Description = "Branch User Share"
Ensure      = "Present"
DependsOn   = "[File]UserFolder"
FullAccess  = "Everyone"
}
xSmbShare Share {
Name        = "Share"
Path        = "c:\shares\Share"
Description = "Branch Group Share"
Ensure      = "Present"
DependsOn   = "[File]ShareFolder"
FullAccess  = "Everyone"
}
File AppFolder {
Ensure          = "Present"
DestinationPath = "c:\shares\Apps"
Type            = "Directory"
}
File UserFolder {
Ensure          = "Present"
DestinationPath = "c:\shares\User"
Type            = "Directory"
}
File Sharefolder {
Ensure          = "Present"
DestinationPath = "c:\shares\Share"
Type            = "Directory"
}
}
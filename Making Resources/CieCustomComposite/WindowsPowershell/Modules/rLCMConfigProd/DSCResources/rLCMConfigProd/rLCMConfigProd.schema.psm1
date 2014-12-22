Configuration rLCMConfigProd {
    {Node $allnodes.where{$_.NodeEnvironment -eq "Production"}.NodeName { 
LocalConfigurationManager 
        { 
            ConfigurationID = "$($Node.NodeGUID)"
            RefreshMode = "PULL";
            DownloadManagerName = "WebDownloadManager";
            RebootNodeIfNeeded = $true;
            RefreshFrequencyMins = 5;
            ConfigurationModeFrequencyMins = 10; 
            ConfigurationMode = "ApplyAndMonitor";
            DownloadManagerCustomData = @{ServerUrl = "http://dyul1dsc001.cie.caesarsint.com:8080/PSDSCPullServer.svc"; AllowUnsecureConnection = “TRUE”}
            }
        }
    }
} 

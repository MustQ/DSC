Configuration rLCMConfigQA {
    {Node $allnodes.where{$_.NodeEnvironment -eq "QA"}.NodeName {
LocalConfigurationManager 
        { 
            ConfigurationID = "$($Node.NodeGUID)"
            RefreshMode = "PULL";
            DownloadManagerName = "WebDownloadManager";
            RebootNodeIfNeeded = $true;
            RefreshFrequencyMins = 5;
            ConfigurationModeFrequencyMins = 10; 
            ConfigurationMode = "ApplyAndAutoCorrect";
            DownloadManagerCustomData = @{ServerUrl = "http://dyul1dsc001.cie.caesarsint.com:8080/PSDSCPullServer.svc"; AllowUnsecureConnection = “TRUE”}
                }
            }
        }
}
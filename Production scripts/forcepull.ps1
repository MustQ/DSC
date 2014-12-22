#The below will force the computer of the current powershell session to 
#attempt to pull its config. You can remote to another computer in powershell
#with enter-pssession $computername. Don't forget to exit after done!
$params = @{
    Namespace  = 'root/Microsoft/Windows/DesiredStateConfiguration'
    ClassName  = 'MSFT_DSCLocalConfigurationManager'
    MethodName = 'PerformRequiredConfigurationChecks'
    Arguments  = @{
        Flags = [uint32] 1
    }
}

Invoke-CimMethod @params
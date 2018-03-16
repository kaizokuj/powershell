Function Get-Uptime {

    $CurrentDate = Get-Date
    $LastBootUpTime = (gcim Win32_OperatingSystem).LastBootUpTime
    $Uptime = $CurrentDate - $LastBootUpTime
    $ProcessorLoad = Get-CimInstance -ClassName win32_processor | select -ExpandProperty LoadPercentage
    [System.Collections.ArrayList]$Users = query user

    Set-Alias -Name "Get-Uptime" -Value "uptime"

    Function CalculateUsers {

        $Users.RemoveAt(0)
        $Users.Count


    }


#Uptime output in linux: $CurrentTime up $days, $hour:$Minutes

$Output = $($CurrentDate.Toshorttimestring()) + " up " + $Uptime.Days + " days, " + $Uptime.Hours + ":" + $Uptime.Minutes + " , " + (CalculateUsers) + " users " + ", current CPU usage: " + $ProcessorLoad + "%"

    $Output

}
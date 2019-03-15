Function Get-WeekNumber {

    param (

        [Parameter(Mandatory=$false)][datetime]$Date = (get-date),
        [Parameter(Mandatory=$false)]$Week

    )

    if ($Week) {

        

    }

    else {

        $Week = get-date -Date $Date -UFormat %W
        Write-host "Week at set date: " $Week

    }

    

    
}
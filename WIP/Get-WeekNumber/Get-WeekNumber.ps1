Function Get-WeekNumber {

    param (

        [datetime]$Date = (get-date)

    )

    $Week = get-date -Date $Date -UFormat %W

    Write-host "Week at set date: " $Week
}
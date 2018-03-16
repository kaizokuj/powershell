Function Create-OutlookEvent {

    param (

        [Parameter(Mandatory=$True)]
        $Subject,
        [Parameter(Mandatory=$True)]
        $Body,
        [Parameter(Mandatory=$True)]
        [DateTime]$MeetingStart,
        [Int]$BusyStatus = 2,
        [Switch]$EnableReminder,
        [Switch]$AllDayEvent,
        [Int]$MeetingDuration = 30,
        [Int]$Reminder = 15,
        [String]$Location


    )

    $OutlookObject = New-Object -ComObject Outlook.Application
    $NewCalendarItem = $OutlookObject.Createitem('olAppointmentItem')

    if ($AllDayEvent) {

        $NewCalendarItem.AllDayEvent = $True

    }

    Else {

        $NewCalendarItem.Start = $MeetingStart
        $NewCalendarItem.Duration = $MeetingDuration

    }

    $NewCalendarItem.Subject = $Subject
    $NewCalendarItem.Body = $Body

    if ($EnableReminder) {

        $NewCalendarItem.ReminderSet = $true

    }

    $NewCalendarItem.ReminderMinutesBeforeStart = $Reminder
    $NewCalendarItem.BusyStatus = $BusyStatus
    $NewCalendarItem.Location = $Location
    
    $NewCalendarItem.Save()


}
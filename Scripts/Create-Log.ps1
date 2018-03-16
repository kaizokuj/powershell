function Create-Log {

    param (

        [ValidateSet("EmailAddress","User","User2")]
        [STRING[]]$Properties,
        $File = "C:\Logs.csv",
        [SWITCH]$OutCSV


    )

    function GetDate {
    
        Return (Get-Date).ToString()

}

$CurrentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name

$props = @{'Date'=$(GetDate);
           'CurrentUser'=$CurrentUser;
           'Credentials'=$Creds;
}

if ($Properties) {

    foreach ($Property in $Properties) {

        $props.Add("$Property", $($Property))

    }

}


$output = New-Object -TypeName PSObject -Property $props

    if ($OutCSV) {

        $Output | ConvertTo-Csv -NoTypeInformation | Out-File $File -Append

    }

    Else {

        $output

    }

}
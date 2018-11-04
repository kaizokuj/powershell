Function Test-Fever {

    param (

        [parameter(Mandatory=$true,Position=0)][single]$Temperature

    )

    $Fever = 37

    if ($Temperature -ge $Fever) {

        Write-Host -ForegroundColor Yellow "STATUS: Positive"

    }

    else {

        Write-Host -ForegroundColor Green "Status: Negative"

    }


}
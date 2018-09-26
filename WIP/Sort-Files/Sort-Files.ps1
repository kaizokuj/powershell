Function Sort-Files {

    param (

        [Parameter(Mandatory = $True)]$Path

    )

    #Define static variables
    [System.Collections.ArrayList]$Extensions = @('')
    $Items = Get-ChildItem -file -Path $Path

    foreach ($Item in $Items) {

        if (!($Extensions -contains $Item.Extension)) {

            $Extensions.Add($Item.Extension)
            mkdir -path $path\ -Name $Item.Extension


        }

        else {

            Write-host "Tough shit"

        }

        $Extensions


}

}

Sort-Files -Path "z:\"
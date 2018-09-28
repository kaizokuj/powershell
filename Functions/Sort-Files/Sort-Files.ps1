Function Sort-Files {

    [CmdletBinding(SupportsShouldProcess)]

    param (

        [Parameter(Mandatory = $True)]$Path

    )

    #Define static variables
    [System.Collections.ArrayList]$Extensions = @('')
    $Items = Get-ChildItem -file -Path $Path

    foreach ($Item in $Items) {

        if (!($Extensions -contains $Item.Extension)) {

            $Extensions.Add($Item.Extension) | out-null
            
            Try {

            mkdir -path $path\ -Name $Item.Extension -ErrorAction SilentlyContinue | Out-Null

            }

            Catch {

                Write-Host -ForegroundColor Yellow "Operation Cancelled: " $Error[0]

            }
        }

        else {

            

        }

        $destination = $Path + "\" + $Item.Extension + "\" + $Item.Name

        Try {

            Move-Item -Path $Item.FullName -Destination $destination -ErrorAction SilentlyContinue

        }

        Catch {

            Write-Host -ForegroundColor Yellow "Operation Cancelled: " $Error[0]

        }
        

}

}
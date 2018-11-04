function Get-MemberAge {

    param (

        [Parameter(Mandatory = $true)]
        [STRING]$File

    )


    $date = get-Date
    $Users= Import-Csv -Path $File
    
    
    foreach ($User in $users) {

      $dateminus = ($date).AddDays(-31)

        if (!($dateminus -lt $user.DateJoined)) {

            $user

        }
        
    }
    

} 

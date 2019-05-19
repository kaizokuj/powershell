Function List-PushbulletMessages {

    Param (

        [parameter(Mandatory=$False)]$AccessToken = (get-content -Path "$home\Pushbullet_Access_Token.txt"),
        [Parameter(Mandatory=$False)][Switch]$All = $False

    )

    if ($All) {

        try {

            Invoke-RestMethod -Method get -Uri "https://api.pushbullet.com/v2/pushes" -Headers @{Authorization = "Bearer o.a4d4IGqd4iNLj6ZAbkYBtJEXtRWcyuLL"} -ContentType application/JSON | select -exp pushes

        }

        catch {

            Write-Host "Something went wrong: " $Error[0]

        }
}

    else {

        try {

            Invoke-RestMethod -Method get -Uri "https://api.pushbullet.com/v2/pushes" -Headers @{Authorization = "Bearer o.a4d4IGqd4iNLj6ZAbkYBtJEXtRWcyuLL"} -ContentType application/JSON | select -exp pushes | where {$_.Active -notlike "False"}

        }

        catch {

            Write-Host "Something went wrong: " $Error[0]

        }
    }
}
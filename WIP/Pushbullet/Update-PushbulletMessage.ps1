Function Update-PushbulletMessage {

    Param (

        [parameter(Mandatory=$False)]$AccessToken = (get-content -Path "$home\Pushbullet_Access_Token.txt"),
        [parameter(Mandatory=$True)]$Iden

    )

    [bool]$dismissed = $True

    try {

        $Body = @{dismissed="$dismissed"}

        Invoke-RestMethod -Method post -Uri "https://api.pushbullet.com/v2/pushes/$Iden" -Headers @{Authorization = "Bearer $AccessToken"} -ContentType application/JSON -Body ($body | convertto-json)

    }

    catch {

        Write-Host "Something went wrong: " $Error[0]

    }
}
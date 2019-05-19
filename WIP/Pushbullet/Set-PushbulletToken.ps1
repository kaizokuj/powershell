Function Set-PushbulletToken {

    Param (

        [parameter(Mandatory=$True)]$AccessToken

    )

    Try {

        (New-Item -Path $home -Name "Pushbullet_Access_Token.txt" -Value $AccessToken).Attributes = "Hidden"

    }

    Catch {

        Write-Host "Something went wrong: " $error[0]

    }
}
Function Remove-PushbulletMessage {

    [CmdletBinding(DefaultParameterSetName='Single')]
    Param (

        [parameter(Mandatory=$False)]$AccessToken = (get-content -Path "$home\Pushbullet_Access_Token.txt"),
        [parameter(Mandatory=$True,ParameterSetName = "Single")]$Iden,
        [parameter(Mandatory=$False,ParameterSetName = "All")][SWITCH]$All

    ) 

    if ($All) {

        try {

            Invoke-RestMethod -Method delete -Uri "https://api.pushbullet.com/v2/pushes" -Headers @{Authorization = "Bearer $AccessToken"} -ContentType application/JSON
        
        }

        catch {

            Write-Host "Something went wrong: " $Error[0]

        }
    }

    else {

        try {

            Invoke-RestMethod -Method delete -Uri "https://api.pushbullet.com/v2/pushes/$Iden" -Headers @{Authorization = "Bearer $AccessToken"} -ContentType application/JSON 

        }

        catch {

            Write-Host "Something went wrong: " $Error[0]

        }
    }

}